unit mrarprefs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, uLocalize,
  Registry, ImgList, ZIPmagicInclude, uSharedDLL, Buttons;

type
  TRar = class(TForm)
    Notes: TNotebook;
    Action: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    Timer: TTimer;
    Path: TCheckBox;
    RelPath: TCheckBox;
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
    Priority: TTrackBar;
    pMinMax: TLabel;
    pDefault: TLabel;
    Label6: TLabel;
    asis: TRadioButton;
    wipe: TRadioButton;
    SpanSolid: TCheckBox;
    MultiMedia: TCheckBox;
    Mist: TCheckBox;
    Profile: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Force: TCheckBox;
    Audio: TCheckBox;
    Delta: TCheckBox;
    AudioCount: TTrackBar;
    DeltaCount: TTrackBar;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    x86: TCheckBox;
    ia64: TCheckBox;
    rgb: TCheckBox;
    Text: TCheckBox;
    PPM: TTrackBar;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    RAM: TTrackBar;
    Button1: TButton;
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
    procedure PriorityChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ForceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rar: TRar;

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

procedure TRar.FormCreate(Sender: TObject);
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
    ReadLn(t, s);
    case s[1] of
      'a': Action.ItemIndex := 0;
      'm': Action.ItemIndex := 1;
      'u': Action.ItemIndex := 2;
      'f': Action.ItemIndex := 3;
    end;
    if Pos('-ri', s) <> 0 then
      Priority.Position := StrToInt(CutOut(s, '-ri', ' '))
    else
      Priority.Position := 0;
    Rate.Position := StrToInt(CutOut(s, '-m', ' '));
    i := StrToInt(CutOut(s, '-md', ' '));
    j := 0;
    repeat
      j := j + 1;
      i := i div 2;
    until i = 32;
    Dictionary.Position := j;
    //MultiMedia.Checked := Pos('-mm', s) <> 0;
    Force.Checked := AnsiPos('-mc', s) <> 0;
    if Force.Checked then
    begin
      if AnsiPos('-mca-', s) <> 0 then
        Audio.Checked := false
      else
      begin
        Audio.Checked := True;
        AudioCount.Position := StrToInt(CutOut(s, '-mca', ' '));
      end;
      if AnsiPos('-mcd-', s) <> 0 then
        Delta.Checked := false
      else
      begin
        Delta.Checked := True;
        DeltaCount.Position := StrToInt(CutOut(s, '-mcd', ' '));
      end;
      if AnsiPos('-mce-', s) <> 0 then
        x86.Checked := false
      else
        x86.Checked := True;
      if AnsiPos('-mci-', s) <> 0 then
        ia64.Checked := false
      else
        ia64.Checked := True;
      if AnsiPos('-mcc-', s) <> 0 then
        rgb.Checked := false
      else
        rgb.Checked := True;
      if AnsiPos('-mct-', s) <> 0 then
        Text.Checked := false
      else
      begin
        Text.Checked := True;
        PPM.Position := StrToInt(Copy(CutOut(s, '-mct', ' '), 1, AnsiPos(':', CutOut(s, '-mct', ' ')) -1));
        RAM.Position := StrToInt(Copy(CutOut(s, '-mct', ' '), AnsiPos(':', CutOut(s, '-mct', ' ')) +1, Length(CutOut(s, '-mct', ' '))));
      end;
    end;
    ForceClick(Self);
    Solid.Checked := Pos('-s ', s) <> 0;
    Password.Checked := Pos('-p', s) <> 0;
    if Password.Checked then
      PassText.Text := CutOut(s, '-p', ' ')
    else
      PassText.Text := '';
    RelPath.Checked := Pos('-ep1', s) <> 0;
    Path.Checked := (Pos('-ep ', s) = 0);
    Recovery.Checked := Pos('-rr', s) <> 0;
    AutoSpan.Checked := Pos('-v ', s) <> 0;
    SizeSpan.Checked := (Pos('-v', s) <> 0) and (Pos('-vd', s) <> Pos('-v', s)); // works because we write -v123... before -vd
    if SizeSpan.Checked then
      SpanSize.Text := CutOut(s, '-v', ' ')
    else
      SpanSize.Text := '1024';
    Span.Checked := AutoSpan.Checked or SizeSpan.Checked;
    if not Span.Checked then AutoSpan.Checked := True;
    Wipe.Checked := Pos('-vd', s) <> 0;
    SpanSolid.Checked := Pos('-sv', s) <> 0;
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
    Profile.Caption := Profile.Caption + ' ' + cNew;
  end;
end;

procedure TRar.TimerTimer(Sender: TObject);
begin
  PassText.Enabled := Password.Checked;
  LogText.Enabled := Log.Checked;
  bLogText.Enabled := Log.Checked;
  RelPath.Enabled := Path.Checked;
  SpanSize.Enabled := SizeSpan.Checked;
  SpanSolid.Enabled := Solid.Checked;
end;

procedure TRar.bLogTextClick(Sender: TObject);
begin
  if SaveLog.Execute then LogText.Text := SaveLog.FileName;
end;

procedure TRar.LookOutButton1Click(Sender: TObject);
begin
  Notes.ActivePage := 'General';
end;

procedure TRar.LookOutButton2Click(Sender: TObject);
begin
  Notes.ActivePage := 'Switches';
end;

procedure TRar.LookOutButton3Click(Sender: TObject);
begin
  Notes.ActivePage := 'Span';
end;

procedure TRar.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRar.ApplyClick(Sender: TObject);
var
  t: TextFile;
  i, j: Integer;
begin
  AssignFile(t, ParamStr3);
  ReWrite(t);
  case Action.ItemIndex of
    0: Write(t, 'a ');
    1: Write(t, 'm ');
    2: Write(t, 'u ');
    3: Write(t, 'f ');
  end;
  if Priority.Position <> 0 then
    Write(t, '-ri', Priority.Position, ' ');
  Write(t, '-m', Rate.Position, ' ');
  i := 32;
  for j := 1 to Dictionary.Position do
    i := i * 2;
  Write(t, '-md', i, ' ');
  //if MultiMedia.Checked then Write(t, '-mm ');
  if Force.Checked then
  begin
    if not Audio.Checked then Write(t, '-mca- ')
      else Write(t, '-mca', AudioCount.Position, ' ');
    if not Delta.Checked then Write(t, '-mcd- ')
      else Write(t, '-mcd', DeltaCount.Position, ' ');
    if not x86.Checked then Write(t, '-mce- ')
      else Write(t, '-mce ');
    if not ia64.Checked then Write(t, '-mci- ')
      else Write(t, '-mci ');
    if not rgb.Checked then Write(t, '-mcc- ')
      else Write(t, '-mcc ');
    if not Text.Checked then Write(t, '-mct- ')
      else Write(t, '-mct', PPM.Position, ':', RAM.Position, ' ');
  end;
  if Solid.Checked then Write(t, '-s ');
  if Password.Checked then Write(t, '-p', PassText.Text, ' ');
  if RelPath.Checked and Path.Checked then Write(t, '-ep1 ');
  if not Path.Checked then Write(t, '-ep ');
  if Recovery.Checked then Write(t, '-rr ');
  if Span.Checked then
  begin
    if AutoSpan.Checked then Write(t, '-v ')
      else Write(t, '-v', SpanSize.Text, ' ');
  end;
  if Wipe.Checked then Write(t, '-vd ');
  if SpanSolid.Checked then Write(t, '-sv ');
  if Log.Checked then Write(t, '-y ');
  WriteLn(t);
  if Log.Checked then WriteLn(t, LogText.Text)
    else WriteLn(t);
  WriteLn(t, Mist.Checked);
  CloseFile(t);
end;

procedure TRar.OKClick(Sender: TObject);
begin
  Apply.Click;
  ModalResult := mrOk;
end;

procedure TRar.LookOutButton4Click(Sender: TObject);
begin
  Notes.ActivePage := 'Compression';
end;

procedure TRar.PriorityChange(Sender: TObject);
begin
  if Priority.Position = 0 then
  begin
    pDefault.Font.Style := pDefault.Font.Style + [fsUnderline];
    pMinMax.Font.Style := pMinMax.Font.Style - [fsUnderline];
  end
  else
  begin
    pDefault.Font.Style := pDefault.Font.Style - [fsUnderline];
    pMinMax.Font.Style := pMinMax.Font.Style + [fsUnderline];
  end;
end;

procedure TRar.FormShow(Sender: TObject);
var
  x: Integer;
begin
  Rar.Caption := BrandName + ' Rar';
  SpeedButton1.Caption := cGeneral;
  SpeedButton3.Caption := cSwitches;
  SpeedButton2.Caption := cCompress;
  SpeedButton4.Caption := cSpan;
  OK.Caption := cOK;
  Apply.Caption := cApply;
  Cancel.Caption := cCancel;
  SaveLog.Title := cLogDialogSaveAs;
  SaveLog.Filter := cTextFiles + '|*.txt|' + cAllFiles + '|*.*';
  Label1.Caption := cAction;
  pDefault.Caption := cDefault;
  pMinMax.Caption := cMinMax;
  x := Action.ItemIndex;
  Action.Items.Clear;
  Action.Items.Add(mtvRarAct0);
  Action.Items.Add(mtvRarAct1);
  Action.Items.Add(mtvRarAct2);
  Action.Items.Add(mtvRarAct3);
  Action.ItemIndex := x;
  Label4.Caption := clPriority;
  Label5.Caption := clUserMode;
  interactive.Caption := cInteractive;
  Log.Caption := cLogged;
  Label2.Caption := mtvCompLevel;
  Label3.Caption := cFasterTighter;
  Label8.Caption := mtvDictSize;
  Label9.Caption := cFasterTighter;
  Solid.Caption := mtvSolid;
  Label10.Caption := mtvSolidHint;
  Path.Caption := cFolder;
  RelPath.Caption := cFolderRelative;
  Password.Caption := cEncrypt;
  Recovery.Caption := mtvRecoveryInfo;
  Label6.Caption := mtvMediaPrepare;
  asis.Caption := mtvLeaveAsIs;
  wipe.Caption := mtvEraseAll;
  Mist.Caption := cMist;
  Span.Caption := mtvEnableSpan;
  Label7.Caption := mtvSpanSetup;
  AutoSpan.Caption := mtvSpanAuto;
  SizeSpan.Caption := mtvSpanSize;
  Label11.Caption := '(' + cKB + ')';
  SpanSolid.Caption := mtvIndepSolid;
end;

procedure TRar.SpeedButton1Click(Sender: TObject);
begin
  Notes.ActivePage := 'General';
end;

procedure TRar.SpeedButton2Click(Sender: TObject);
begin
  Notes.ActivePage := 'Compression';
end;

procedure TRar.SpeedButton3Click(Sender: TObject);
begin
  Notes.ActivePage := 'Switches';
end;

procedure TRar.SpeedButton4Click(Sender: TObject);
begin
  Notes.ActivePage := 'Span';
end;

procedure TRar.Button1Click(Sender: TObject);
begin
  Notes.ActivePage := 'Advanced';
end;

procedure TRar.ForceClick(Sender: TObject);
begin
  Audio.Enabled := Force.Checked;
  Delta.Enabled := Force.Checked;
  x86.Enabled := Force.Checked;
  ia64.Enabled := Force.Checked;
  rgb.Enabled := Force.Checked;
  text.Enabled := Force.Checked;
  AudioCount.Enabled := Force.Checked;
  DeltaCount.Enabled := Force.Checked;
  PPM.Enabled := Force.Checked;
  RAM.Enabled := Force.Checked;
  Label12.Enabled := Force.Checked;
  Label14.Enabled := Force.Checked;
  Label13.Enabled := Force.Checked;
  Label17.Enabled := Force.Checked;
  Label15.Enabled := Force.Checked;
  Label16.Enabled := Force.Checked;
  Label18.Enabled := Force.Checked;
  Label19.Enabled := Force.Checked;
  Label20.Enabled := Force.Checked;
end;

end.
