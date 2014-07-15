unit maceexe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, mMist, ZIPmagicInclude, uSharedDLL,
  ExtCtrls, uLocalize;

type
  Tace2exe = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Converting: TLabel;
    Cancel: TButton;
    OK: TButton;
    SpeedButton1: TButton;
    Saved: TEdit;
    Label4: TLabel;
    SaveAs: TSaveDialog;
    Windows: TRadioButton;
    WinConsole: TRadioButton;
    DOS: TRadioButton;
    OS2: TRadioButton;
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
  ace2exe: Tace2exe;
  AceFile: String;

implementation

{$R *.DFM}

procedure Tace2exe.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tace2exe.FormCreate(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, AceFile);
  CloseFile(t);
  Saved.Text := ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.exe';
  SaveAs.InitialDir := ExtractFilePath(AceFile);
end;

procedure Tace2exe.OKClick(Sender: TObject);
var
  s, sX: String;
  c: Cardinal;
  exe: String;
begin
  sX := Saved.Text;
  if not IsValidSaveName(sX) then
  begin
    MessageBox(ace2exe.Handle, PChar(cInvalidSaveName), PChar(cError), mb_Ok + mb_IconStop);
    Exit;
  end;
  Saved.Text := sX;
  OK.Visible := false;
  Cancel.Visible := false;
  Converting.Visible := True;
  Application.ProcessMessages;
  if Windows.Checked then exe := '-sfxWin32Gui'
    else if WinConsole.Checked then exe := '-sfxWin32Cl'
      else if DOS.Checked then exe := '-sfxDos32'
        else if OS2.Checked then exe := '-sfxOS2Cl';
  //s := '"' + ModuleFolder + 'ace32.exe" s ' + exe + ' std "' + AceFile + '" -y';
  s := '"' + ModuleFolder + 'ace32.exe" s ' + exe + ' "' + AceFile + '" -y';
  // clean-up
  DeleteFile(ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + 'mAce2Exe.ace');
  DeleteFile(ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.mAce2Exe');
  // backup existing files, if found
  CopyFile(PChar(AceFile), PChar(ExtractFilePath(AceFile) + 'mAce2Exe.ace'), false);
  RenameFile(ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.exe',
    ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.mAce2Exe');
  c := MimarSinanMist(BrandName + ' ' + cEXEMaker, s, 3, True);
  repeat
    Application.ProcessMessages;
  until WaitforSingleObject(c, 100) <> WAIT_TIMEOUT;
  MoveFileEx(PChar(ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.exe'),
    PChar(Saved.Text), MOVEFILE_COPY_ALLOWED or MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH);
  // restore backed-up files, if applicable
  RenameFile(ExtractFilePath(AceFile) + 'mAce2Exe.ace', AceFile);
  RenameFile(ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.mAce2Exe',
    ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.exe');
  // clean-up
  DeleteFile(ExtractFilePath(AceFile) + ExtractFileNameOnly(AceFile) + '.mAce2Exe');
  DeleteFile(ExtractFilePath(AceFile) + 'mAce2Exe.ace');
  ModalResult := mrOK;
end;

procedure Tace2exe.SpeedButton1Click(Sender: TObject);
begin
  if SaveAs.Execute then Saved.Text := SaveAs.FileName;
end;

procedure Tace2exe.FormShow(Sender: TObject);
begin
  ace2exe.Caption := BrandName + ' ' + cEXEMaker;
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
