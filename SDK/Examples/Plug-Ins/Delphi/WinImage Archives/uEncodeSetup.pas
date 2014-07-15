{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uEncodeSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uSharedDLL, ComCtrls;

type
  TEncodeSetup = class(TForm)
    Label1: TLabel;
    OK: TButton;
    Close: TButton;
    Path: TCheckBox;
    zLib: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure CloseClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EncodeSetup: TEncodeSetup;

implementation

{$R *.DFM}

procedure TEncodeSetup.CloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TEncodeSetup.OKClick(Sender: TObject);
var
  t: TextFile;
begin
  AssignFile(t, ParamStr3);
  ReWrite(t);
  WriteLn(t, zLib.Position);
  WriteLn(t, Path.Checked);
  CloseFile(t);
  CloseClick(Self);
end;

procedure TEncodeSetup.FormShow(Sender: TObject);
var
  s: String;
  i: Integer;
  t: TextFile;
begin
  FileMode := 0;
  EncodeSetup.Caption := EncodeSetup.Caption + ' ' + ExtractFileNameOnly(ParamStr3);
  if FileExists(ParamStr3) then
  begin
    AssignFile(t, ParamStr3);
    Reset(t);
    ReadLn(t, i);
    zLib.Position := i;
    ReadLn(t, s);
    Path.Checked := s = 'TRUE';
    CloseFile(t);
  end
  else
  begin
    // defaults set in UI
    EncodeSetup.Caption := EncodeSetup.Caption + ': ' + '[New]';
  end;
end;

end.
