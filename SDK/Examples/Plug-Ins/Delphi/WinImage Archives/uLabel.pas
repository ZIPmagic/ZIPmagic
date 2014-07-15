{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WIMADLL, uSharedDLL;

type
  TFloppyLabel = class(TForm)
    Label1: TLabel;
    DiskLabel: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FloppyLabel: TFloppyLabel;

implementation

{$R *.dfm}

procedure TFloppyLabel.FormCreate(Sender: TObject);
var
  h: hIMA;
  dw: DWORD;
  b: PBool;
  p: PChar;
begin
  h := CreateMemFathIMA;
  dw := 0;
  New(b);
  ReadImaFile(h, 0, PChar(ArchiveFile), b, dw);
  Dispose(b);
  GetMem(p, MAX_PATH);
  GetLabel(h, p);
  DiskLabel.Text := p;
  FreeMem(p);
end;

procedure TFloppyLabel.Button1Click(Sender: TObject);
var
  h: hIMA;
  dw: DWORD;
  b: PBool;
begin
  h := CreateMemFathIMA;
  dw := 0;
  New(b);
  ReadImaFile(h, 0, PChar(ArchiveFile), b, dw);
  Dispose(b);
  SetLabel(h, PChar(DiskLabel.Text));
  WriteImaFile(h, FloppyLabel.Handle, PChar(ArchiveFile), false, false, 1, 0, nil);
  ModalResult := mrOk;
end;

end.
