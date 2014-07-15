{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uFormat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ShellAPI, WIMADLL;

type
  TFormatDisk = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Bevel1: TBevel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    Bevel2: TBevel;
    Drives: TComboBoxEx;
    Label2: TLabel;
    Quick: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormatDisk: TFormatDisk;

implementation

{$R *.dfm}

procedure TFormatDisk.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormatDisk.FormCreate(Sender: TObject);
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

procedure TFormatDisk.Button1Click(Sender: TObject);
var
  h: hIMA;
  b: Byte;
  c, cX: Char;
  i: Integer;
begin
  if RadioButton1.Checked then i := StrToInt(RadioButton1.Hint);
  if RadioButton2.Checked then i := StrToInt(RadioButton2.Hint);
  if RadioButton3.Checked then i := StrToInt(RadioButton3.Hint);
  if RadioButton4.Checked then i := StrToInt(RadioButton4.Hint);
  if RadioButton5.Checked then i := StrToInt(RadioButton5.Hint);
  if RadioButton6.Checked then i := StrToInt(RadioButton6.Hint);
  if RadioButton7.Checked then i := StrToInt(RadioButton7.Hint);
  if RadioButton8.Checked then i := StrToInt(RadioButton8.Hint);
  if RadioButton9.Checked then i := StrToInt(RadioButton9.Hint);
  if RadioButton10.Checked then i := StrToInt(RadioButton10.Hint);
  if RadioButton11.Checked then i := StrToInt(RadioButton11.Hint);
  h := CreateMemFathIMA;
  MakeEmptyImage(h, i);
  c := Drives.Items[Drives.ItemIndex][1];
  b := 0;
  for cX := 'A' to 'Z' do
  begin
    if c = cX then Break
      else b := b +1;
  end;
  if Quick.Checked then
    WriteFloppy(h, FormatDisk.Handle, b, USED, USED, NOTHING, 0)
  else
    WriteFloppy(h, FormatDisk.Handle, b, ALL, ALL, ALL, 0);
  DeleteIma(h);
  MessageBox(FormatDisk.Handle, 'Format complete', PChar(FormatDisk.Caption), mb_Ok + mb_IconInformation);
end;

end.
