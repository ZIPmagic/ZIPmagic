{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uDecode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, LZExpand, ComCtrls, uSharedDLL;

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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Decode: TDecode;
  Cancelled: Boolean;
  Source, Target, Path, Overwrite: String;

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
  ReadLn(t, Target);
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
  CloseFile(t);
  // adjust UI
  Src.Caption := Source;
  Trg.Caption := Path + Target;
  // extract
  Timer.Enabled := True;
end;

procedure TDecode.TimerTimer(Sender: TObject);
var
  p: Pointer;
  i, j: Integer;
  s: Integer;
  t: File;
  sof: TOFSTRUCT;
begin
  // prep
  Timer.Enabled := false;
  Cancelled := false;
  Cancel.Enabled := True;
  // check overwrite
  if FileExists(Path + Target) and (Overwrite = 'oaNever') then
  begin
    Application.Terminate;
    Exit;
  end;
  if FileExists(Path + Target) and (Overwrite = 'oaAsk') then
    if MessageBox(Decode.Handle, PChar(Path + Target), PChar('Overwrite File?'), mb_YesNo + mb_IconQuestion) = id_No then
    begin
      Application.Terminate;
      Exit;
    end;
  // work
  s := LZOpenFile(PChar(Source), sof, OF_READ or OF_SHARE_DENY_WRITE);
  AssignFile(t, Path + Target);
  ReWrite(t, 1);
  Progress.Max := LZSeek(s, 0, 2);
  Progress.Min := LZSeek(s, 0, 0);
  Progress.Position := 0;
  i := 8192;
  GetMem(p, 8192);
  while i = 8192 do
  begin
    i := LZRead(s, p, 8192);
    BlockWrite(t, p^, i, j);
    Progress.Position := Progress.Position +j;
    Application.ProcessMessages;
    if Cancelled then
    begin
      LZClose(s);
      CloseFile(t);
      DeleteFile(Path + Target);
      FreeMem(p);
      Application.Terminate;
    end;
  end;
  FreeMem(p);
  LZClose(s);
  CloseFile(t);
  Application.Terminate;
end;

procedure TDecode.CancelClick(Sender: TObject);
begin
  Cancelled := True;
  Cancel.Enabled := false;
  Cancel.Caption := 'Wait';
  Application.ProcessMessages;
end;

end.
