{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uSharedDLL;

interface

uses
  Windows, SysUtils, Registry;

var
  ModuleFile, ModuleFolder: String;
  ParamStr3, ParamStr4 : String;

(* General safety function, test for write before attempting a registry write session *)
function IsRegistryWritable: Boolean;

(* Copies a string into a PChar and automatically allocates required memory, nil aware *)
procedure MallocCopy(var Target: PChar; Source: String);

(* Takes the specified path name and appends a backslash if one is absent *)
function AssertDirectoryFormat(Path: String): String;

(* Extract the file name without extension *)
function ExtractFileNameOnly(Name: String): String;

(* WinAPI wrapper to simplify version obtaining procedures *)
function GetFileVersion(Name: String; var Max, Min: Integer): Boolean;

(* GetFileVersion wrapper optimized for text display *)
function GetFileDisplayVersion(Name: String): String;

implementation

var
  RegWriteTest: Boolean = false;
  RegWriteValue: Boolean = false;

function IsRegistryWritable: Boolean;
var
  r: TRegistry;
begin
  if RegWriteTest then
  begin
    Result := RegWriteValue;
    Exit;
  end;
  RegWriteTest := True;
  r := TRegistry.Create;
  try
    r.RootKey := HKEY_LOCAL_MACHINE;
    if not r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved\MSIN\Registry', True) then raise Exception.Create('Registry Not Writable');
    r.WriteString('Test', 'Value');
    r.CloseKey;
    if not r.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved\MSIN\Registry') then raise Exception.Create('Registry Not Writable');
    Result := True;
    RegWriteValue := True;
  except
    r.Free;
    Result := false;
    RegWriteValue := false;
    Exit;
  end;
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

procedure MallocCopy(var Target: PChar; Source: String);
begin
  if Source = '' then
  begin
    Target := nil;
    Exit;
  end;
  GetMem(Target, Length(Source) +1);
  StrCopy(Target, PChar(Source));
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

function AssertDirectoryFormat(Path: String): String;
begin
  if Path = '' then
  begin
    Result := '';
    Exit;
  end;
  if Path[Length(Path)] <> '\' then Path := Path + '\';
  Result := Path;
end;

end.
