object ace2exe: Tace2exe
  Left = 128
  Top = 4
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'MimarSinan EXE Maker'
  ClientHeight = 254
  ClientWidth = 392
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
    Width = 377
    Height = 41
    AutoSize = False
    Caption = 
      'When you convert your ace file to an exe file, you will be able ' +
      'to decompress it on any computer by just running the exe file. Y' +
      'ou will not need an additional decompression tool.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 305
    Height = 13
    Caption = 
      'Please select the kind of self extracting exe you wish to create' +
      ':'
  end
  object Label3: TLabel
    Left = 8
    Top = 200
    Width = 203
    Height = 13
    Caption = 'Click "OK" when you are ready to convert.'
  end
  object Converting: TLabel
    Left = 8
    Top = 224
    Width = 188
    Height = 13
    Caption = 'Converting now, one moment please...'
    Visible = False
  end
  object Label4: TLabel
    Left = 8
    Top = 152
    Width = 144
    Height = 13
    Caption = 'Create &self extracting exe as:'
    FocusControl = Saved
  end
  object Image1: TImage
    Left = 16
    Top = 96
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001002020100000000000E80200001600000028000000
      2000000040000000010004000000000000020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF0000000000000000000000000080000000000000000000000000000000
      8F0000000000000000000000000000000F00000000004C8C8C8C400000044444
      48F00000888848C8C8C8408888848C8C88F000008F774C8C8C8C40887774C8C8
      C48F08808F774FFFFFFF40887774FFFFF4800F808F774CFCFCFC40887774CFCF
      C40FFF808FF74848C8CF4088FFF47C7C7408880008FF74C47777440887747777
      74448F00008888444FCF440088884CCC44448F000000000048C84400000048C8
      444008F0000000004C8C440000004C8C440008F00000000048C800077780C8C8
      4400008000000000048C7780FC877C844400000000000000004877880F877844
      44000000000000000004FF880F8FF444400000000000000000008FF80CF8FF44
      0000000000000000000008888FCC88800000000000000000000008FFFFFFFF70
      000000000000000000008FCCCCCCCC70000000000000000000008FFFFFFFFF70
      00000000000000000008FCCCCCCCCCF700000000000000000008FFFFFFFFFFC7
      00000000000000000008FCCCCCCCCCFF70000000000000000008FFFFFFFFFFCF
      70000000000000000008FCCCCCCCCCFF70000000000000000008FFFFFFFFFF00
      00000000000000000008FFFFFFFFFF7F80000000000000000008FFFFFFFFFF78
      0000000000000000000888888888888000000000000000000000000000000000
      00000000FFFFFF3FFFFFFF1FF807F01F0000000F000000010000000000000000
      000000000000000180000001C0000001FF01F008FF000018FF00001DFF80001F
      FFC0001FFFE0003FFFF0007FFFF800FFFFF800FFFFF000FFFFF000FFFFE0007F
      FFE0007FFFE0003FFFE0003FFFE0003FFFE0003FFFE0007FFFE000FFFFE001FF
      FFFFFFFF}
    Transparent = True
  end
  object Cancel: TButton
    Left = 312
    Top = 224
    Width = 73
    Height = 22
    Caption = '&Cancel'
    TabOrder = 7
    OnClick = CancelClick
  end
  object OK: TButton
    Left = 232
    Top = 224
    Width = 73
    Height = 22
    Caption = '&OK'
    Default = True
    TabOrder = 6
    OnClick = OKClick
  end
  object SpeedButton1: TButton
    Left = 296
    Top = 168
    Width = 89
    Height = 22
    Caption = 'Save &As...'
    TabOrder = 5
    OnClick = SpeedButton1Click
  end
  object Saved: TEdit
    Left = 8
    Top = 168
    Width = 273
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 4
  end
  object Windows: TRadioButton
    Left = 56
    Top = 80
    Width = 321
    Height = 17
    Caption = 'Windows Based, &Graphical (recommended)'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object WinConsole: TRadioButton
    Left = 56
    Top = 96
    Width = 321
    Height = 17
    Caption = '&Windows Based'
    TabOrder = 1
  end
  object DOS: TRadioButton
    Left = 56
    Top = 112
    Width = 321
    Height = 17
    Caption = '&DOS Based'
    TabOrder = 2
  end
  object OS2: TRadioButton
    Left = 56
    Top = 128
    Width = 321
    Height = 17
    Caption = 'OS/&2 Based'
    TabOrder = 3
  end
  object SaveAs: TSaveDialog
    DefaultExt = 'exe'
    Filter = 'Executable Files|*.exe|All Files|*.*'
    Title = 'Create Self Extracting Exe As:'
    Left = 288
    Top = 192
  end
end
