{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

library mSZDD;

uses
  Graphics,
  Registry,
  Windows,
  SysUtils,
  Classes,
  LZExpand,
  uSharedDLL in 'uSharedDLL.pas',
  uDecodeSetup in 'uDecodeSetup.pas' {DecodeSetup},
  uDecode in 'uDecode.pas' {Decode},
  uCodex in 'uCodex.pas',
  XPTheme in 'XPTheme.pas';

var
  LastError: String;
  sNames, sPass, sSize, sCompSize, sDateTime: TStringList;
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
  i := LoadIcon(hInstance, MakeIntResource(106));
  CodexAbout(i, 'SZDD Extensions',
    'Copyright© 1992-2002 MimarSinan International',
    'Designed and engineered at'#13'MimarSinan Research Labs.',
    'http://www.mimarsinan.com',
    PChar('Version: ' + GetFileDisplayVersion(ModuleFile)));
end;

function GetArchiveInfo(arcName: PChar; Silent: Boolean; var Names, Password,
  DateTimes, Sizes, CompSizes: PChar): Integer; export; stdcall;
var
  p: PChar;
  f: File;
begin
  sNames.Clear; sPass.Clear; sSize.Clear; sCompSize.Clear; sDateTime.Clear;
  Names := nil; Password := nil; DateTimes := nil; Sizes := nil; CompSizes := nil;
  if not FileExists(arcName) then
  begin
    LastError := 'File not found';
    Result := -1;
    Exit;
  end;
  GetMem(p, MAX_PATH);
  if GetExpandedName(arcName, p) = LZERROR_BADVALUE then
  begin
    LastError := 'Not a Microsoft SZDD compressed file';
    Result := -1;
    Exit;
  end;
  sNames.Add(ExtractFileName(p));
  FreeMem(p);
  FileMode := 0;
  sDateTime.Add(DateTimeToStr(FileDateToDateTime(FileAge(arcName))));
  AssignFile(f, arcName);
  Reset(f, 1);
  sSize.Add(IntToStr(FileSize(f)));
  CloseFile(f);
  sCompSize.Add('0');
  LastError := '';
  MallocCopy(Names, sNames.CommaText);
  MallocCopy(Password, sPass.CommaText);
  MallocCopy(DateTimes, sDateTime.CommaText);
  MallocCopy(Sizes, sSize.CommaText);
  MallocCopy(CompSizes, sCompSize.CommaText);
  Result := sNames.Count;
end;

procedure CodexStandardFunction(Index, Param1, Param2: PChar); stdcall; export;
begin
  ParamStr3 := Param1;
  ParamStr4 := Param2;
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
end;

procedure CodexRegisterPlugIn(Window, Instance: Integer;
  CommandLine: PChar; Show: Integer); stdcall; export;
var
  r: TRegistry;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Window, PChar('Plug-in registration failed!' + #13#13 +
      'MimarSinan SZDD Extensions Plug-In' + #13 + 'Registry not writable'),
      'MimarSinan Codex',  mb_Ok + mb_IconStop);
    Exit;
  end;
  r := TRegistry.Create;
  //r.LazyWrite := false;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\SZDD Extensions', True);
  r.CloseKey;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\SZDD Extensions\*.??_', True);
  r.WriteString('Folder', ModuleFolder);
  r.WriteString('DLL', ModuleFolder + 'mSZDD.dll');
  r.CloseKey;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\SZDD Extensions\*.??_\Verbs', True);
  r.WriteString('decode', 'decode');
  r.WriteString('decodesetup', 'decodesetup');
  r.WriteString('info', '');
  r.CloseKey;
  r.Free;
  BindPlugIn('SZDD Extensions', '*.??_');
  if CommandLine <> 'install' then
    MessageBox(Window, PChar('Plug-in registration succeeded!' + #13 +
      'MimarSinan SZDD Extensions Plug-In'),
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
      'MimarSinan SZDD Extensions Plug-In' + #13 + 'Registry not writable'),
      'MimarSinan Codex',  mb_Ok + mb_IconStop);
    Exit;
  end;
  r := TRegistry.Create;
  //r.LazyWrite := false;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\SZDD Extensions\*.??_\Verbs');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\SZDD Extensions\*.??_');
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\SZDD Extensions');
  r.Free;
  UnBindPlugIn('SZDD Extensions', '*.??_');
  if CommandLine <> 'uninstall' then
    MessageBox(Window, PChar('Plug-in unregistration succeeded!' + #13 +
      'MimarSinan SZDD Extensions Plug-In'),
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
  sNames := TStringList.Create;
  sPass := TStringList.Create;
  sSize := TStringList.Create;
  sCompSize := TStringList.Create;
  sDateTime := TStringList.Create;
  GetMem(p, 1024);
  GetModuleFileName(GetModuleHandle('mSZDD.dll'), p, 1024);
  ModuleFile := p;
  ModuleFolder := ExtractFilePath(p);
  FreeMem(p);
end.
