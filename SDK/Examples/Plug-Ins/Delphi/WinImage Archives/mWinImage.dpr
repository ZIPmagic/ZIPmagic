{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

library mWinImage;

uses
  Controls,
  Graphics,
  Registry,
  Windows,
  SysUtils,
  Classes,
  LZExpand,
  uSharedDLL in 'uSharedDLL.pas',
  uEncodeSetup in 'uEncodeSetup.pas' {EncodeSetup},
  uEncode in 'uEncode.pas' {Encode},
  uCodex in 'uCodex.pas',
  XPTheme in 'XPTheme.pas',
  WIMADLL in 'wimadll.pas',
  uFormat in 'uFormat.pas' {FormatDisk},
  uGetDrive in 'uGetDrive.pas' {GetDrive},
  uLabel in 'uLabel.pas' {FloppyLabel},
  uDecodeSetup in 'uDecodeSetup.pas' {DecodeSetup},
  uDecode in 'uDecode.pas' {Decode};

var
  LastError: String;
  p: PChar;

{$R mCodex.res}
{$R *.res}

procedure GetArchiveError(var Error: PChar); export; stdcall;
begin
  MallocCopy(Error, LastError);
end;

procedure ShowPlugInAbout; export; stdcall;
var
  i: hIcon;
begin
  i := LoadIcon(hInstance, MakeIntResource(102));
  CodexAbout(i, 'WinImage Archives',
    'Copyright© 1992-2002 MimarSinan International',
    'Based on the WinImage SDK by Gilles Vollant.',
    'http://www.winimage.com',
    PChar('Version: ' + GetFileDisplayVersion(ModuleFile)));
end;

function EnumDir(Handle: hIMA; Display: String; SingleFile: String = ''): Integer;
var
  PDI: array of DirInfo;
  Count, i: Integer;
  ft: TFileTime;
  st: TSystemTime;
begin
  Result := -1;
  Count := GetNbEntryCurDir(Handle);
  Setlength(PDI, Count);
  GetDirInfo(Handle, PDirInfo(PDI), SORT_NONE);
  for i := 0 to Count -1 do
  begin
    if not PDI[i].fIsSubDir then
    begin
      if SingleFile <> '' then
      begin
        if PDI[i].longname = SingleFile then
        begin
          Result := PDI[i].uiPosInDir;
          Break;
        end;
      end
      else
      begin
        if Display = '' then
          sNames.Add(PDI[i].longname)
        else
          sNames.Add(Display + '\' + PDI[i].longname);
        sSize.Add(IntToStr(PDI[i].dwSize));
        sCompSize.Add(IntToStr(PDI[i].dwTrueSize));
        DosDateTimeToFileTime(PDI[i].DosDate, PDI[i].DosTime, ft);
        FileTimeToSystemTime(ft, st);
        sDateTime.Add(DateTimeToStr(SystemTimeToDateTime(st)));
      end;
    end
    else if not ((PDI[i].longname = '') or
      ((String(PDI[i].longname) = '.') or (PDI[i].longname = '..')))
    then if SingleFile = '' then
    begin
      ChszDir(Handle, PDI[i].longname);
      if Display = '' then EnumDir(Handle, PDI[i].longname)
        else EnumDir(Handle, Display + '\' + PDI[i].longname);
      ChDir(Handle, CDM_UPPER);
    end;
  end;
end;

function GetArchiveInfo(arcName: PChar; Silent: Boolean; var Names, Password,
  DateTimes, Sizes, CompSizes: PChar): Integer; export; stdcall;
var
  h: hIMA;
  dw: DWORD;
  b: PBool;
begin
  sNames.Clear; sPass.Clear; sSize.Clear; sCompSize.Clear; sDateTime.Clear;
  Names := nil; Password := nil; DateTimes := nil; Sizes := nil; CompSizes := nil;
  if not FileExists(arcName) then
  begin
    LastError := 'File not found';
    Result := -1;
    Exit;
  end;
  if (LowerCase(ExtractFileExt(arcName)) = '.iso') or (LowerCase(ExtractFileExt(arcName)) = '.cif') then
    h := CreateCDISOIma(PChar(arcName))
  else
  begin
    h := CreateMemFAThIMA;
    dw := 0;
    New(b);
    ReadImaFile(h, 0, arcName, b, dw);
    Dispose(b);
  end;
  ChDir(h, CDM_ROOT);
  EnumDir(h, '');
  DeleteIma(h);
  LastError := '';
  MallocCopy(Names, sNames.CommaText);
  MallocCopy(Password, sPass.CommaText);
  MallocCopy(DateTimes, sDateTime.CommaText);
  MallocCopy(Sizes, sSize.CommaText);
  MallocCopy(CompSizes, sCompSize.CommaText);
  Result := sNames.Count;
end;

procedure CodexStandardFunction(Index, Param1, Param2: PChar); stdcall; export;
var
  t: TextFile;
  h: hIMA;
  c, cX: Char;
  b: Byte;
  //s: String;
  pb: PBool;
  dw: DWORD;
  i: Integer;
  bX, bXX: Boolean;
begin
  ParamStr3 := Param1;
  ParamStr4 := Param2;
  FileMode := 0;
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, ArchiveFile);
  CloseFile(t);
  if Index = 'decode' then
  begin
    Decode := TDecode.Create(nil);
    Decode.ShowModal;
  end;
  if Index = 'decodesetup' then
  begin
    DecodeSetup := TDecodeSetup.Create(nil);
    DecodeSetup.ShowModal;
  end;
  if Index = 'encodesetup' then
  begin
    EncodeSetup := TEncodeSetup.Create(nil);
    EncodeSetup.ShowModal;
    Exit;
  end;
  if Pos('encode', Index) = 1 then
  begin
    EncodeExtension := Index;
    Delete(EncodeExtension, Pos('encode', Index), Length('encode'));
    Encode := TEncode.Create(nil);
    Encode.ShowModal;
  end;
  if Index = 'format' then
  begin
    FormatDisk := TFormatDisk.Create(nil);
    FormatDisk.ShowModal;
  end;
  if Index = 'label' then
  begin
    FloppyLabel := TFloppyLabel.Create(nil);
    FloppyLabel.ShowModal;
  end;
  if (Index = 'flush') or (Index = 'cache') then
  begin
    GetDrive := TGetDrive.Create(nil);
    if Index = 'flush' then GetDrive.Caption := 'Write to Floppy'
      else GetDrive.Caption := 'Read from Floppy';
    if GetDrive.ShowModal = mrCancel then Exit;
    h := CreateMemFathIMA;
    c := Drive[1];
    b := 0;
    for cX := 'A' to 'Z' do
    begin
      if c = cX then Break
        else b := b +1;
    end;
    if Index = 'flush' then
    begin
      New(pb);
      dw := 0;
      ReadImaFile(h, 0, PChar(ArchiveFile), pb, dw);
      Dispose(pb);
      if Quicken then
        WriteFloppy(h, 0, b, NOTHING, USED, NOTHING, 0)
      else
        WriteFloppy(h, 0, b, ALL, ALL, ALL, 0);
    end
    else
    begin
      bX := LowerCase(ExtractFileExt(ArchiveFile)) = '.imz';
      if Quicken then
      begin
        i := 1;
        bXX := True;
      end
      else
      begin
        i := 9;
        bXX := false;
      end;
      if Quicken then
        ReadFloppy(h, 0, b, USED)
      else
        ReadFloppy(h, 0, b, ALL);
      WriteImaFile(h, 0, PChar(ArchiveFile), bXX, bX, i, 0, nil);
    end;
    DeleteIma(h);
  end;
end;

procedure CodexRegisterPlugIn(Window, Instance: Integer;
  CommandLine: PChar; Show: Integer); stdcall; export;
var
  r: TRegistry;
  i: Integer;
  a: array[1..6] of String;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Window, PChar('Plug-in registration failed!' + #13#13 +
      'MimarSinan WinImage Archives Plug-In' + #13 + 'Registry not writable'),
      'MimarSinan Codex',  mb_Ok + mb_IconStop);
    Exit;
  end;
  a[1] := 'IMA';
  a[2] := 'IMZ';
  a[3] := 'VFD';
  a[4] := 'DSK';
  a[5] := 'ISO';
  a[6] := 'CIF';
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives', True);
  r.CloseKey;
  for i := 1 to 6 do
  begin
    r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.' + a[i], True);
    r.WriteString('Folder', ModuleFolder);
    r.WriteString('DLL', ModuleFolder + 'mWinImage.dll');
    r.CloseKey;
    r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.' + a[i] + '\Verbs', True);
    r.WriteString('decode', 'decode');
    r.WriteString('decodesetup', 'decodesetup');
    r.WriteString('info', '');
    if (a[i] <> 'ISO') and (a[i] <> 'CIF') then
    begin
      r.WriteString('encode', 'encode' + a[i]);
      r.WriteString('encodesetup', 'encodesetup');
      r.WriteString('cache', 'Read Image from Floppy$Read a physical floppy disk into the current floppy disk image');
      r.WriteString('flush', 'Write Image to Floppy$Write the floppy disk image to a physical floppy disk');
      r.WriteString('format', 'Format Floppy Disk$Format a physical floppy disk');
      r.WriteString('label', 'Set Disk Label$View and set the label of the floppy disk image');
    end
    else
      r.WriteString('format', 'Format Floppy Disk$Format a physical floppy disk');
    r.CloseKey;
  end;
  r.Free;
  BindPlugIn('WinImage Archives', '*.IMA');
  BindPlugIn('WinImage Archives', '*.IMZ');
  BindPlugIn('WinImage Archives', '*.ISO');
  BindPlugIn('WinImage Archives', '*.VFD');
  BindPlugIn('WinImage Archives', '*.DSK');
  BindPlugIn('WinImage Archives', '*.CIF');
  if CommandLine <> 'install' then
    MessageBox(Window, PChar('Plug-in registration succeeded!' + #13 +
      'MimarSinan WinImage Archives Plug-In'),
      'MimarSinan Codex',  mb_Ok + mb_IconInformation);
end;

procedure CodexUnRegisterPlugIn(Window, Instance: Integer;
  CommandLine: PChar; Show: Integer); stdcall; export;
var
  r: TRegistry;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Window, PChar('Plug-in unregistration failed!' + #13#13 +
      'MimarSinan WinImage Archives Plug-In' + #13 + 'Registry not writable'),
      'MimarSinan Codex',  mb_Ok + mb_IconStop);
    Exit;
  end;
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.IMA\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.IMA');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.IMZ\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.IMZ');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.ISO\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.ISO');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.VFD\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.VFD');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.DSK\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.DSK');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.CIF\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives\*.CIF');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\WinImage Archives');
  r.Free;
  UnBindPlugIn('WinImage Archives', '*.IMA');
  UnBindPlugIn('WinImage Archives', '*.IMZ');
  UnBindPlugIn('WinImage Archives', '*.ISO');
  UnBindPlugIn('WinImage Archives', '*.VFD');
  UnBindPlugIn('WinImage Archives', '*.DSK');
  UnBindPlugIn('WinImage Archives', '*.CIF');
  if CommandLine <> 'uninstall' then
    MessageBox(Window, PChar('Plug-in unregistration succeeded!' + #13 +
      'MimarSinan WinImage Archives Plug-In'),
      'MimarSinan Codex',  mb_Ok + mb_IconInformation);
end;

exports
  GetArchiveInfo,
  GetArchiveError,
  ShowPlugInAbout,
  CodexStandardFunction,
  CodexRegisterPlugIn,
  CodexUnRegisterPlugIn;

begin
  LastError := '';
  GetMem(p, 1024);
  GetModuleFileName(GetModuleHandle('mWinImage.dll'), p, 1024);
  ModuleFile := p;
  ModuleFolder := ExtractFilePath(p);
  FreeMem(p);
end.
