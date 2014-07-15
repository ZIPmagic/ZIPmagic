library mTVEx;

{$IMAGEBASE $32410000}

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  View-Project Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the DELPHIMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using DELPHIMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  XPTheme,
  Registry,
  Windows,
  SysUtils,
  Classes,
  Graphics,
  ZIPmagicInclude,
  uSharedDLL in 'uSharedDLL.pas',
  mrarprefs in 'mrarprefs.pas' {Rar},
  mrarexe in 'mrarexe.pas' {rar2exe},
  mrepairrar in 'mrepairrar.pas' {RepairRar},
  mAceComments in 'mAceComments.pas' {AceComments},
  maceexe in 'maceexe.pas' {ace2exe},
  maceprefs in 'maceprefs.pas' {Ace},
  mrepairace in 'mrepairace.pas' {RepairAce},
  mRarComments in 'mRarComments.pas' {RarComments},
  uLocalize in 'uLocalize.pas';

var
  FormatsFull: TStringList; // compression only formats, store in string list for convenience
  p: PChar; //temp for modulefolder

{$R mCodex.res}
{$R *.res}

procedure GetArchiveError(var Error: PChar); export; stdcall;
begin
  StringToPChar('', Error);
end;

procedure ShowPlugInAbout; export; stdcall;
var
  i: hIcon;
begin
  i := LoadIcon(hInstance, MakeIntResource(106));
  MessageBox(0, PChar('Extended Archives' + #13 +
    cBasedOn + ': WinAce, WinRar, StuffIt SDK.' + #13 +
    'http://www.zipmagic.co/'),
    PChar(cVersion + ': ' + GetFileDisplayVersion(ModuleFile)),
    mb_Ok + mb_IconInformation);
end;

function GetArchiveInfo(arcName: PChar; Silent: Boolean; var Names, Password,
  DateTimes, Sizes, CompSizes: PChar): Integer; export; stdcall;
begin
  Result := -1;
  Exit;
end;

procedure CodexStandardFunction(Index, Param1, Param2: PChar); stdcall; export;
begin
  ParamStr3 := Param1;
  ParamStr4 := Param2;
  if Index = 'encoderar' then
  begin
    LaunchAndWait(ModuleFolder + 'mcrar.exe', 'sevgi "' + ParamStr3
      + '" "' + ParamStr4 + '"', True);
  end;
  if Index = 'deleterar' then
  begin
    LaunchAndWait(ModuleFolder + 'mRarDelete.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'lockrar' then
  begin
    LaunchAndWait(ModuleFolder + 'mRarLock.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'protectrar' then
  begin
    LaunchAndWait(ModuleFolder + 'mRarProtect.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'testrar' then
  begin
    LaunchAndWait(ModuleFolder + 'mRarTest.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'encodeace' then
  begin
    LaunchAndWait(ModuleFolder + 'mcace.exe', 'sevgi "' + ParamStr3
      + '" "' + ParamStr4 + '"', True);
  end;
  if Index = 'deleteace' then
  begin
    LaunchAndWait(ModuleFolder + 'mAceDelete.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'lockace' then
  begin
    LaunchAndWait(ModuleFolder + 'mAceLock.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'protectace' then
  begin
    LaunchAndWait(ModuleFolder + 'mAceProtect.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'testace' then
  begin
    LaunchAndWait(ModuleFolder + 'mAceTest.exe', 'sevgi "' + ParamStr3
      + '"', True);
  end;
  if Index = 'encodesetuprar' then
  begin
    Rar := TRar.Create(nil);
    Rar.ShowModal;
    Rar.Free;
  end;
  if Index = 'encodesetupace' then
  begin
    Ace := TAce.Create(nil);
    Ace.ShowModal;
    Ace.Free;
  end;
  if Index = 'exerar' then
  begin
    rar2exe := Trar2exe.Create(nil);
    rar2exe.ShowModal;
    rar2exe.Free;
  end;
  if Index = 'exeace' then
  begin
    ace2exe := Tace2exe.Create(nil);
    ace2exe.ShowModal;
    ace2exe.Free;
  end;
  if Index = 'commentsrar' then
  begin
    RarComments := TRarComments.Create(nil);
    RarComments.ShowModal;
    RarComments.Free;
  end;
  if Index = 'commentsace' then
  begin
    AceComments := TAceComments.Create(nil);
    AceComments.ShowModal;
    AceComments.Free;
  end;
  if Index = 'repairrar' then
  begin
    RepairRar := TRepairRar.Create(nil);
    RepairRar.ShowModal;
    RepairRar.Free;
  end;
  if Index = 'repairace' then
  begin
    RepairAce := TRepairAce.Create(nil);
    RepairAce.ShowModal;
    RepairAce.Free;
  end;
end;

procedure RegisterFull(Archive: String);
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\Extended Archives\*.' + Archive, True);
  r.WriteString('DLL', ModuleFolder + 'mTVEx.dll');
  r.WriteString('Folder', AssertDirectoryFormat(ModuleFolder) + Archive);
  r.CloseKey;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\Extended Archives\*.' + Archive + '\Verbs', True);
  r.WriteString('encode', 'encode' + LowerCase(Archive));
  r.WriteString('encodesetup', 'encodesetup' + LowerCase(Archive));
  r.WriteString('delete' + LowerCase(Archive), mtvDelete + '$' + mtvDeleteHint);
  if Archive = 'RAR' then
  begin
    r.WriteString('lockrar', mtvLock + '$' + mtvLockHint);
    r.WriteString('protectrar', mtvProtect + '$' + mtvProtectHint);
    r.WriteString('testrar', mtvTestAdv + '$' + mtvTestAdvHint);
    r.WriteString('commentsrar', mtvComm + '$' + mtvCommHint);
    r.WriteString('repairrar', mtvRepair + '$' + mtvRepairHint);
    r.WriteString('exerar', mtvEXEAdv + '$' + mtvEXEAdvHint);
  end;
  if Archive = 'ACE' then
  begin
    r.WriteString('lockace', mtvLock + '$' + mtvLockHint);
    r.WriteString('protectace', mtvProtect + '$' + mtvProtectHint);
    r.WriteString('testace', mtvTestAdv + '$' + mtvTestAdvHint);
    //r.WriteString('exeace', mtvEXEAdv + '$' + mtvEXEAdvHint);
    r.WriteString('commentsace', mtvComm + '$' + mtvCommHint);
    r.WriteString('repairace', mtvRepair + '$' + mtvRepairHint);
  end;
  r.CloseKey;
  r.Free;
end;

procedure CodexRegisterPlugIn(Window, Instance: Integer;
  CommandLine: PChar; Show: Integer); stdcall; export;
var
  r: TRegistry;
  i: Integer;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Window, PChar(cPlugRegFailure + #13#13 +
      BrandName + ' Extended Archives ' + cPlugIn + #13 + cNoWriteReg),
      PChar(BrandName + ' ' + TechName),  mb_Ok + mb_IconStop);
    Exit;
  end;
  r := TRegistry.Create;
  //r.LazyWrite := false;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.OpenKey('Software\MimarSinan\Codex\2.0\Plug-Ins\Extended Archives', True);
  r.CloseKey;
  for i := 1 to FormatsFull.Count do
  begin
    RegisterFull(FormatsFull[i -1]);
    CodexBindPlugIn('Extended Archives', '*.' + FormatsFull[i -1]);
  end;
  if CommandLine <> 'install' then
    MessageBox(Window, PChar(cPlugRegSuccess + #13 +
      BrandName + ' Extended Archives ' + cPlugIn),
      PChar(BrandName + ' ' + TechName),  mb_Ok + mb_IconInformation);
end;

procedure CodexUnRegisterPlugIn(Window, Instance: Integer;
  CommandLine: PChar; Show: Integer); stdcall; export;
var
  i: Integer;
  r: TRegistry;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Window, PChar(cPlugUnRegFailure + #13#13 +
      BrandName + ' Extended Archives ' + cPlugIn + #13 + cNoWriteReg),
      PChar(BrandName + ' ' + TechName),  mb_Ok + mb_IconStop);
    Exit;
  end;
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  for i := 1 to FormatsFull.Count do
  begin
    r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\Extended Archives\' + FormatsFull[i -1]);
    CodexUnBindPlugIn('Extended Archives', '*.' + FormatsFull[i -1]);
  end;
  r.DeleteKey('Software\MimarSinan\Codex\2.0\Plug-Ins\Extended Archives');
  r.Free;
  if CommandLine <> 'uninstall' then
    MessageBox(Window, PChar(cPlugUnRegSuccess + #13 +
      BrandName + ' Extended Archives ' + cPlugIn),
      PChar(BrandName + ' ' + TechName),  mb_Ok + mb_IconInformation);
end;

exports
  GetArchiveInfo,
  GetArchiveError,
  ShowPlugInAbout,
  CodexStandardFunction,
  CodexRegisterPlugIn,
  CodexUnRegisterPlugIn;

begin
  FormatsFull := TStringList.Create;
  GetMem(p, 1024);
  GetModuleFileName(GetModuleHandle('mTVEx.dll'), p, 1024);
  ModuleFile := p;
  ModuleFolder := AssertDirectoryFormat(ExtractFilePath(p));
  if FileExists(ModuleFolder + 'rar.exe') then
    FormatsFull.Add('RAR');
  if FileExists(ModuleFolder + 'ace32.exe') then
    FormatsFull.Add('ACE');
  FreeMem(p);
end.
