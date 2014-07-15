program mRarDelete;

uses
  Windows,
  SysUtils,
  mMist,
  uLocalize,
  ZIPmagicInclude;

var
  RarTempFile: String;
  i: Integer;
  p: PChar;

  Switch, s: String;
  Dirs, t: TextFile;
  c: Cardinal;

{$R *.RES}

begin
  if ParamStr(1) <> 'sevgi' then
  begin
    MessageBox(0, PChar(cInternal), nil, 0);
    Exit;
  end;
  if not FileExists(ParamStr(2)) then
  begin
    MessageBox(0, PChar(cBadDir), nil, 0);
    Exit;
  end;
  GetMem(p, 1024);
  GetTempPath(1024, p);
  RarTempFile := AssertDirectoryFormat(p) + 'mrar.';
  FreeMem(p);
  i := 0;
  while FileExists(RarTempFile + IntToStr(i)) do
  begin
    i := i +1;
  end;
  AssignFile(Dirs, ParamStr(2));
  Reset(Dirs);
  ReadLn(Dirs, Switch);
  AssignFile(t, RarTempFile);
  ReWrite(t);
  repeat
    ReadLn(Dirs, s);
    if s <> '$' then WriteLn(t, s);
  until EOF(Dirs);
  CloseFile(t);
  CloseFile(Dirs);
  Switch := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" d "' + Switch + '" @"'
    + RarTempFile + '"';
  c := MimarSinanMist(BrandName + ' Rar ' + cDelete, Switch, 8, True);
  WaitforSingleObject(c, INFINITE);
  Windows.DeleteFile(PChar(RarTempFile));
end.
