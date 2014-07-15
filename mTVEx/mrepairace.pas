unit mrepairace;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ZIPmagicInclude, mMist,
  uSharedDLL, ExtCtrls, uLocalize;

type
  TRepairAce = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Repairing: TLabel;
    Cancel: TButton;
    OK: TButton;
    SaveAs: TSaveDialog;
    SpeedButton1: TButton;
    Saved: TEdit;
    Label4: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  //switch = 'r std '; - this line crashes ACE
  switch = 'r ';
  Recovered = 'REPAIRED.ACE';

var
  s: String;
  t: TextFile;
  c: Cardinal;
  RepairAce: TRepairAce;
  AceFile: String;

implementation

{$R *.DFM}

procedure TRepairAce.FormCreate(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, AceFile);
  CloseFile(t);
  Saved.Text := ExtractFilePath(AceFile) + cRepaired + ' ' + ExtractFileName(AceFile);
  SaveAs.InitialDir := ExtractFilePath(AceFile);
end;

procedure TRepairAce.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRepairAce.OKClick(Sender: TObject);
var
  s, sX: String;
begin
  sX := Saved.Text;
  if not IsValidSaveName(sX) then
  begin
    MessageBox(RepairAce.Handle, PChar(cInvalidSaveName), PChar(cError), mb_Ok + mb_IconStop);
    Exit;
  end;
  Repairing.Visible := True;
  OK.Visible := false;
  Cancel.Visible := false;
  Application.ProcessMessages;
  Windows.DeleteFile(PChar(ExtractFilePath(AceFile) + Recovered));
  //s := '"' + ModuleFolder + 'ace32.exe" ' + Switch + ' "' + AceFile + '" -std- -y'; - the above line crashes ACE
  s := '"' + ModuleFolder + 'ace32.exe" ' + Switch + ' "' + AceFile + '" -y';
  c := MimarSinanMist(BrandName + ' Ace ' + cRepair, s, 1, True);
  repeat
    Application.ProcessMessages;
  until WaitforSingleObject(c, 100) <> WAIT_TIMEOUT;
  s := ExtractFilePath(AceFile) + Recovered;
  if FileExists(ExtractFilePath(AceFile) + Recovered) then
  begin
    MessageBox(RepairAce.Handle, PChar(mtvAceRepair4), PChar(BrandName + ' Ace ' + cRepair), mb_Ok + mb_IconInformation);
    s := ExtractFilePath(AceFile) + Recovered;
    MoveFileEx(PChar(s), PChar(Saved.Text), MOVEFILE_COPY_ALLOWED or MOVEFILE_REPLACE_EXISTING
      or MOVEFILE_WRITE_THROUGH);
  end
  else
    MessageBox(RepairAce.Handle, PChar(mtvAceRepair5), PChar(BrandName + ' Ace ' + cRepair), mb_Ok + mb_IconInformation);
  Application.Terminate;
end;

procedure TRepairAce.SpeedButton1Click(Sender: TObject);
begin
  if SaveAs.Execute then Saved.Text := SaveAs.FileName;
end;

procedure TRepairAce.FormShow(Sender: TObject);
begin
  RepairAce.Caption := BrandName + ' Ace ' + cRepair;
  OK.Caption := cOK;
  Cancel.Caption := cCancel;
  Label1.Caption := mtvAceRepair0;
  Label2.Caption := mtvAceRepair1;
  Label4.Caption := mtvAceRepair2;
  Label3.Caption := cRepairHint;
  Repairing.Caption := cRepairProgress;
  SpeedButton1.Caption := cSaveAs;
  SaveAs.Title := mtvAceRepair3;
  SaveAs.Filter := 'Ace ' + cFile + '|*.ace|' + cAllFiles + '|*.*';
end;

end.
