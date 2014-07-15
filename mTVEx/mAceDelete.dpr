program mAceDelete;

uses
  Windows,
  SysUtils,
  mMist,
  uLocalize,
  ZIPmagicInclude;

var
  Switch, s: String;
  Dirs, t: TextFile;
  c: Cardinal;

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
  AssignFile(Dirs, ParamStr(2));
  Reset(Dirs);
  ReadLn(Dirs, Switch);
  AssignFile(t, ExtractFilePath(ParamStr(0)) + 'mAceDelete.tmp');
  ReWrite(t);
  repeat
    ReadLn(Dirs, s);
    if s <> '$' then WriteLn(t, s);
  until EOF(Dirs);
  CloseFile(t);
  CloseFile(Dirs);
  Switch := '"' + ExtractFilePath(ParamStr(0)) + 'ace32.exe" d "' + Switch + '" @"'
    //+ ExtractFilePath(ParamStr(0)) + 'mAceDelete.tmp" -std -y'; - crash
    + ExtractFilePath(ParamStr(0)) + 'mAceDelete.tmp" -y';
  c := MimarSinanMist(BrandName + ' Ace ' + cDelete, Switch, 8, True);
  WaitforSingleObject(c, INFINITE);
  Windows.DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + 'mAceDelete.tmp'));
end.
