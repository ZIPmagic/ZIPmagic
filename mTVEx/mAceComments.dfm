object AceComments: TAceComments
  Left = 228
  Top = 70
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'MimarSinan Ace Comments'
  ClientHeight = 171
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 241
    Height = 13
    Caption = 'You may &edit the comments for this ace file below:'
    FocusControl = Comments
  end
  object Apply: TButton
    Left = 144
    Top = 144
    Width = 73
    Height = 22
    Caption = '&Apply'
    Default = True
    TabOrder = 1
    OnClick = ApplyClick
  end
  object Cancel: TButton
    Left = 224
    Top = 144
    Width = 71
    Height = 22
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = CancelClick
  end
  object Comments: TMemo
    Left = 8
    Top = 24
    Width = 289
    Height = 113
    TabOrder = 0
  end
end
