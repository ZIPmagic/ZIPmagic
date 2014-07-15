program mRarProtect;

uses
  Windows,
  SysUtils,
  mMist,
  uLocalize,
  ZIPmagicInclude;

const
  switch = 'rr ';

var
  s: String;
  t: TextFile;
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
  AssignFile(t, ParamStr(2));
  Reset(t);
  ReadLn(t, s);
  CloseFile(t);
  s := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Switch + ' "' + s + '"';
  c := MimarSinanMist(BrandName + ' Rar ' + cProtect, s, 1, True);
  WaitforSingleObject(c, INFINITE);
end.
