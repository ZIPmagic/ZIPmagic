object DecodeSetup: TDecodeSetup
  Left = 78
  Top = 138
  BorderStyle = bsDialog
  Caption = 'unSZDD Setup'
  ClientHeight = 191
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 12
    Width = 90
    Height = 13
    Caption = 'Overwrite options:'
  end
  object Ask: TRadioButton
    Left = 16
    Top = 32
    Width = 41
    Height = 17
    Caption = '&Ask'
    TabOrder = 0
  end
  object Always: TRadioButton
    Left = 16
    Top = 52
    Width = 57
    Height = 17
    Caption = 'Al&ways'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object Never: TRadioButton
    Left = 16
    Top = 72
    Width = 53
    Height = 17
    Caption = '&Never'
    TabOrder = 2
  end
  object Folder: TCheckBox
    Left = 12
    Top = 100
    Width = 209
    Height = 17
    Caption = '&Extract into new subfolders with suffix:'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object Suffix: TEdit
    Left = 28
    Top = 120
    Width = 197
    Height = 21
    TabOrder = 4
    Text = '.unSZDD'
  end
  object OK: TButton
    Left = 72
    Top = 152
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 5
    OnClick = OKClick
  end
  object Close: TButton
    Left = 152
    Top = 152
    Width = 75
    Height = 25
    Caption = '&Close'
    TabOrder = 6
    OnClick = CloseClick
  end
end
