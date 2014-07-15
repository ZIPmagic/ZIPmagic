program mcace;

uses
  mMist,
  Classes,
  Windows,
  SysUtils,
  uLocalize,
  ZIPmagicInclude;

var
  doLog: Boolean;
  Mist: Boolean;
  LogFile, Dirs, Targ, Command: String;
  Recurse, Normal: TStringList;
  Priority: Integer;
  t: Text;

  s: String;
  c: Cardinal;

begin
  if ParamStr(1) <> 'sevgi' then
  begin
    MessageBox(0, PChar(cInternal), nil, 0);
    Exit;
  end;
  if (not FileExists(ParamStr(2))) or (not FileExists(ParamStr(3))) then
  begin
    MessageBox(0, PChar(cBadDir), nil, 0);
    Exit;
  end;
  AssignFile(t, ParamStr(3));
  Reset(t);
  ReadLn(t, Priority); //priority
  ReadLn(t, Dirs);
  ReadLn(t, s);
  doLog := s <> '';
  if doLog then LogFile := s;
  ReadLn(t, s);
  Mist := s = 'TRUE';
  CloseFile(t);
  Recurse := TStringList.Create;
  Normal := TStringList.Create;
  AssignFile(t, ParamStr(2));
  Reset(t);
  repeat
    ReadLn(t, Targ);
    if LowerCase(ExtractFileExt(Targ)) <> '.ace' then Targ := Targ + '.ace';
    ReadLn(t, s);
    while s <> '$' do
    begin
      Recurse.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      Normal.Add(s);
      ReadLn(t, s);
    end;
    if Recurse.Count <> 0 then
    begin
      Command := Dirs;
      Insert('-r -y ', Command, 3);
      //Insert('-r -std -y ', Command, 3);
      Insert('"' + Targ + '" ', Command, 3);
      Recurse.SaveToFile(ExtractFilePath(ParamStr(0)) + 'mcace.tmp');
      Command := '"' + ExtractFilePath(ParamStr(0)) + 'ace32.exe" ' + Command + '@"' + ExtractFilePath(ParamStr(0)) + 'mcace.tmp"';
      if doLog then Command := Command + ' >' + LogFile;
      //MessageBox(0, PChar(Command), 'Recursive', 0);
      c := MimarSinanMist(BrandName + ' Ace', Command, 4, Priority, Mist);
      WaitforSingleObject(c, INFINITE);
    end;
    if Normal.Count <> 0 then
    begin
      Command := Dirs;
      Insert('-std -y ', Command, 3); // required for percent showing output and failed input redirection!
      Insert('"' + Targ + '" ', Command, 3);
      Normal.SaveToFile(ExtractFilePath(ParamStr(0)) + 'mcace.tmp');
      Command := '"' + ExtractFilePath(ParamStr(0)) + 'ace32.exe" ' + Command + '@"' + ExtractFilePath(ParamStr(0)) + 'mcace.tmp"';
      if doLog then Command := Command + ' >' + LogFile;
      //MessageBox(0, PChar(Command), 'Normal', 0);
      c := MimarSinanMist(BrandName + ' Ace', Command, 4, Priority, Mist);
      WaitforSingleObject(c, INFINITE);
    end;
  until EOF(t);
  CloseFile(t);
  Windows.DeleteFile(PChar(ExtractFilePath(ParamStr(0)) + 'mcace.tmp'));
end.
