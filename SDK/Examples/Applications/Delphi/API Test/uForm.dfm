object Gui: TGui
  Left = 132
  Top = 120
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MimarSinan Codex Test Skin'
  ClientHeight = 339
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 320
    Width = 457
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Page: TPageControl
    Left = 8
    Top = 8
    Width = 441
    Height = 305
    ActivePage = WorkTab
    TabIndex = 3
    TabOrder = 1
    object WelcomeTab: TTabSheet
      Caption = 'Welcome'
      ImageIndex = 3
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 130
        Height = 13
        Caption = 'Click the menus for actions.'
      end
      object Label5: TLabel
        Left = 8
        Top = 40
        Width = 418
        Height = 13
        Caption = 
          'This space, if necessary, will contain additional information an' +
          'd additional related actions.'
      end
      object Label7: TLabel
        Left = 8
        Top = 24
        Width = 182
        Height = 13
        Caption = 'Watch the status bar for action results.'
      end
    end
    object PlugTab: TTabSheet
      Caption = 'Plug-In Information'
      object Label6: TLabel
        Left = 8
        Top = 120
        Width = 42
        Height = 13
        Caption = '(plug-ins)'
      end
      object Label8: TLabel
        Left = 328
        Top = 120
        Width = 96
        Height = 13
        Caption = '(supported archives)'
      end
      object Label9: TLabel
        Left = 336
        Top = 256
        Width = 87
        Height = 13
        Caption = '(archive functions)'
      end
      object PlugInList: TListBox
        Left = 8
        Top = 8
        Width = 121
        Height = 105
        ItemHeight = 13
        TabOrder = 0
      end
      object Button1: TButton
        Left = 136
        Top = 8
        Width = 75
        Height = 25
        Caption = 'About Box'
        TabOrder = 1
        OnClick = Button1Click
      end
      object ArchivesSupported: TListBox
        Left = 216
        Top = 8
        Width = 209
        Height = 105
        ItemHeight = 13
        TabOrder = 2
      end
      object Button2: TButton
        Left = 136
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Archive List'
        TabOrder = 3
        OnClick = Button2Click
      end
      object FunctionsSupported: TListBox
        Left = 216
        Top = 152
        Width = 209
        Height = 97
        ItemHeight = 13
        TabOrder = 4
      end
      object Button3: TButton
        Left = 216
        Top = 120
        Width = 75
        Height = 25
        Caption = 'Function List'
        TabOrder = 5
        OnClick = Button3Click
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 144
        Width = 193
        Height = 121
        Caption = ' (all archives) '
        TabOrder = 6
        object AllArcList: TListBox
          Left = 8
          Top = 24
          Width = 177
          Height = 89
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    object ArcTab: TTabSheet
      Caption = 'Archive Information'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 112
        Width = 67
        Height = 13
        Caption = '(compressible)'
      end
      object Label2: TLabel
        Left = 144
        Top = 112
        Width = 58
        Height = 13
        Caption = '(extractable)'
      end
      object Label3: TLabel
        Left = 280
        Top = 256
        Width = 66
        Height = 13
        Caption = '(all supported)'
      end
      object CompArc: TListBox
        Left = 8
        Top = 8
        Width = 121
        Height = 97
        ItemHeight = 13
        TabOrder = 0
      end
      object ExtArc: TListBox
        Left = 144
        Top = 8
        Width = 121
        Height = 97
        ItemHeight = 13
        TabOrder = 1
      end
      object AllArc: TListBox
        Left = 280
        Top = 8
        Width = 145
        Height = 249
        ItemHeight = 13
        TabOrder = 2
      end
      object Button4: TButton
        Left = 8
        Top = 128
        Width = 75
        Height = 25
        Caption = 'Get Profiles'
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 144
        Top = 128
        Width = 75
        Height = 25
        Caption = 'Get Profiles'
        TabOrder = 4
        OnClick = Button5Click
      end
      object CompProf: TListBox
        Left = 8
        Top = 160
        Width = 121
        Height = 73
        ItemHeight = 13
        TabOrder = 5
      end
      object ExtProf: TListBox
        Left = 144
        Top = 160
        Width = 121
        Height = 73
        ItemHeight = 13
        TabOrder = 6
      end
      object Button6: TButton
        Left = 8
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Edit Profile'
        TabOrder = 7
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 144
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Edit Profile'
        TabOrder = 8
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 88
        Top = 240
        Width = 41
        Height = 25
        Caption = 'Del'
        TabOrder = 9
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 224
        Top = 240
        Width = 41
        Height = 25
        Caption = 'Del'
        TabOrder = 10
        OnClick = Button9Click
      end
    end
    object WorkTab: TTabSheet
      Caption = 'Current Archive'
      ImageIndex = 2
      object Size: TLabel
        Left = 8
        Top = 208
        Width = 26
        Height = 13
        Caption = 'Size: '
      end
      object CompSize: TLabel
        Left = 8
        Top = 224
        Width = 84
        Height = 13
        Caption = 'Compressed Size:'
      end
      object DateTime: TLabel
        Left = 8
        Top = 240
        Width = 73
        Height = 13
        Caption = 'Date and Time:'
      end
      object Password: TLabel
        Left = 8
        Top = 256
        Width = 98
        Height = 13
        Caption = 'Password Protected:'
      end
      object Contents: TListBox
        Left = 8
        Top = 8
        Width = 337
        Height = 193
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
        OnClick = ContentsClick
      end
      object Button10: TButton
        Left = 352
        Top = 40
        Width = 75
        Height = 25
        Caption = 'View/Update'
        TabOrder = 1
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 352
        Top = 104
        Width = 75
        Height = 25
        Caption = 'Install'
        TabOrder = 2
        OnClick = Button11Click
      end
      object Button12: TButton
        Left = 352
        Top = 136
        Width = 75
        Height = 25
        Caption = 'Check-Out'
        TabOrder = 3
        OnClick = Button12Click
      end
      object Button13: TButton
        Left = 352
        Top = 200
        Width = 75
        Height = 25
        Caption = 'Anti-Virus'
        Enabled = False
        TabOrder = 4
      end
      object Button14: TButton
        Left = 352
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Extract'
        TabOrder = 5
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 352
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Tool'
        TabOrder = 6
        OnClick = Button15Click
      end
      object Button17: TButton
        Left = 352
        Top = 168
        Width = 75
        Height = 25
        Caption = 'Convert'
        TabOrder = 7
        OnClick = Button17Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Add to Archive'
      ImageIndex = 4
      object Label10: TLabel
        Left = 8
        Top = 8
        Width = 159
        Height = 13
        Caption = 'Highlight files (and folders) to add:'
      end
      object Dir: TDirectoryListBox
        Left = 8
        Top = 24
        Width = 145
        Height = 217
        FileList = Fil
        ItemHeight = 16
        TabOrder = 0
      end
      object Drv: TDriveComboBox
        Left = 8
        Top = 248
        Width = 145
        Height = 19
        DirList = Dir
        TabOrder = 1
      end
      object Fil: TFileListBox
        Left = 160
        Top = 24
        Width = 145
        Height = 241
        FileType = [ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal]
        ItemHeight = 16
        MultiSelect = True
        ShowGlyphs = True
        TabOrder = 2
      end
      object Recursive: TCheckBox
        Left = 312
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Add with Subfolders'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object Plural: TCheckBox
        Left = 312
        Top = 40
        Width = 113
        Height = 17
        Caption = 'Merged Archives'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = PluralClick
        OnKeyUp = PluralKeyUp
      end
      object Button16: TButton
        Left = 312
        Top = 240
        Width = 113
        Height = 25
        Caption = 'Add Now!'
        TabOrder = 5
        OnClick = Button16Click
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object File2: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open'
        OnClick = Open1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Archives1: TMenuItem
      Caption = '&Archives'
      object LoadPlugIns1: TMenuItem
        Caption = '&Load Plug Ins'
        OnClick = LoadPlugIns1Click
      end
      object FreePlugIns1: TMenuItem
        Caption = '&Free Plug Ins'
        OnClick = FreePlugIns1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object GetCompressibleArchives1: TMenuItem
        Caption = 'Get &Compressible Archives'
        OnClick = GetCompressibleArchives1Click
      end
      object GetExtractableArchives1: TMenuItem
        Caption = 'Get &Extractable Archives'
        OnClick = GetExtractableArchives1Click
      end
      object GetAllSupportedArchives1: TMenuItem
        Caption = 'Get All &Supported Archives'
        OnClick = GetAllSupportedArchives1Click
      end
    end
    object File1: TMenuItem
      Caption = '&Plug Ins'
      object EditBindings1: TMenuItem
        Caption = 'Edit &Bindings'
        OnClick = EditBindings1Click
      end
      object ListPlugIns1: TMenuItem
        Caption = '&Get Plug In List'
        OnClick = ListPlugIns1Click
      end
      object GetAllArchives1: TMenuItem
        Caption = 'Get &All Archives'
        OnClick = GetAllArchives1Click
      end
    end
    object Shell1: TMenuItem
      Caption = '&Shell'
      object CheckAssociations1: TMenuItem
        Caption = '&Check Associations'
        OnClick = CheckAssociations1Click
      end
      object EditAssociations1: TMenuItem
        Caption = '&Edit Associations'
        OnClick = EditAssociations1Click
      end
      object ForceAssociations1: TMenuItem
        Caption = '&Force Associations'
        OnClick = ForceAssociations1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object GetGenericViewer1: TMenuItem
        Caption = '&Get Generic Viewer'
        OnClick = GetGenericViewer1Click
      end
      object SetGenericViewer1: TMenuItem
        Caption = '&Set Generic Viewer'
        OnClick = SetGenericViewer1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object RegisterApplet1: TMenuItem
        Caption = '&Register Applet'
        OnClick = RegisterApplet1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
    end
  end
  object OpenDialog: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Select Archive'
    Left = 40
    Top = 8
  end
  object SaveDialog: TSaveDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Add to New or Existing Archive'
    Left = 72
    Top = 8
  end
  object SaveDialogEx: TSaveDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Convert Into Archive'
    Left = 104
    Top = 8
  end
  object PopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Left = 136
    Top = 8
  end
end
