object GetDrive: TGetDrive
  Left = 149
  Top = 230
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Select Drive'
  ClientHeight = 127
  ClientWidth = 257
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
    Left = 16
    Top = 16
    Width = 221
    Height = 13
    Caption = 'Please select a floppy drive for this operation:'
  end
  object Drives: TComboBoxEx
    Left = 16
    Top = 32
    Width = 225
    Height = 22
    ItemsEx.CaseSensitive = False
    ItemsEx.SortType = stNone
    ItemsEx = <>
    Style = csExDropDownList
    StyleEx = []
    ItemHeight = 16
    TabOrder = 0
    DropDownCount = 8
  end
  object Button1: TButton
    Left = 88
    Top = 88
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Close'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Quick: TCheckBox
    Left = 16
    Top = 64
    Width = 49
    Height = 17
    Caption = '&Quick'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
end
