unit mrepairrar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, mMist, ExtCtrls, uSharedDLL, uLocalize, ZIPmagicInclude;

type
  TRepairRar = class(TForm)
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
  switch = 'r ';
  Recovered = '_recover.rar';
  Reconstructed = '_reconst.rar';

var
  s: String;
  t: TextFile;
  c: Cardinal;
  RepairRar: TRepairRar;
  RarFile: String;

implementation

{$R *.DFM}

procedure TRepairRar.FormCreate(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  Reset(t);
  ReadLn(t, RarFile);
  CloseFile(t);
  Saved.Text := ExtractFilePath(RarFile) + cRepaired + ' ' + ExtractFileName(RarFile);
  SaveAs.InitialDir := ExtractFilePath(RarFile);
end;

procedure TRepairRar.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRepairRar.OKClick(Sender: TObject);
var
  s, sX: String;
begin
  sX := Saved.Text;
  if not IsValidSaveName(sX) then
  begin
    MessageBox(RepairRar.Handle, PChar(cInvalidSaveName), PChar(cError), mb_Ok + mb_IconStop);
    Exit;
  end;
  Saved.Text := sX;
  Repairing.Visible := True;
  OK.Visible := false;
  Cancel.Visible := false;
  Application.ProcessMessages;
  ChDir(ExtractFilePath(RarFile)); // fix bug for rar.exe
  Windows.DeleteFile(PChar(ExtractFilePath(RarFile) + Recovered));
  Windows.DeleteFile(PChar(ExtractFilePath(RarFile) + Reconstructed));
  s := '"' + ModuleFolder + 'rar.exe" ' + Switch + ' "' + RarFile + '"';
  c := MimarSinanMist(BrandName + ' Rar ' + cRepair, s, 1, True);
  repeat
    Application.ProcessMessages;
  until WaitforSingleObject(c, 100) <> WAIT_TIMEOUT;
  if FileExists(ExtractFilePath(RarFile) + Recovered) then
  begin
    MessageBox(RepairRar.Handle, PChar(mtvRepairHigh), PChar(BrandName + ' Rar ' + cRepair), mb_Ok + mb_IconInformation);
    s := ExtractFilePath(RarFile) + Recovered;
  end
  else
  begin
    MessageBox(RepairRar.Handle, PChar(mtvRepairLow), PChar(BrandName + ' Rar ' + cRepair), mb_Ok + mb_IconInformation);
    s := ExtractFilePath(RarFile) + Reconstructed;
  end;
  MoveFileEx(PChar(s), PChar(Saved.Text), MOVEFILE_COPY_ALLOWED or MOVEFILE_REPLACE_EXISTING
    or MOVEFILE_WRITE_THROUGH);
  ModalResult := mrOK;
end;

procedure TRepairRar.SpeedButton1Click(Sender: TObject);
begin
  if SaveAs.Execute then Saved.Text := SaveAs.FileName;
end;

procedure TRepairRar.FormShow(Sender: TObject);
begin
  RepairRar.Caption := BrandName + ' Rar ' + cRepair;
  OK.Caption := cOK;
  Cancel.Caption := cCancel;
  Label1.Caption := mtvRarRepair0;
  Label2.Caption := mtvRarRepair1;
  Label4.Caption := mtvRarRepair2;
  Label3.Caption := cRepairHint;
  Repairing.Caption := cRepairProgress;
  SpeedButton1.Caption := cSaveAs;
  SaveAs.Title := mtvRarRepair3;
  SaveAs.Filter := 'Rar ' + cFile + '|*.rar|' + cAllFiles + '|*.*';
end;

end.
