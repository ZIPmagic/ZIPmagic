unit ZIPmagicInclude;

interface

uses
  Registry, Windows, SysUtils, Classes, ShellAPI, ActiveX;

function GetUACDir: String;
function AssertDirectoryFormat(Path: String): String;
function DeAssertDir(Path: String): String;
function AssertDir(Path: String): String;
function ExtractFileNameOnly(Name: String): String;
function IsValidSaveName(var FileName: String): Boolean;
function PathFree(Path: String): Int64;
procedure StringToPChar(Source: String; var Target: PChar);
function GetFileVersion(Name: String; var Max, Min: Integer): Boolean;
function GetFileDisplayVersion(Name: String): String;
function LaunchAndWait(FileName, Parameters: String; Wait: Boolean): Boolean;
function mExtractFileExt(FileName: String): String;
function ElimDoubleQuotes(Path: String): String;
function IsRegistryWritable: Boolean;

{ Codex 2.0 }

procedure CodexBindPlugIn(Name, Format: String);
procedure CodexUnBindPlugIn(Name, Format: String);

{ Codex 4.0 }
function UnicodeSafeFileName(FileName: String): String;
function UnicodeToANSIFileName(FileToMatch: String): String;
function FindMatchingFileInUnicode(Path: String): String;

implementation

var
  RegWriteTest: Boolean = false;
  RegWriteValue: Boolean = false;

procedure CodexBindPlugIn(Name, Format: String);
var
  i: Integer;
  src, trg: TRegistry;
  srcVerbs, trgVerbs: TStringList;
begin
  src := TRegistry.Create;
  trg := TRegistry.Create;
  srcVerbs := TStringList.Create;
  trgVerbs := TStringList.Create;
  src.RootKey := HKEY_LOCAL_MACHINE;
  // Plug-Ins\DynaZIP\ZIP\Verbs
  src.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\' + Name + '\' + Format + '\Verbs', True);
  trg.RootKey := HKEY_LOCAL_MACHINE;
  // Bindings\ZIP
  trg.OpenKey('Software\MimarSinan\Codex\2.0\Bindings\' + Format, True);
  trg.CloseKey;
  { now bind the verbs }
  trg.OpenKey('Software\MimarSinan\Codex\2.0\Bindings\' + Format + '\Verbs\', True);
  src.GetValueNames(srcVerbs);
  trg.GetValueNames(trgVerbs);
  for i := 1 to srcVerbs.Count do
    if trgVerbs.IndexOf(srcVerbs[i -1]) = -1 then
      trg.WriteString(srcVerbs[i -1], Name);
  trg.CloseKey;
  src.CloseKey;
  src.Free;
  trg.Free;
  srcVerbs.Free;
  trgVerbs.Free;
end;

procedure CodexUnBindPlugIn(Name, Format: String);
var
  i: Integer;
  r: TRegistry;
  s: TStringList;
begin
  r := TRegistry.Create;
  s := TStringList.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  // check verbs
  r.OpenKey('Software\MimarSinan\Codex\2.0\Bindings\' + Format + '\Verbs\', True);
  r.GetValueNames(s);
  for i := 1 to s.Count do
    if r.ReadString(s[i -1]) = Name then
      r.DeleteValue(s[i -1]);
  r.GetValueNames(s);
  r.CloseKey;
  if s.Count = 0 then
    r.DeleteKey('Software\MimarSinan\Codex\2.0\Bindings\' + Format + '\Verbs');
  // check DLL binding
  r.OpenKey('Software\MimarSinan\Codex\2.0\Bindings\' + Format, True);
  r.CloseKey;
  if not r.KeyExists('Software\MimarSinan\Codex\2.0\Bindings\' + Format + '\Verbs') then
    r.DeleteKey('Software\MimarSinan\Codex\2.0\Bindings\' + Format);
  r.Free;
  s.Free;
end;

function IsRegistryWritable: Boolean;
var
  r: TRegistry;
  g: TGUID;
  s: String;
begin
  if RegWriteTest then
  begin
    Result := RegWriteValue;
    Exit;
  end;
  RegWriteTest := True;
  r := TRegistry.Create;
  try
    CoCreateGUID(g);
    s := GUIDToString(g);
    r.RootKey := HKEY_LOCAL_MACHINE;
    r.Access := KEY_READ or KEY_WRITE;
    if not r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved\' + s, True) then raise Exception.Create('Registry Not Writable');
    r.WriteString('Test', 'Value');
    r.CloseKey;
    if not r.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved\' + s) then raise Exception.Create('Registry Not Writable');
    Result := True;
    RegWriteValue := True;
  except
    r.Free;
    Result := false;
    RegWriteValue := false;
    Exit;
  end;
end;

function ElimDoubleQuotes(Path: String): String;
begin
  while Pos('"', Path) <> 0 do
    Delete(Path, Pos('"', Path), 1);
  Result := Path;
end;

function mExtractFileExt(FileName: String): String;
begin
  FileName := ElimDoubleQuotes(FileName);
  while Pos('.', FileName) <> 0 do
    System.Delete(FileName, 1, Pos('.', FileName));
  Result := FileName;
end;

function LaunchAndWait(FileName, Parameters: String; Wait: Boolean): Boolean;
var
  si: TStartupInfo;
  pi: TProcessInformation;
  FileApplication: String;
  FileParameters: String;
  arrayFileApplication: array[0..4096] of Char;
begin
  SetFileAPIsToAnsi;
  Result := false;
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  // first get associated executable name
  if AnsiUpperCase(mExtractFileExt(FileName)) = 'EXE' then
  begin
    FileApplication := FileName;
    FileParameters := '';
  end
  else
  begin
    if FindExecutable(PChar(FileName), PChar(ExtractFileDir(FileName)), arrayFileApplication) <= 32 then
      FileApplication := 'notepad.exe'
    else FileApplication := arrayFileApplication;
    FileParameters := '"' + FileName + '"';
  end;
  if Parameters <> '' then Parameters := ' ' + Parameters;
  if FileParameters <> '' then FileParameters := ' ' + FileParameters;
  if not CreateProcess(nil, PChar(FileApplication + FileParameters + Parameters),
    nil, nil, false, CREATE_NEW_CONSOLE,
    nil, nil, si, pi) then Exit;
  if Wait then WaitForSingleObject(pi.hProcess, INFINITE);
  CloseHandle(pi.hProcess);
  CloseHandle(pi.hThread);
  Result := True;
end;

function GetFileVersion(Name: String; var Max, Min: Integer): Boolean;
var
  i: Integer;
  c: Cardinal;
  p: Pointer;
  v: PVSFIXEDFILEINFO;
begin
  Result := false;
  // first get the file version info buffer size
  i := GetFileVersionInfoSize(PChar(Name), c);
  if i = 0 then Exit; // unsupported version info for this file!
  // next initialize the buffer
  GetMem(p, i);
  if not GetFileVersionInfo(PChar(Name), 0, i, p) then Exit; // error during version info fetch
  // now format the buffer and prepare for return
  if not VerQueryValue(p, '\', Pointer(v), c) then Exit; // error during version buffer filling
  Max := v.dwFileVersionMS;
  Min := v.dwFileVersionLS;
  Result := True;
  FreeMem(p);
end;

function GetFileDisplayVersion(Name: String): String;
var
  Max, Min: Integer;
begin
  GetFileVersion(Name, Max, Min);
  Result := IntToStr(Max shr 16) + '.' +
    IntToStr(Max and $ffff) + '.' + IntToStr(Min shr 16) + '.' +
    IntToStr(Min and $ffff);
end;

procedure StringToPChar(Source: String; var Target: PChar);
begin
  if Source = '' then Target := nil
  else
  begin
    GetMem(Target, Length(Source) +1);
    StrPCopy(Target, Source);
  end;
end;

function PathFree(Path: String): Int64;
var
  i: Integer;
begin
  if Pos('\\', Path) = 1 then
  begin
    Result := 1024 * 1024; // heuristic, assume always free space on network drive!!!
    Exit;
  end;
  i := Ord(UpCase(Path[1])) - 64;
  Result := DiskFree(i);
end;

function FindMatchingFileInUnicode(Path: String): String;
var
  h, hX: THandle;
  i: Integer;
  l: TStringList;
  fd: WIN32_FIND_DATAW;
  PathW, ParentPathW, FileSpecW: WideString;
  AnsiTest, AnsiTestEx: String;
  pszPathW: PWideChar;
  s: String;
begin
  // make compat folder spec
  if ExtractFileName(Path) = '' then
    Path := ExcludeTrailingPathDelimiter(Path)
  else
  // also make compat master path for parent folder if applicable! argh...direct hit to port nacelle!
    Path := AssertDir(UnicodeSafeFileName(ExtractFilePath(Path))) + ExtractFileName(Path);
  // resume
  Result := '';
  AnsiTestEx := Path;
  GetMem(pszPathW, (MAX_PATH +1) * 128);
  Path := IncludeTrailingPathDelimiter(ExtractFilePath(Path));
  PathW := Path;
  ParentPathW := IncludeTrailingPathDelimiter(ExtractFilePath(Path));
  FileSpecW := ExtractFileName(Path);
  { get the files themselves }
  h := FindFirstFileW(PWideChar(PathW + '*.*'), fd);
  if h = INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(h);
    Exit;
  end;
  repeat
    if (fd.cFileName <> String('.')) and (fd.cFileName <> '..') then
      //if (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        AnsiTest := Path + fd.cFileName;
        if AnsiTest = AnsiTestEx then
        begin
          GetMem(pszPathW, (MAX_PATH +1) * 128);
          GetShortPathNameW(PWideChar(ParentPathW + WideString(fd.cFileName)),
            pszPathW, (MAX_PATH +1) * 16);
          //MessageBoxW(0, pszPathW, 'pszPathW', 0);
          Result := pszPathW;
          FreeMem(pszPathW);
          Windows.FindClose(h);
          // re-route to alternate approach!!!
          if (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
          begin
            if UnicodeToANSIFileName(Result) <> '' then // this added as the latest fucking layer of makecompat per aslan asshole's RAR archive with genuine russian characters
              Result := UnicodeToANSIFileName(Result);
          end;
          Exit;
        end;
      end;
  until not FindNextFileW(h, fd);
  Windows.FindClose(h);
end;

function UnicodeToANSIFileName(FileToMatch: String): String;
var
  hW, hA: THandle;
  i: Integer;
  l: TStringList;
  fdW: WIN32_FIND_DATAW;
  fdA: WIN32_FIND_DATA;
  PathW: WideString;
  PathA: String;
  pszPathW: PWideChar;
  pszPath: String;
  s: String;
begin
  // make compat folder spec
  if ExtractFileName(FileToMatch) = '' then
    FileToMatch := ExcludeTrailingPathDelimiter(FileToMatch);
  // resume
  Result := '';
  PathA := IncludeTrailingPathDelimiter(ExtractFilePath(FileToMatch));
  PathW := PathA;
  { first iterate through subfolders }
  hW := FindFirstFileW(PWideChar(PathW + '*.*'), fdW);
  hA := FindFirstFileA(PAnsiChar(PathA + '*.*'), fdA);
  if (hA = INVALID_HANDLE_VALUE) or (hW = INVALID_HANDLE_VALUE) then
  begin
    Windows.FindClose(hA);
    Windows.FindClose(hW);
    Exit;
  end;
  repeat
    if (fdA.cFileName <> String('.')) and (fdA.cFileName <> '..') then
      //if (fdA.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        if fdA.cFileName = ExtractFileName(FileToMatch) then
        begin
          Result := PathA + fdW.cAlternateFileName;
          Exit;
        end;
      end;
    FindNextFileW(hW, fdW);
  until not FindNextFileA(hA, fdA);
  Windows.FindClose(hA);
  Windows.FindClose(hW);
end;

function CharToOEMEx(Char: String): String;
var
  p: PChar;
begin
  {if not AreFileApisAnsi then
    messagebox(0, 'not ansi', nil, 0);}
  SetFileAPIsToAnsi;
  Result := '';
  GetMem(p, Length(Char) *4 +1024);
  if Char <> '' then
  begin
    if not CharToOem(PChar(Char), p) then
      Result := ''
    else
      Result := Copy(p, 1, Length(p));
  end;
  FreeMem(p);
end;

function OEMToCharEx(OEM: String): String;
var
  p: PChar;
begin
  {if not AreFileApisAnsi then
    messagebox(0, 'not ansi', nil, 0);}
  SetFileAPIsToANSI;
  Result := '';
  GetMem(p, Length(OEM) *4 +1024);
  if OEM <> '' then
  begin
    if not OemToChar(PChar(OEM), p) then
      Result := ''
    else
      Result := Copy(p, 1, Length(p));
  end;
  FreeMem(p);
end;

function UnicodeSafeFileName(FileName: String): String;
var
  s, sX, sZ: String;
  pX: PChar;
begin
  if not (SysUtils.FileExists(FileName) or SysUtils.DirectoryExists(FileName)) then
    Result := FindMatchingFileInUnicode(FileName)
  else
  begin
    if AnsiPos('?', FileName) <> 0 then
      Result := UnicodeToANSIFileName(FileName)
    else
      Result := FileName; // fails on files that are unicode/multi-byte charset; AND in 8.3 format
  end;
  if Result = '' then
    Result := FileName; // account for bugs, mismatches; other random issues - for when the algorithm fails! also primarily for when the file does not already exist...
  { litmus test man! }
  sZ := CharToOEMEx(Result);
  sX := OEMToCharEx(sZ);
  if AnsiCompareText(sX, Result) <> 0 then
  begin
    GetMem(pX, MAX_PATH * 4);
    GetShortPathName(PChar(Result), pX, MAX_PATH);
    Result := pX;
    FreeMem(pX);
    //Result := FindMatchingFileInUnicode(Result);
  end;
end;

function IsValidSaveName(var FileName: String): Boolean;
var
  s: String;
begin
  Result := false;
  // is it empty string?
  if FileName = '' then Exit;
  // is there no path information?
  if ExtractFilePath(FileName) = FileName then Exit;
  // does the specified path exist?
  if not DirectoryExists(ExtractFilePath(FileName)) then
  begin
    // dir manip code
    FileName := AssertDir(UnicodeSafeFileName(ExtractFilePath(FileName))) + ExtractFileName(FileName);
    if not DirectoryExists(ExtractFilePath(FileName)) then Exit;
  end;
  // is the specified path writable?
  if PathFree(ExtractFilePath(FileName)) <= 0 then Exit;
  // check for valid name characters
  s := FileName;
  FileName := ExtractFileName(FileName);
  if Pos('\', FileName) <> 0 then Exit;
  if Pos('/', FileName) <> 0 then Exit;
  if Pos(':', FileName) <> 0 then Exit;
  if Pos('*', FileName) <> 0 then Exit;
  if Pos('?', FileName) <> 0 then Exit;
  if Pos('"', FileName) <> 0 then Exit;
  if Pos('<', FileName) <> 0 then Exit;
  if Pos('>', FileName) <> 0 then Exit;
  if Pos('|', FileName) <> 0 then Exit;
  FileName := s;
  // all checks succeed!
  Result := True;
end;

function ExtractFileNameOnly(Name: String): String;
var
  s: String;
begin
  Name := ExtractFileName(Name);
  s := ExtractFileExt(Name);
  Delete(Name, Pos(s, Name), Length(s));
  Result := Name;
end;

function AssertDir(Path: String): String;
begin
  Result := AssertDirectoryFormat(Path);
end;

function DeAssertDir(Path: String): String;
begin
  Result := ExcludeTrailingPathDelimiter(Path);
end;

function AssertDirectoryFormat(Path: String): String;
begin
  Result := IncludeTrailingPathDelimiter(Path);
end;

function GetUACDir: String;
var
  r: TRegistry;
begin
  Result := '';
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_READ;
  if r.OpenKeyReadOnly('SOFTWARE\MimarSinan\Codex\2.0') then
  begin
    if r.ValueExists('Shared') then
      Result := IncludeTrailingPathDelimiter(r.ReadString('Shared'));
    r.CloseKey;
  end;
  r.Free;
end;

end.
 