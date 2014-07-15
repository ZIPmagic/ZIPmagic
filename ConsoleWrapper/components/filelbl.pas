{ -------------------------------------------------------------------------------------}
{ A "FileLabel" component for Delphi32.                                                }
{ Copyright 1997, Patrick Brisacier.  All Rights Reserved.                             }
{ This component can be freely used and distributed in commercial and private          }
{ environments, provided this notice is not modified in any way.                       }
{ -------------------------------------------------------------------------------------}
{ Feel free to contact us if you have any questions, comments or suggestions at        }
{   PBrisacier@mail.dotcom.fr (Patrick Brisacier)                                      }
{ You can always find the latest version of this component at:                         }
{   http://www.worldnet.net/~cycocrew/delphi/                                          }
{ -------------------------------------------------------------------------------------}
{ Date last modified:  03/01/97                                                        }
{ -------------------------------------------------------------------------------------}

{ -------------------------------------------------------------------------------------}
{ TFileLabel v1.01                                                                     }
{ -------------------------------------------------------------------------------------}
{ Description:                                                                         }
{   Display a filename with path and drive letter on a label without                   }
{   without cutting the filename. If the width of the label is too                     }
{   small TFileLabel hide some directories and replace them by '...'.                  }
{ Example :                                                                            }
{   TFileLabel display 'C:\WINDOWS\SYSTEM\FOO.DLL' with one of                         }
{   the following string depend on the width.                                          }
{   'C:\WINDOWS\SYSTEM\FOO.DLL'                                                        }
{   'C:\...\SYSTEM\FOO.DLL'                                                            }
{   'C:\...\FOO.DLL'                                                                   }
{   '...\FOO.DLL'                                                                      }
{   'FOO.DLL'                                                                          }
{ Properties:                                                                          }
{   TFileLabel is based on TCustomLabel. It has all the TLabel properties              }
{   except Caption and add three properties : FileName, Separator and Direction.       }
{   * FileName: String;                                                                }
{       The filename you want to display.                                              }
{   * Separator: String;                                                               }
{       The separator is the string used to find the directories : '\' by              }
{       default. But you can change the separator to '/' for an unixlike               }
{       or an URL filename.                                                            }
{   * Direction: TDirection;                                                           }
{       Direction has two possible different values which are :                        }
{       + drFromLeft : suppress directories from the LEFT.                             }
{            Example : 'C:\WINDOWS\SYSTEM\FOO.BAR'                                     }
{                      'C:\...\SYSTEM\FOO.BAR'                                         }
{                      'C:\...\FOO.BAR'                                                }
{                      '...\FOO.BAR'                                                   }
{                      'FOO.BAR'                                                       }
{       + drFromRight : suppress directories from the RIGHT.                           }
{            Example : 'C:\WINDOWS\SYSTEM\FOO.BAR'                                     }
{                      'C:\WINDOWS\...\FOO.BAR'                                        }
{                      'C:\...\FOO.BAR'                                                }
{                      '...\FOO.BAR'                                                   }
{                      'FOO.BAR'                                                       }
{       The default value for Direction is drFromLeft.                                 }
{                                                                                      }
{ See example contained in example.zip file for more details.                          }
{ -------------------------------------------------------------------------------------}
{ Revision History:                                                                    }
{ 1.00:  + Initial release                                                             }
{ 1.01:  + Modified by Patrick Brisacier                                               }
{        + Fix the problem with font : when we change font now the caption             }
{          is recalculated                                                             }
{ -------------------------------------------------------------------------------------}

unit FileLbl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TDirection = (drFromLeft, drFromRight);
  TFileLabel = class(TCustomLabel)
  private
    { Déclarations privées }
    FFileName: String;
    FSeparator: String;
    FDirection: TDirection;
    FParts: TStringList;
    FFirstPartIsDrive: Boolean;
    procedure SetFileName(AFileName: String);
    procedure SetSeparator(ASeparator: String);
    procedure SetDirection(ADirection: TDirection);
    procedure FillParts;
    procedure AdjustCaption;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED; 
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    { Déclarations publiées }
    property FileName: String read FFileName write SetFileName;
    property Direction: TDirection read FDirection write SetDirection;
    property Separator: String read FSeparator write SetSeparator;

    { publish the TLabel properties except Caption }
    property Align;
    property Alignment;
    property AutoSize default False;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Visible;
    property WordWrap default False;

    { publish all the events }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;
function sBreakApart(BaseString, BreakString: string; StringList: TStringList): TStringList;

implementation

procedure Register;
begin
  RegisterComponents('MSIN', [TFileLabel]);
end;

{---------------------------------------------------------------------------}
{ TFileLabel                                                                }
{---------------------------------------------------------------------------}
constructor TFileLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FParts := TStringList.Create;
  FSeparator := '\';
  AutoSize := False;
  WordWrap := False;
end;

destructor TFileLabel.Destroy;
begin
  FParts.Free;
  inherited Destroy;
end;

procedure TFileLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  AdjustCaption;
end;

procedure TFileLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font := Font;
  AdjustCaption;
end;

procedure TFileLabel.SetFileName(AFileName: String);
begin
  if FFileName <> AFileName then begin
    FFileName := AFileName;
    FillParts;
    AdjustCaption;
  end;
end;

procedure TFileLabel.SetSeparator(ASeparator: String);
begin
  if FSeparator <> ASeparator then begin
    FSeparator := ASeparator;
    FillParts;
    AdjustCaption;
  end;
end;

procedure TFileLabel.SetDirection(ADirection: TDirection);
begin
  if FDirection <> ADirection then begin
    FDirection := ADirection;
    AdjustCaption;
  end;
end;

procedure TFileLabel.FillParts;
begin
  FParts.Clear;
  sBreakApart(FFileName, FSeparator, FParts);
  if (FParts.Count <> 0) and (Length(FParts[0]) > 1)
    and (FParts[0][Length(FParts[0])] = ':') then
    FFirstPartIsDrive := True
  else
    FFirstPartIsDrive := False;
end;

procedure TFileLabel.AdjustCaption;
var
  CurWidth, Start, Stop, iRep: Integer;
  StrDrive, StrEtc, StrRep, StrName: String;
begin
  start := 0;
  if (FFileName = '') or (Canvas.TextWidth(FFileName) <= Width) then
    Caption := FFileName
  else begin
    StrEtc := '...' + FSeparator;
    StrName := FParts[FParts.Count - 1];
    CurWidth := Canvas.TextWidth(StrName);
    if (CurWidth + Canvas.TextWidth(StrEtc)) < Width then begin
      CurWidth := CurWidth + Canvas.TextWidth(StrEtc);
      if FFirstPartIsDrive then begin
        StrDrive := FParts[0] + FSeparator;
        Start := 1;
      end;
      if (CurWidth + Canvas.TextWidth(StrDrive)) < Width then begin
        CurWidth := CurWidth + Canvas.TextWidth(StrDrive);
        Stop := FParts.Count - 2;
        case FDirection of
        drFromLeft: begin
          for iRep := Stop downto Start do begin
            if (CurWidth + Canvas.TextWidth(FParts[iRep] + FSeparator + StrRep)) > Width then break;
            StrRep := FParts[iRep] + FSeparator + StrRep;
          end;
          Caption := StrDrive + StrEtc + StrRep + StrName;
        end;
        drFromRight: begin
          for iRep := Start to Stop do begin
            if (CurWidth + Canvas.TextWidth(StrRep + FParts[iRep] + FSeparator)) > Width then break;
            StrRep := StrRep + FParts[iRep] + FSeparator;
          end;
          Caption := StrDrive + StrRep + StrEtc + StrName;
        end;
        end; {case Direction }
      end { if StrDrive }
      else
        Caption := StrEtc + StrName;
    end { if StrEtc }
    else
      Caption := StrName;
  end; { else }
end;

{ This code came from Lloyd's help file! (begin) }
{ Thanks to Lloyd !!! This help file is VERY useful. }
function sBreakApart(BaseString, BreakString: string; StringList: TStringList): TStringList;
var
  EndOfCurrentString: byte;
begin
  repeat
    EndOfCurrentString := Pos(BreakString, BaseString);
    if EndOfCurrentString = 0 then
      StringList.add(BaseString)
    else
      StringList.add(Copy(BaseString, 1, EndOfCurrentString - 1));
    BaseString := Copy(BaseString, EndOfCurrentString + length(BreakString),
                  length(BaseString) - EndOfCurrentString);
  until EndOfCurrentString = 0;
  result := StringList;
end;
{ This code came from Lloyd's help file! (end) }

end.



