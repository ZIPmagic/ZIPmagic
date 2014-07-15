{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uDecodeSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uSharedDLL;

type
  TDecodeSetup = class(TForm)
    Label1: TLabel;
    Ask: TRadioButton;
    Always: TRadioButton;
    Never: TRadioButton;
    Folder: TCheckBox;
    Suffix: TEdit;
    OK: TButton;
    Close: TButton;
    Path: TCheckBox;
    procedure CloseClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DecodeSetup: TDecodeSetup;

implementation

{$R *.DFM}

procedure TDecodeSetup.CloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TDecodeSetup.OKClick(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  ReWrite(t);
  WriteLn(t, Ask.Checked);
  WriteLn(t, Always.Checked);
  WriteLn(t, Never.Checked);
  WriteLn(t, Folder.Checked);
  WriteLn(t, Suffix.Text);
  WriteLn(t, Path.Checked);
  CloseFile(t);
  CloseClick(Self);
end;

procedure TDecodeSetup.FormShow(Sender: TObject);
var
  s: String;
  t: TextFile;
begin
  FileMode := 0;
  DecodeSetup.Caption := DecodeSetup.Caption + ' ' + ExtractFileNameOnly(ParamStr3);
  if FileExists(ParamStr3) then
  begin
    AssignFile(t, ParamStr3);
    Reset(t);
    ReadLn(t, s);
    Ask.Checked := s = 'TRUE';
    ReadLn(t, s);
    Always.Checked := s = 'TRUE';
    ReadLn(t, s);
    Never.Checked := s = 'TRUE';
    ReadLn(t, s);
    Folder.Checked := s = 'TRUE';
    ReadLn(t, s);
    Suffix.Text := s;
    ReadLn(t, s);
    Path.Checked := s = 'TRUE';
    CloseFile(t);
  end
  else
  begin
    // defaults set in UI
    DecodeSetup.Caption := DecodeSetup.Caption + ': ' + '[New]';
  end;
end;

end.
