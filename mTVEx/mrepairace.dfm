object RepairAce: TRepairAce
  Left = 552
  Top = 170
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'MimarSinan Ace Repair'
  ClientHeight = 195
  ClientWidth = 399
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
    Width = 385
    Height = 33
    AutoSize = False
    Caption = 
      'You may repair an ace file that has become damaged. The best of ' +
      'two available repair methods will be selected automatically.'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 8
    Top = 144
    Width = 223
    Height = 13
    Caption = 'Click "OK" when you are ready to begin repair.'
  end
  object Repairing: TLabel
    Left = 8
    Top = 168
    Width = 180
    Height = 13
    Caption = 'Repairing now, one moment please...'
    Visible = False
  end
  object Label4: TLabel
    Left = 8
    Top = 96
    Width = 122
    Height = 13
    Caption = '&Save repaired ace file as:'
    FocusControl = Saved
  end
  object Label2: TLabel
    Left = 56
    Top = 48
    Width = 337
    Height = 41
    AutoSize = False
    Caption = 
      'For higher success when repairing ace files, please make sure th' +
      'at you create ace files with recovery information, or use the "P' +
      'rotect File" tool which inserts such information.'
    WordWrap = True
  end
  object Image1: TImage
    Left = 8
    Top = 56
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
    Left = 320
    Top = 168
    Width = 73
    Height = 22
    Caption = '&Cancel'
    TabOrder = 3
    OnClick = CancelClick
  end
  object OK: TButton
    Left = 240
    Top = 168
    Width = 73
    Height = 22
    Caption = '&OK'
    Default = True
    TabOrder = 2
    OnClick = OKClick
  end
  object SpeedButton1: TButton
    Left = 288
    Top = 112
    Width = 89
    Height = 22
    Caption = 'Save &As...'
    TabOrder = 1
    OnClick = SpeedButton1Click
  end
  object Saved: TEdit
    Left = 8
    Top = 112
    Width = 273
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
  end
  object SaveAs: TSaveDialog
    DefaultExt = 'ace'
    Filter = 'Rar Files|*.rar|All Files|*.*'
    Title = 'Save Repaired Rar File As:'
    Left = 288
    Top = 136
  end
end
