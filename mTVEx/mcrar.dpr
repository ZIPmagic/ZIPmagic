program mcrar;

uses
  Classes,
  Windows,
  SysUtils,
  mMist,
  uLocalize,
  ZIPmagicInclude;

var
  Mist: Boolean;
  RarTempFile: String;
  doLog: Boolean;
  LogFile, Dirs, Targ, Command: String;
  Recurse, Normal: TStringList;
  t, tX: Text;

  s, sX: String;
  p: PChar;
  c: Cardinal;
  i: Integer;

  CommandList, RarFileList: TStringList;

{$R *.RES}

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
  GetMem(p, 1024);
  GetTempPath(1024, p);
  RarTempFile := AssertDirectoryFormat(p) + 'mrar.';
  FreeMem(p);
  i := 0;
  while FileExists(RarTempFile + IntToStr(i)) do
  begin
    i := i +1;
  end;
  AssignFile(t, ParamStr(3));
  Reset(t);
  ReadLn(t, Dirs);
  ReadLn(t, s);
  doLog := s <> '';
  if doLog then LogFile := s;
  ReadLn(t, s);
  Mist := s = 'TRUE';
  CloseFile(t);
  //messagebox(0, pchar(logfile), 'logfile', 0);
  CommandList := TStringList.Create;
  RarFileList := TStringList.Create;
  Recurse := TStringList.Create;
  Normal := TStringList.Create;
  AssignFile(t, ParamStr(2));
  Reset(t);
  repeat
    ReadLn(t, Targ);
    if LowerCase(ExtractFileExt(Targ)) <> '.rar' then Targ := Targ + '.rar';
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
      { no relative path storage...compress recursive files in a single loop }
      if Pos('-ep1', Dirs) = 0 then
      begin
        Command := Dirs;
        Insert('-r ', Command, 3);
        Insert('"' + Targ + '" ', Command, 3);
        Recurse.SaveToFile(RarTempFile);
        Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + '@"' + RarTempFile + '"';
        if doLog then Command := Command + ' >' + LogFile;
        //messagebox(0, pchar(rartempfile), 'rartempfile', 0);
        if Mist and (not doLog) then
        begin
          Recurse.SaveToFile(RarTempFile + IntToStr(RarFileList.Count));
          Command := Dirs;
          Insert('-r ', Command, 3);
          Insert('"' + Targ + '" ', Command, 3);
          Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + '@"' + RarTempFile + IntToStr(RarFileList.Count) + '"';
          CommandList.Add(Command);
          RarFileList.Add(RarTempFile + IntToStr(RarFileList.Count));
        end
        else
        begin
          c := MimarSinanMist(BrandName + ' Rar', Command, 4, Mist);
          WaitforSingleObject(c, INFINITE);
        end;
      end
      else
      { relative path storage indeed...utilize exclusive loop for SDRELATIVESTORESTART logic }
      for i := 1 to Recurse.Count do
      begin
        Command := Dirs;
        Insert('-r ', Command, 3);
        Insert('"' + Targ + '" ', Command, 3);
        AssignFile(tX, RarTempFile);
        ReWrite(tX);
        WriteLn(tX, Recurse[i -1]);
        CloseFile(tX);
        { if wildcard or recurse, then append path; which is ALWAYS for this one }
        sX := '"-ap' + ExtractFileName(DeAssertDir(ExtractFilePath(Recurse[i -1]))) + '" ';
        Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + sX + '@"' + RarTempFile + '"';
        if doLog then Command := Command + ' >' + LogFile;
        //messagebox(0, pchar(command), pchar(rartempfile), 0);
        if Mist and (not doLog) then
        begin
          AssignFile(tX, RarTempFile + IntToStr(RarFileList.Count));
          ReWrite(tX);
          WriteLn(tX, Recurse[i -1]);
          CloseFile(tX);
          Command := Dirs;
          Insert('-r ', Command, 3);
          Insert('"' + Targ + '" ', Command, 3);
          { if wildcard or recurse, then append path; which is ALWAYS for this one }
          sX := '"-ap' + ExtractFileName(DeAssertDir(ExtractFilePath(Recurse[i -1]))) + '" ';
          Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + sX + '@"' + RarTempFile  + IntToStr(RarFileList.Count) + '"';
          CommandList.Add(Command);
          RarFileList.Add(RarTempFile + IntToStr(RarFileList.Count));
        end
        else
        begin
          c := MimarSinanMist(BrandName + ' Rar', Command, 4, Mist);
          WaitforSingleObject(c, INFINITE);
        end;  
      end;
    end;
    if Normal.Count <> 0 then
    begin
      { first isolate and process wild-cards one by one }
      for i := Normal.Count downto 1 do
        if (Pos('*', Normal[i -1]) <> 0) or (Pos('?', Normal[i -1]) <> 0) then
        begin
          Command := Dirs;
          Insert('"' + Targ + '" ', Command, 3);
          AssignFile(tX, RarTempFile);
          ReWrite(tX);
          WriteLn(tX, Normal[i -1]);
          CloseFile(tX);
          { if wildcard or recurse, then append path; which is ALWAYS for this one }
          sX := '"-ap' + ExtractFileName(DeAssertDir(ExtractFilePath(Normal[i -1]))) + '" ';
          Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + sX + '@"' + RarTempFile + '"';
          if doLog then Command := Command + ' >' + LogFile;
          //messagebox(0, pchar(rartempfile), 'rartempfile', 0);
          if Mist and (not doLog) then
          begin
            AssignFile(tX, RarTempFile + IntToStr(RarFileList.Count));
            ReWrite(tX);
            WriteLn(tX, Normal[i -1]);
            CloseFile(tX);
            Command := Dirs;
            Insert('"' + Targ + '" ', Command, 3);
            { if wildcard or recurse, then append path; which is ALWAYS for this one }
            sX := '"-ap' + ExtractFileName(DeAssertDir(ExtractFilePath(Normal[i -1]))) + '" ';
            Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + sX + '@"' + RarTempFile + IntToStr(RarFileList.Count) + '"';
            CommandList.Add(Command);
            RarFileList.Add(RarTempFile + IntToStr(RarFileList.Count));
          end
          else
          begin
            c := MimarSinanMist(BrandName + ' Rar', Command, 4, Mist);
            WaitforSingleObject(c, INFINITE);
          end;  
          Normal.Delete(i -1);
        end;
      { then grab all others in a single pass! }
      if Normal.Count <> 0 then
      begin
        Command := Dirs;
        Insert('"' + Targ + '" ', Command, 3);
        Normal.SaveToFile(RarTempFile);
        Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + '@"' + RarTempFile + '"';
        if doLog then Command := Command + ' >' + LogFile;
        //messagebox(0, pchar(rartempfile), 'rartempfile', 0);
        if Mist and (not doLog) then
        begin
          Normal.SaveToFile(RarTempFile + IntToStr(RarFileList.Count));
          Command := Dirs;
          Insert('"' + Targ + '" ', Command, 3);
          Command := '"' + ExtractFilePath(ParamStr(0)) + 'rar.exe" ' + Command + '@"' + RarTempFile + IntToStr(RarFileList.Count) + '"';
          CommandList.Add(Command);
          RarFileList.Add(RarTempFile + IntToStr(RarFileList.Count));
        end
        else
        begin
          c := MimarSinanMist(BrandName + ' Rar', Command, 4, Mist);
          WaitforSingleObject(c, INFINITE);
        end;
      end;
    end;
  until EOF(t);
  CloseFile(t);
  if CommandList.Count <> 0 then
  begin
    c := MimarSinanMist(BrandName + ' Rar', CommandList, 4, 2{normal});
    //messagebox(0, pchar(commandlist.Text), nil, 0);
    WaitforSingleObject(c, INFINITE);
  end;
  for i := 1 to RarFileList.Count do
    Windows.DeleteFile(PChar(RarFileList[i -1]));
  Windows.DeleteFile(PChar(RarTempFile));
  CommandList.Free;
  RarFileList.Free;
end.
