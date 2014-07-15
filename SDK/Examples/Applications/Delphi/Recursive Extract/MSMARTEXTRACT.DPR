{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

program mSmartExtract;

uses
  XPTheme,
  Windows,
  SysUtils,
  Classes,
  uCodex in 'uCodex.pas';

{$R *.res}

var
  ArcCount: Integer;
  LevCount: Integer;
  extArc: TStringList;

function AssertDir(Path: String): String;
begin
  if Path = '' then Result := ''
  else
  begin
    if Path[Length(Path)] = '\' then Result := Path
      else Result := Path + '\';
  end;
end;

function IsArchiveSupported(Archive: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 1 to extArc.Count do
    if LowerCase(ExtractFileExt(Archive)) = '.' + LowerCase(extArc[i -1]) then
    begin
      Result := True;
      Exit;
    end;
end;

function FindAllArchives(Path: String): TStringList;
var
  h: THandle;
  b: Boolean;
  s: String;
  i: Integer;
  l: TStringList;
  wfd: WIN32_FIND_DATA;
begin
  Result := TStringList.Create;
  h := FindFirstFile(PChar(AssertDir(Path) + '*.*'), wfd);
  if h = INVALID_HANDLE_VALUE then Exit;
  repeat
    if wfd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0 then
    begin
      s := wfd.cFileName;
      if (s <> '.') and (s <> '..') then
      begin
        l := FindAllArchives(AssertDir(Path) + s);
        for i := 1 to l.Count do
          Result.Add(l[i -1]);
        l.Free;
      end;
    end
    else
      if IsArchiveSupported(AssertDir(Path) + wfd.cFileName) then Result.Add(AssertDir(Path) + wfd.cFileName);
    b := FindNextFile(h, wfd);
  until not b;
  Windows.FindClose(h);
end;

function RecursiveDecode(Archive: String; DeleteHost: Boolean): Integer;
var
  Names, pwdNames, DateTimes, Sizes, compSizes: PChar;
  s: String;
  i: Integer;
  l: TStringList;
  LevMax, LevNode: Integer;
begin
  Result := 1;
  if not IsArchiveSupported(Archive) then Exit;
  s := ExtractFileName(Archive);
  Delete(s, Pos(ExtractFileExt(s), s), Length(ExtractFileExt(s)));
  s := AssertDir(ExtractFilePath(Archive)) + s;
  if not DirectoryExists(s) then
    if not ForceDirectories(s) then Exit;
  QueryArchive(PChar(Archive), Names, pwdNames, DateTimes, Sizes, compSizes);
  ExtractArchive(PChar(Archive), PChar(s), Names, 'Default');
  ArcCount := ArcCount +1;
  if DeleteHost then DeleteFile(Archive);
  l := FindAllArchives(s);
  LevMax := 0;
  for i := 1 to l.Count do
  begin
    LevNode := RecursiveDecode(l[i -1], True);
    if LevNode > LevMax then LevMax := LevNode;
  end;
  Result := Result + LevMax;
  l.Free;
end;

begin
  if ParamStr(1) = '' then
  begin
    MessageBox(0, 'In Explorer, right-click an archive, and select "Recursive Extract" to use this tool.', 'Recursive Extract', mb_Ok + mb_IconStop);
    Exit;
  end;
  if not FileExists(ParamStr(1)) then
  begin
    MessageBox(0, 'In Explorer, right-click an archive, and select "Recursive Extract" to use this tool.', 'Recursive Extract', mb_Ok + mb_IconStop);
    Exit;
  end;
  ArcCount := 0;
  LoadPlugIns;
  extArc := TStringList.Create;
  extArc.CommaText := GetExtractableArchives;
  LevCount := RecursiveDecode(ParamStr(1), false);
  extArc.Free;
  FreePlugIns;
  MessageBox(0, PChar('Archives Extracted: ' + IntToStr(ArcCount) + #13 +
    'Archive Nesting Depth: ' + IntToStr(LevCount)) , 'Recursive Extract Finished', mb_Ok + mb_IconInformation);
end.
