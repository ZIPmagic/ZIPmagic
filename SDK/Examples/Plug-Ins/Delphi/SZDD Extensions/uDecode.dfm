object Decode: TDecode
  Left = 326
  Top = 127
  BorderStyle = bsSingle
  Caption = 'unSZDD'
  ClientHeight = 124
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 76
    Height = 13
    Caption = 'Source Archive:'
  end
  object Src: TLabel
    Left = 8
    Top = 28
    Width = 313
    Height = 13
    AutoSize = False
    Caption = 'Src'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 72
    Height = 13
    Caption = 'Extracting File:'
  end
  object Trg: TLabel
    Left = 8
    Top = 72
    Width = 313
    Height = 13
    AutoSize = False
    Caption = 'Trg'
    WordWrap = True
  end
  object Progress: TProgressBar
    Left = 8
    Top = 96
    Width = 233
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object Cancel: TButton
    Left = 248
    Top = 92
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = CancelClick
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 268
    Top = 4
  end
end
