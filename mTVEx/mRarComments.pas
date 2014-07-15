unit mRarComments;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ZIPmagicInclude, mMist, uSharedDLL, uLocalize;

type
  TRarComments = class(TForm)
    Label1: TLabel;
    Comments: TMemo;
    Apply: TButton;
    Cancel: TButton;
    procedure CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  ReadSwitch = 'cw';
  WriteSwitch = 'c -z';

var
  EXE: String;
  RarComments: TRarComments;
  RarFile: String;

  c: Cardinal;
  s: String;
  t: TextFile;

implementation

{$R *.DFM}

procedure TRarComments.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRarComments.FormCreate(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, RarFile);
  CloseFile(t);
  EXE := ModuleFolder;
end;

procedure TRarComments.ApplyClick(Sender: TObject);
var
  i: Integer;
begin
  AssignFile(t, EXE + 'mRarComment.tmp');
  ReWrite(t);
  for i := 1 to Comments.Lines.Count do
    WriteLn(t, Comments.Lines[i -1]);
  CloseFile(t);
  s := '"' + EXE + 'rar.exe" ' + WriteSwitch + '"' + EXE + 'mRarComment.tmp" "' + RarFile + '"';
  c := MimarSinanMist(BrandName + ' Rar ' + cComments, s, 2, True);
  WaitforSingleObject(c, INFINITE);
  Windows.DeleteFile(PChar(EXE + 'mRarComment.tmp'));
  ModalResult := mrOK;
end;

procedure TRarComments.FormShow(Sender: TObject);
begin
  RarComments.Caption := BrandName + ' Rar ' + cComments;
  Apply.Caption := cApply;
  Cancel.Caption := cCancel;
  Label1.Caption := cCommentsHint;
  Windows.DeleteFile(PChar(EXE + 'mRarComment.tmp'));
  s := '"' + EXE + 'rar.exe" ' + ReadSwitch + ' "' + RarFile + '" "' + EXE + 'mRarComment.tmp"';
  c := MimarSinanMist(BrandName + ' Rar ' + cComments, s, 2, True);
  WaitforSingleObject(c, INFINITE);
  if not FileExists(EXE + 'mRarComment.tmp') then Comments.Text := ''
  else
  begin
    AssignFile(t, EXE + 'mRarComment.tmp');
    Reset(t);
    repeat
      ReadLn(t, s);
      Comments.Lines.Add(s);
    until EOF(t);
    CloseFile(t);
  end;
end;

end.
 
