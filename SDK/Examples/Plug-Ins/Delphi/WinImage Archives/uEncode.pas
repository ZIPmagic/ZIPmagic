{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uEncode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, LZExpand, ComCtrls, uSharedDLL, WIMADLL;

type
  TEncode = class(TForm)
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
  Encode: TEncode;
  Cancelled: Boolean;
  JobStart: Boolean;

  EncodeExtension: String;
  Target: String;
  Rec, Norm: TStringList;
  StorePath: Boolean;
  Compression: Integer;
  DoCompression: Boolean;

implementation

{$R *.DFM}

procedure TEncode.FormCreate(Sender: TObject);
var
  s: String;
  t: TextFile;
begin
  // read directives
  FileMode := 0;
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, Target);
  Target := AssertDirectoryFormat(ExtractFilePath(Target)) + ExtractFileNameOnly(Target);
  Target := Target + '.' + EncodeExtension;
  DoCompression := LowerCase(EncodeExtension) = 'imz';
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then Rec.Add(s);
  end;
  s := '';
  while not EOF(t) and (s <> '$') do
  begin
    ReadLn(t, s);
    if s <> '$' then Norm.Add(s);
  end;
  CloseFile(t);
  // read compression directives
  AssignFile(t, ParamStr4);
  Reset(t);
  ReadLn(t, Compression);
  ReadLn(t, s);
  StorePath := s = 'TRUE';
  CloseFile(t);
  // adjust UI
  Src.Caption := Target;
  Trg.Caption := 'Initializing...';
  // compress
  JobStart := True;
  Timer.Enabled := True;
end;

procedure TEncode.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := false;
  if JobStart then
  begin
    JobStart := false;
    Job;
  end;
end;

procedure TEncode.CancelClick(Sender: TObject);
begin
  Cancelled := True;
  Cancel.Enabled := false;
  Cancel.Caption := 'Wait';
  Application.ProcessMessages;
end;

procedure TEncode.Job;
var
  i, j: Integer;
  b: PBool;
  dw: DWORD;
  h: hIMA;
  s: String;
  l, Files: TStringList;
begin
  // prep
  Cancelled := false;
  Cancel.Enabled := True;
  // initialize
  l := TStringList.Create;
  Files := TStringList.Create;
  for i := 1 to Rec.Count do
  begin
    l.Clear;
    l := FindAllFiles(ExtractFilePath(Rec[i -1]), ExtractFileName(Rec[i -1]), True);
    for j := 1 to l.Count do
      Files.Add(l[j -1]);
  end;
  for i := 1 to Norm.Count do
  begin
    l.Clear;
    l := FindAllFiles(ExtractFilePath(Norm[i -1]), ExtractFileName(Norm[i -1]), false);
    for j := 1 to l.Count do
      Files.Add(l[j -1]);
  end;
  Progress.Max := Files.Count;
  Progress.Min := 0;
  Progress.Position := 0;
  Application.ProcessMessages;
  // load image or create new image on the fly...
  h := CreateMemFAThIMA;
  if FileExists(Target) then
  begin
    dw := 0;
    New(b);
    ReadImaFile(h, 0, PChar(Target), b, dw);
    Dispose(b);
  end
  else
    MakeEmptyImage(h, 6);
  // iterate and inject!
  New(b);
  for i := 1 to Files.Count do
  begin
    if StorePath then s := Files[i -1]
      else s := ExtractFileName(Files[i -1]);
    Trg.Caption := s;
    s := AssertDirectoryFormat(ExtractFilePath(s));
    if s <> '' then
      Delete(s, Pos(ExtractFileDrive(s), s), Length(ExtractFileDrive(s)) +1);
    if AssertDirectoryFormat(ExtractFileDrive(Files[i -1])) = AssertDirectoryFormat(s) then
      s := '';
    Application.ProcessMessages;
    if Cancelled then Break;
    ChDir(h, CDM_ROOT);
    while s <> '' do
    begin
      if not ChszDir(h, PChar(Copy(s, 1, Pos('\', s) -1))) then
      begin
        MkDir(h, PChar(Copy(s, 1, Pos('\', s) -1)));
        ChszDir(h, PChar(Copy(s, 1, Pos('\', s) -1)));
      end;
      Delete(s, 1, Pos('\', s));
    end;
    InjectFile(h, PChar(Files[i -1]), nil, b, PChar(ExtractFileName(Files[i -1])));
    Progress.Position := Progress.Position +1;
    Application.ProcessMessages;
    if Cancelled then Break;
  end;
  WriteImaFile(h, Encode.Handle, PChar(Target), True, DoCompression, Compression, 0, nil);
  Dispose(b);
  DeleteIma(h);
  l.Free;
  Files.Free;
  Application.Terminate;
end;

initialization
  Rec := TStringList.Create;
  Norm := TStringList.Create;

finalization
  Rec.Free;
  Norm.Free;

end.
