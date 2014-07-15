unit mrarexe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, uSharedDLL, uLocalize, mMist,
  ZIPmagicInclude;

type
  Trar2exe = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Windows: TRadioButton;
    WinConsole: TRadioButton;
    DOS: TRadioButton;
    OS2: TRadioButton;
    Label3: TLabel;
    Converting: TLabel;
    Cancel: TButton;
    OK: TButton;
    SpeedButton1: TButton;
    Saved: TEdit;
    Label4: TLabel;
    SaveAs: TSaveDialog;
    Image1: TImage;
    procedure CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rar2exe: Trar2exe;
  RarFile: String;

implementation

{$R *.DFM}

procedure Trar2exe.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Trar2exe.FormCreate(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, RarFile);
  CloseFile(t);
  Saved.Text := ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.exe';
  SaveAs.InitialDir := ExtractFilePath(RarFile);
end;

procedure Trar2exe.OKClick(Sender: TObject);
var
  s, sX: String;
  c: Cardinal;
  exe: String;
begin
  sX := Saved.Text;
  if not IsValidSaveName(sX) then
  begin
    MessageBox(rar2exe.Handle, PChar(cInvalidSaveName), PChar(cError), mb_Ok + mb_IconStop);
    Exit;
  end;
  Saved.Text := sX;
  OK.Visible := false;
  Cancel.Visible := false;
  Converting.Visible := True;
  Application.ProcessMessages;
  if Windows.Checked then exe := 'sdefault.sfx';
  if WinConsole.Checked then exe := 'swincon.sfx';
  if Dos.Checked then exe := 'sdos.sfx';
  if OS2.Checked then exe := 'sos2.sfx';
  s := '"' + ModuleFolder + 'rar.exe" ' + exe + ' "' + RarFile + '"';
  // clean-up
  DeleteFile(ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.mRar2Exe');
  // backup existing file, if found
  RenameFile(ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.exe',
    ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.mRar2Exe');
  c := MimarSinanMist(BrandName + ' ' + cEXEMaker, s, 3, True);
  repeat
    Application.ProcessMessages;
  until WaitforSingleObject(c, 100) <> WAIT_TIMEOUT;
  MoveFileEx(PChar(ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.exe'),
    PChar(Saved.Text), MOVEFILE_COPY_ALLOWED or MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH);
  // restore backed-up file, if applicable
  RenameFile(ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.mRar2Exe',
    ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.exe');
  // clean-up
  DeleteFile(ExtractFilePath(RarFile) + ExtractFileNameOnly(RarFile) + '.mRar2Exe');
  ModalResult := mrOK;
end;

procedure Trar2exe.SpeedButton1Click(Sender: TObject);
begin
  if SaveAs.Execute then Saved.Text := SaveAs.FileName;
end;

procedure Trar2exe.FormShow(Sender: TObject);
begin
  rar2exe.Caption := BrandName + ' ' + cEXEMaker;
  Label1.Caption := cEXEMakerExplanation;
  Label2.Caption := cEXEMakerKind;
  Label4.Caption := cSEAAs;
  SpeedButton1.Caption := cSaveAs;
  OK.Caption := cOK;
  Cancel.Caption := cCancel;
  Label3.Caption := cClickToConvert;
  Converting.Caption := cConverting;
  SaveAs.Title := cSEADialogSaveAs;
  SaveAs.Filter := cEXEFiles + '|*.exe|' + cAllFiles + '|*.*';
  Windows.Caption := mtvRarGraphWin;
  WinConsole.Caption := mtvRarWin;
  DOS.Caption := mtvRarDOS;
  OS2.Caption := mtvRAROS2;
end;

end.
