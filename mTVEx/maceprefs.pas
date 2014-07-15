unit maceprefs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, uSharedDLL,
  Registry, ImgList, ZIPmagicInclude, uLocalize, Buttons;

type
  TAce = class(TForm)
    Notes: TNotebook;
    Action: TComboBox;
    Label1: TLabel;
    Timer: TTimer;
    Path: TCheckBox;
    Label5: TLabel;
    interactive: TRadioButton;
    Log: TRadioButton;
    LogText: TEdit;
    bLogText: TButton;
    SaveLog: TSaveDialog;
    Password: TCheckBox;
    PassText: TEdit;
    Span: TCheckBox;
    Label7: TLabel;
    OK: TButton;
    Cancel: TButton;
    Apply: TButton;
    Bevel1: TBevel;
    Label2: TLabel;
    Rate: TTrackBar;
    Label3: TLabel;
    Label8: TLabel;
    Dictionary: TTrackBar;
    Label9: TLabel;
    Solid: TCheckBox;
    Label10: TLabel;
    Recovery: TCheckBox;
    SpanSize: TEdit;
    Label11: TLabel;
    SpanPanel: TPanel;
    SizeSpan: TRadioButton;
    AutoSpan: TRadioButton;
    Label4: TLabel;
    Priority: TComboBox;
    Version: TCheckBox;
    Label6: TLabel;
    Mist: TCheckBox;
    Profile: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure bLogTextClick(Sender: TObject);
    procedure LookOutButton1Click(Sender: TObject);
    procedure LookOutButton2Click(Sender: TObject);
    procedure LookOutButton3Click(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure LookOutButton4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ace: TAce;

implementation

{$R *.DFM}

(* Cut out all parts of "FROM" upto and including "CUT", leave chars up to and excluding "LEAVETILL" *)
function CutOut(From, Cut, LeaveTill: String): String;
begin
  Delete(From, 1, Pos(Cut, From) -1);
  Delete(From, 1, Length(Cut));
  Delete(From, Pos(LeaveTill, From), 999);
  Result := From;
end;

procedure TAce.FormCreate(Sender: TObject);
var
  t: TextFile;
  i, j: Integer;
  s: String;
begin
  Profile.Caption := ExtractFileNameOnly(ParamStr3);
  if FileExists(ParamStr3) then
  begin
    AssignFile(t, ParamStr3);
    Reset(t);
    ReadLn(t, i);
    Priority.ItemIndex := i;
    ReadLn(t, s);
    case s[1] of
      'a': Action.ItemIndex := 0;
      'm': Action.ItemIndex := 1;
      'u': Action.ItemIndex := 2;
      'f': Action.ItemIndex := 3;
    end;
    Rate.Position := StrToInt(CutOut(s, '-m', ' '));
    i := StrToInt(CutOut(s, '-d', ' '));
    j := 0;
    repeat
      j := j + 1;
      i := i div 2;
    until i = 16;
    Dictionary.Position := j;
    Solid.Checked := Pos('-s ', s) <> 0;
    Version.Checked := Pos('-c2 ', s) <> 0;
    Password.Checked := Pos('-p', s) <> 0;   // prevent conflict with "ep"
    if Password.Checked then
      PassText.Text := CutOut(s, '-p', ' ')
    else
      PassText.Text := '';
    Path.Checked := (Pos('-ep ', s) = 0);
    Recovery.Checked := Pos('-rr', s) <> 0;
    AutoSpan.Checked := Pos('-v ', s) <> 0;
    SizeSpan.Checked := Pos('-v', s) <> 0;
    if SizeSpan.Checked then
      SpanSize.Text := CutOut(s, '-v', ' ')
    else
      SpanSize.Text := '1024';
    Span.Checked := AutoSpan.Checked or SizeSpan.Checked;
    if not Span.Checked then AutoSpan.Checked := True;
    Log.Checked := Pos('-y', s) <> 0;
    ReadLn(t, s);
    LogText.Text := s;
    ReadLn(t, s);
    Mist.Checked := s = 'TRUE';
    CloseFile(t);
  end
  else
  begin // default values
    Action.ItemIndex := 0;
    Priority.ItemIndex := 2;
    Profile.Caption := Profile.Caption + ' ' + cNew;
  end;
end;

procedure TAce.TimerTimer(Sender: TObject);
begin
  PassText.Enabled := Password.Checked;
  LogText.Enabled := Log.Checked;
  bLogText.Enabled := Log.Checked;
  SpanSize.Enabled := SizeSpan.Checked;
end;

procedure TAce.bLogTextClick(Sender: TObject);
begin
  if SaveLog.Execute then LogText.Text := SaveLog.FileName;
end;

procedure TAce.LookOutButton1Click(Sender: TObject);
begin
  Notes.ActivePage := 'General';
end;

procedure TAce.LookOutButton2Click(Sender: TObject);
begin
  Notes.ActivePage := 'Switches';
end;

procedure TAce.LookOutButton3Click(Sender: TObject);
begin
  Notes.ActivePage := 'Span';
end;

procedure TAce.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAce.ApplyClick(Sender: TObject);
var
  t: TextFile;
  i, j: Integer;
begin
  AssignFile(t, ParamStr3);
  ReWrite(t);
  WriteLn(t, Priority.ItemIndex);
  case Action.ItemIndex of
    0: Write(t, 'a ');
    1: Write(t, 'm ');
    2: Write(t, 'u ');
    3: Write(t, 'f ');
  end;
  Write(t, '-m', Rate.Position, ' ');
  i := 16;
  for j := 1 to Dictionary.Position do
    i := i * 2;
  Write(t, '-d', i, ' ');
  if Solid.Checked then Write(t, '-s ');
  if Version.Checked then Write(t, '-c2 ');
  if Password.Checked then Write(t, '-p', PassText.Text, ' ');
  if not Path.Checked then Write(t, '-ep ')
    else Write(t, '-fp ');
  if Recovery.Checked then Write(t, '-rr ');
  if Span.Checked then
  begin
    if AutoSpan.Checked then Write(t, '-v ')
      else Write(t, '-v', SpanSize.Text, ' ');
  end;
  if Log.Checked then Write(t, '-y ');
  WriteLn(t);
  if Log.Checked then WriteLn(t, LogText.Text)
    else WriteLn(t);
  WriteLn(t, Mist.Checked);
  CloseFile(t);
end;

procedure TAce.OKClick(Sender: TObject);
begin
  Apply.Click;
  ModalResult := mrOK;
end;

procedure TAce.LookOutButton4Click(Sender: TObject);
begin
  Notes.ActivePage := 'Compression';
end;

procedure TAce.FormShow(Sender: TObject);
var
  x: Integer;
begin
  Ace.Caption := BrandName + ' Ace';
  Label1.Caption := cAction;
  SpeedButton1.Caption := cGeneral;
  SpeedButton3.Caption := cSwitches;
  SpeedButton2.Caption := cCompress;
  SpeedButton4.Caption := cSpan;
  x := Action.ItemIndex;
  Action.Items.Clear;
  Action.Items.Add(mtvAce0);
  Action.Items.Add(mtvAce1);
  Action.Items.Add(mtvAce2);
  Action.Items.Add(mtvAce3);
  Action.ItemIndex := x;
  Label4.Caption := clPriority;
  Label5.Caption := clUserMode;
  interactive.Caption := cInteractive;
  Log.Caption := cLogged;
  OK.Caption := cOK;
  Apply.Caption := cApply;
  Cancel.Caption := cCancel;
  SaveLog.Title := cLogDialogSaveAs;
  SaveLog.Filter := cTextFiles + '|*.txt|' + cAllFiles + '|*.*';
  x := Priority.ItemIndex;
  Priority.Items.Clear;
  Priority.Items.Add(cTimeCritical);
  Priority.Items.Add(cHigher);
  Priority.Items.Add(cNormal);
  Priority.Items.Add(cIdle);
  Priority.ItemIndex := x;
  Label2.Caption := mtvCompLevel;
  Label3.Caption := cFasterTighter;
  Label8.Caption := mtvDictSize;
  Label9.Caption := cFasterTighter;
  Solid.Caption := mtvSolid;
  Label10.Caption := mtvSolidHint;
  Version.Caption := mtvAce4;
  Label6.Caption := mtvAce5;
  Path.Caption := cFolder;
  Password.Caption := cEncrypt;
  Recovery.Caption := mtvRecoveryInfo;
  Mist.Caption := cMist;
  Span.Caption := mtvEnableSpan;
  Label7.Caption := mtvSpanSetup;
  AutoSpan.Caption := mtvSpanAuto;
  SizeSpan.Caption := mtvSpanSize;
  Label11.Caption := '(' + cKB + ')';
end;

procedure TAce.SpeedButton1Click(Sender: TObject);
begin
  Notes.ActivePage := 'General';
end;

procedure TAce.SpeedButton2Click(Sender: TObject);
begin
  Notes.ActivePage := 'Compression';
end;

procedure TAce.SpeedButton3Click(Sender: TObject);
begin
  Notes.ActivePage := 'Switches';
end;

procedure TAce.SpeedButton4Click(Sender: TObject);
begin
  Notes.ActivePage := 'Span';
end;

end.
