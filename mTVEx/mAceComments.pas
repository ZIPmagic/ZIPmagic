unit mAceComments;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ZIPmagicInclude, mMist, uSharedDLL, uLocalize;

type
  TAceComments = class(TForm)
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
  //ReadSwitch = 'cw std';
  //WriteSwitch = 'cm std'; these likely crash ACE
  ReadSwitch = 'cw';
  WriteSwitch = 'cm';

var
  EXE: String;
  AceComments: TAceComments;
  AceFile: String;

  c: Cardinal;
  s: String;
  t: TextFile;

implementation

{$R *.DFM}

procedure TAceComments.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAceComments.FormCreate(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, AceFile);
  CloseFile(t);
  EXE := ModuleFolder;
end;

procedure TAceComments.ApplyClick(Sender: TObject);
var
  i: Integer;
begin
  AssignFile(t, EXE + 'mAceComment.tmp');
  ReWrite(t);
  for i := 1 to Comments.Lines.Count do
    WriteLn(t, Comments.Lines[i -1]);
  CloseFile(t);
  // also check if we can apply the -std- progress force switch
  //s := '"' + EXE + 'ace32.exe" ' + WriteSwitch + ' "' + AceFile + '" -z"' + EXE +'mAceComment.tmp" -std- -y'; - this crashes ACE
  s := '"' + EXE + 'ace32.exe" ' + WriteSwitch + ' "' + AceFile + '" -z"' + EXE +'mAceComment.tmp" -y';
  c := MimarSinanMist(BrandName + ' Ace ' + cComments, s, 2, True);
  WaitforSingleObject(c, INFINITE);
  Windows.DeleteFile(PChar(EXE + 'mAceComment.tmp'));
  ModalResult := mrOK;
end;

procedure TAceComments.FormShow(Sender: TObject);
begin
  AceComments.Caption := BrandName + ' Ace ' + cComments;
  Label1.Caption := cCommentsHint;
  Apply.Caption := cApply;
  Cancel.Caption := cCancel;
  Application.ProcessMessages;
  Windows.DeleteFile(PChar(EXE + 'mAceComment.tmp'));
  //s := '"' + EXE + 'ace32.exe" ' + ReadSwitch + ' "' + AceFile + '" "' + EXE + 'mAceComment.tmp" -std- -y'; - this crashes ACE
  s := '"' + EXE + 'ace32.exe" ' + ReadSwitch + ' "' + AceFile + '" "' + EXE + 'mAceComment.tmp" -y';
  c := MimarSinanMist(BrandName + ' Ace ' + cComments, s, 2, True);
  WaitforSingleObject(c, INFINITE);
  if not FileExists(EXE + 'mAceComment.tmp') then Comments.Text := ''
  else
  begin
    AssignFile(t, EXE + 'mAceComment.tmp');
    Reset(t);
    repeat
      ReadLn(t, s);
      Comments.Lines.Add(s);
    until EOF(t);
    CloseFile(t);
  end;
end;

end.
