{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uGetDrive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShellAPI;

type
  TGetDrive = class(TForm)
    Label1: TLabel;
    Drives: TComboBoxEx;
    Button1: TButton;
    Button2: TButton;
    Quick: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GetDrive: TGetDrive;
  Quicken: Boolean;
  Drive: String;

implementation

{$R *.dfm}

procedure TGetDrive.FormCreate(Sender: TObject);
var
  c: Char;
  sfi: TSHFileInfo;
begin
  Drives.Images := TImageList.Create(Drives);
  Drives.Images.Handle := SHGetFileInfo('', 0, SFI, SizeOf(SFI), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  Drives.Images.ShareImages := True;
  for c := 'A' to 'Z' do
    if GetDriveType(PChar(c + ':\')) = DRIVE_REMOVABLE then
    begin
      SHGetFileInfo(PChar(c + ':\'), FILE_ATTRIBUTE_NORMAL, SFI, SizeOf(TSHFileInfo),
        SHGFI_ICON or SHGFI_USEFILEATTRIBUTES);
      Drives.ItemsEx.AddItem(c + ':\', SFI.iIcon, SFI.iIcon, 0, 0, nil);
    end;
  if Drives.Items.Count = 0 then
  begin
    MessageBox(0, 'No floppy drives available!', 'WinImages Archives', mb_Ok + mb_IconStop);
    Application.Terminate;
  end
  else Drives.ItemIndex := 0;
end;

procedure TGetDrive.Button1Click(Sender: TObject);
begin
  Drive := Drives.Items[Drives.ItemIndex];
  Quicken := Quick.Checked;
  ModalResult := mrOk;
end;

procedure TGetDrive.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Application.Terminate;
end;

end.
