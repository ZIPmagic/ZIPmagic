{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uDecode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, LZExpand, ComCtrls, uSharedDLL, WIMADLL;

type
  TDecode = class(TForm)
    Label1: TLabel;
    Src: TLabel;
    Label2: TLabel;
    Trg: TLabel;
    Timer: TTimer;
    Progress: TProgressBar;
    Cancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure CancelClick(Sender: TObject);
  private
  public
    procedure Job; // non-threaded implementation
  end;

var
  Decode: TDecode;
  Cancelled: Boolean;
  Preserve: Boolean;
  Target: TStringList;
  Source, Path, Overwrite: String;
  JobStart: Boolean;

implementation

{$R *.DFM}

procedure TDecode.FormCreate(Sender: TObject);
var
  s: String;
  t: TextFile;
begin
  // read directives
  FileMode := 0;
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, Source);
  ReadLn(t, Path);
  Path := AssertDirectoryFormat(Path);
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then Target.Add(s);
  end;
  CloseFile(t);
  AssignFile(t, ParamStr4);
  Reset(t);
  ReadLn(t, s);
  if s = 'TRUE' then Overwrite := 'oaAsk';
  ReadLn(t, s);
  if s = 'TRUE' then Overwrite := 'oaAlways';
  ReadLn(t, s);
  if s = 'TRUE' then Overwrite := 'oaNever';
  ReadLn(t, s);
  if s = 'TRUE' then
  begin
    ReadLn(t, s);
    Path := AssertDirectoryFormat(Path + ExtractFileNameOnly(ExtractFileName(Source)) + s);
    ForceDirectories(Path);
  end
  else
    ReadLn(t, s); // skip the thing...
  ReadLn(t, s);
  Preserve := s = 'TRUE';
  CloseFile(t);
  // adjust UI
  Src.Caption := Source;
  Trg.Caption := 'Initializing...';
  // extract
  JobStart := True;
  Timer.Enabled := True;
end;

procedure TDecode.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := false;
  if JobStart then
  begin
    JobStart := false;
    Job;
  end;
end;

procedure TDecode.CancelClick(Sender: TObject);
begin
  Cancelled := True;
  Cancel.Enabled := false;
  Cancel.Caption := 'Wait';
  Application.ProcessMessages;
end;

procedure TDecode.Job;
var
  i: Integer;
  b: PBool;
  dw: DWORD;
  h: hIMA;
  s, sX: String;
begin
  // prep
  Cancelled := false;
  Cancel.Enabled := True;
  // initialize
  ForceDirectories(Path);
  Progress.Max := Target.Count;
  Progress.Min := 0;
  Progress.Position := 0;
  Application.ProcessMessages;
  // load image
  if (LowerCase(ExtractFileExt(Source)) = '.iso') or (LowerCase(ExtractFileExt(Source)) = '.cif') then
    h := CreateCDISOIma(PChar(Source))
  else
  begin
    h := CreateMemFAThIMA;
    dw := 0;
    New(b);
    ReadImaFile(h, 0, PChar(Source), b, dw);
    Dispose(b);
  end;
  // iterate and extract!
  for i := 1 to Target.Count do
  begin
    // get to root
    ChDir(h, CDM_ROOT);
    // formulate target file name and target path
    s := Target[i -1];
    if Preserve then
      sX := AssertDirectoryFormat(Path) + ExtractFilePath(Target[i -1])
    else
      sX := AssertDirectoryFormat(Path);
    ForceDirectories(sX);
    Trg.Caption := AssertDirectoryFormat(sX) + ExtractFileName(Target[i -1]);
    Application.ProcessMessages;
    if Cancelled then Break;
    // get to folder of archived file, one step at a time
    while Pos('\', s) <> 0 do
    begin
      ChszDir(h, PChar(Copy(s, 1, Pos('\', s) -1)));
      Delete(s, 1, Pos('\', s));
    end;
    // check overwrite
    if FileExists(sX) and (Overwrite = 'oaNever') then
    begin
    end
    else
    if FileExists(sX) and (Overwrite = 'oaAsk') then
    begin
      if MessageBox(Decode.Handle, PChar(sX), PChar('Overwrite File?'), mb_YesNo + mb_IconQuestion) = id_Yes then
        ExtractFile(h, EnumDir(h, '', s), PChar(sX), nil);
    end
    else
      ExtractFile(h, EnumDir(h, '', s), PChar(sX), nil);
    Progress.Position := Progress.Position +1;
    Application.ProcessMessages;
    if Cancelled then Break;
  end;
  DeleteIma(h);
  Application.Terminate;
end;

initialization
  Target := TStringList.Create;

finalization
  Target.Free;

end.
