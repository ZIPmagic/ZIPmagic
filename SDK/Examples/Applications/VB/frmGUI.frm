VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Begin VB.Form frmGUI 
   Caption         =   "MimarSinan ArchiveX (Codex 2.0 Implementation)"
   ClientHeight    =   4755
   ClientLeft      =   60
   ClientTop       =   750
   ClientWidth     =   6285
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   8.25
      Charset         =   162
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmGUI.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4755
   ScaleWidth      =   6285
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.ImageList ImageListListView 
      Left            =   720
      Top             =   3720
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   1
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGUI.frx":0ECA
            Key             =   "pwd"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageListToolBar 
      Left            =   120
      Top             =   3720
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGUI.frx":121C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGUI.frx":175E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGUI.frx":1CA0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGUI.frx":21E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGUI.frx":2724
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog CommonDialog 
      Left            =   1320
      Top             =   3840
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin MSComctlLib.Toolbar Toolbar 
      Align           =   1  'Align Top
      Height          =   630
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6285
      _ExtentX        =   11086
      _ExtentY        =   1111
      ButtonWidth     =   1111
      ButtonHeight    =   953
      Appearance      =   1
      ImageList       =   "ImageListToolBar"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "New"
            Key             =   "new"
            Object.ToolTipText     =   "New Archive"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Open"
            Key             =   "open"
            Object.ToolTipText     =   "Open Archive"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Add"
            Key             =   "add"
            Object.ToolTipText     =   "Add Files"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Extract"
            Key             =   "extract"
            Object.ToolTipText     =   "Extract Files"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "View"
            Key             =   "view"
            Object.ToolTipText     =   "View Files"
            Object.Width           =   1e-4
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   4380
      Width           =   6285
      _ExtentX        =   11086
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ListView ListView 
      Height          =   3795
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   6255
      _ExtentX        =   11033
      _ExtentY        =   6694
      View            =   3
      Sorted          =   -1  'True
      MultiSelect     =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      AllowReorder    =   -1  'True
      FlatScrollBar   =   -1  'True
      _Version        =   393217
      Icons           =   "ImageListListView"
      SmallIcons      =   "ImageListListView"
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   5
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Name"
         Object.Width           =   3528
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Alignment       =   1
         SubItemIndex    =   1
         Text            =   "Size"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Alignment       =   1
         SubItemIndex    =   2
         Text            =   "Packed"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Alignment       =   2
         SubItemIndex    =   3
         Text            =   "Ratio"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(5) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   4
         Text            =   "Modified"
         Object.Width           =   3528
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuNewitem 
         Caption         =   "&New Archive"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuOpenitem 
         Caption         =   "&Open Archive"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuCloseitem 
         Caption         =   "&Close Archive"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuFileSeperator1item 
         Caption         =   "-"
      End
      Begin VB.Menu mnuConvertitem 
         Caption         =   "Conve&rt Archive"
         Shortcut        =   ^R
      End
      Begin VB.Menu mnuFileSeparator2item 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExititem 
         Caption         =   "E&xit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnuAction 
      Caption         =   "&Action"
      Begin VB.Menu mnuAdditem 
         Caption         =   "&Add Files"
         Shortcut        =   ^A
      End
      Begin VB.Menu mnuExtractitem 
         Caption         =   "&Extract"
         Shortcut        =   ^E
      End
      Begin VB.Menu mnuViewitem 
         Caption         =   "&View"
         Shortcut        =   ^V
      End
      Begin VB.Menu mnuActionSeparator1item 
         Caption         =   "-"
      End
      Begin VB.Menu mnuInstallitem 
         Caption         =   "&Install"
         Shortcut        =   ^I
      End
      Begin VB.Menu mnuCheckOutitem 
         Caption         =   "Chec&k Out"
         Shortcut        =   ^K
      End
      Begin VB.Menu mnuActionSeparator2item 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTools 
         Caption         =   "Archive Tools"
         Begin VB.Menu mnuToolitem 
            Caption         =   "[no plug-in actions]"
            Index           =   0
         End
      End
      Begin VB.Menu mnuActionSeparator3item 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSelectAllitem 
         Caption         =   "&Select All"
      End
   End
   Begin VB.Menu mnuOption 
      Caption         =   "&Options"
      Begin VB.Menu mnuConfigurationitem 
         Caption         =   "&Configuration"
      End
      Begin VB.Menu mnuConfigurationSeperator1item 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAboutitem 
         Caption         =   "&About ArchiveX"
      End
   End
End
Attribute VB_Name = "frmGUI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==========================================================================
'Copyright(c) 1992-2002 MimarSinan International. All rights reserved.
'This source code provided for demonstrative use only. All rights reserved.
'==========================================================================

Option Explicit

'CommonDialog filters:
Dim CompressFilter As String
Dim ExtractFilter As String
Dim OpenFilter As String

Private Sub AddFilesToArchive(lpArchive As String)

    Dim sCommaText As String
    
    On Error Resume Next
    
    CommonDialog.DialogTitle = "Add Files to Archive"
    CommonDialog.FileName = ""
    CommonDialog.Filter = "All Files (*.*)|*.*"
    CommonDialog.Flags = cdlOFNAllowMultiselect + _
        cdlOFNExplorer + _
        cdlOFNFileMustExist + _
        cdlOFNHideReadOnly
    CommonDialog.ShowOpen
    If Err = cdlCancel Then
        Exit Sub
    End If
    sCommaText = FormFilesCSV(CommonDialog.FileName)
    Select Case SessionExt
    Case "BZ", "BZ2", "BZIP2", "GZ", "GZIP", "ZLIB"
        CreateSingularArchives SessionExt, SessionPath, sCommaText, "Default"
        ShowInStatBar "Singular Archive(s) created in " & SessionPath
    Case Else
        CreateMergedArchive lpArchive, "", sCommaText, "Default"
        ExploreArchive lpArchive, True
    End Select

End Sub

'Explores the given archive in the ListView:
Private Sub ExploreArchive(lpArchive As String, IsReload As Boolean)
    
    Dim ReturnValue As String
    Dim iNull As Integer
    Dim i As Integer
    Dim j As Integer
    Dim sItems As String
    Dim sPwdItems As String
    Dim sDateTimes As String
    Dim sSizes As String
    Dim sCompSizes As String
    Dim sArchiveTools As String
    Dim Item() As String
    Dim PwdItem() As String
    Dim DateTime() As String
    Dim Size() As String
    Dim CompSize() As String
    Dim ArchiveTool() As String
    Dim lvwItem As ListItem
    Dim TotalSize As Double
    Dim TotalCompSize As Double
    Dim PwdProt As Boolean
    
    ReturnValue = QueryArchive(lpArchive, sItems, sPwdItems, sDateTimes, sSizes, sCompSizes)
    If Len(ReturnValue) > 0 Then
        iNull = InStr(1, ReturnValue, Chr(0)) > 0
        If iNull > 0 Then
            ReturnValue = Mid(ReturnValue, 1, iNull - 1)
        End If
        MsgBox ReturnValue, vbCritical, "Error"
        Exit Sub
    End If
    Me.Caption = "MimarSinan ArchiveX - " & SessionTitle
    ListView.ListItems.Clear
    ParseCSV sItems, Item
    ParseCSV sPwdItems, PwdItem
    ParseCSV sDateTimes, DateTime
    ParseCSV sSizes, Size
    ParseCSV sCompSizes, CompSize
    TotalSize = 0
    TotalCompSize = 0
    If Len(Item(0)) > 0 Then
        For i = 0 To UBound(Item)
            PwdProt = False
            For j = 0 To UBound(PwdItem)
                If Item(i) = PwdItem(j) Then
                    PwdProt = True
                    Exit For
                End If
            Next
            If PwdProt Then
                Set lvwItem = ListView.ListItems.Add(, , Item(i), , 1)
            Else
                Set lvwItem = ListView.ListItems.Add(, , Item(i))
            End If
            lvwItem.SubItems(1) = FormatNumber(Size(i), 0, , , vbTrue)
            lvwItem.SubItems(2) = FormatNumber(CompSize(i), 0, , vbTrue)
            If Size(i) = 0 Then
                lvwItem.SubItems(3) = "-"
            Else
                lvwItem.SubItems(3) = Round(CompSize(i) / Size(i) * 100, 0) & "%"
            End If
            lvwItem.SubItems(4) = DateTime(i)
            TotalSize = TotalSize + Size(i)
            TotalCompSize = TotalCompSize + CompSize(i)
            If Item(i) = "setup.exe" Or Item(i) = "install.exe" Then
                mnuInstallitem.Enabled = True
            End If
        Next
    End If
    If IsReload = False Then
        mnuCloseitem.Enabled = True
        mnuAdditem.Enabled = True
        mnuExtractitem.Enabled = True
        mnuViewitem.Enabled = True
        mnuSelectAllitem.Enabled = True
        sArchiveTools = GetArchiveTools(SessionExt)
        If mnuToolitem.Count > 1 Then
            For i = mnuToolitem.UBound To 1 Step -1
                Unload mnuToolitem(i)
            Next
        End If
        If Len(sArchiveTools) = 0 Then
            mnuToolitem(0).Visible = True
        Else
            ParseCSV sArchiveTools, ArchiveTool
            For i = 0 To UBound(ArchiveTool)
                Load mnuToolitem(i + 1)
                mnuToolitem(i + 1).Caption = ArchiveTool(i)
                mnuToolitem(i + 1).Enabled = True
                mnuToolitem(i + 1).Visible = True
            Next
            mnuToolitem(0).Visible = False
        End If
        For i = 3 To 5
            Toolbar.Buttons(i).Enabled = True
        Next
    End If
    ShowInStatBar "Opened " & SessionTitle & ", " & _
        FormatNumber(TotalSize, 0, , , vbTrue) & " bytes, " & _
        FormatNumber(TotalCompSize, 0, , , vbTrue) & " bytes compressed, " & _
        "ratio " & Round(TotalCompSize / TotalSize * 100, 0) & "%"
    
End Sub

'Determines the session parameters.
Private Sub GetSessionParameters(lpArchive As String)
    Session = lpArchive
    SessionPath = Mid(lpArchive, 1, InStrRev(lpArchive, "\") - 1)
    SessionTitle = Mid(lpArchive, InStrRev(lpArchive, "\") + 1)
    SessionExt = Mid(lpArchive, InStrRev(lpArchive, ".") + 1)
End Sub

Private Sub Form_Load()
    
    Dim i As Integer
    
    On Error GoTo ErrorHandler
    
    'Display the Splash screen while loading the application.
    StartSplash "MimarSinan ArchiveX" & vbNewLine & "Codex 2.0 Implementation", _
        App.Path & "\" & App.EXEName & ".EXE"
    'Load the plug-ins into memory.
    LoadPlugIns
    'Get Plug-In names:
    ParseCSV GetPlugIns, PlugIns
    'Get Supported Arhive formats:
    ParseCSV GetSupportedArchives, SupportedArchives
    ShowInStatBar UBound(SupportedArchives) + 1 & " archive formats supported."
    'Get Compressible Arhive formats:
    ParseCSV GetCompressibleArchives, CompressibleArchives
    'Form Compression Filter:
    CompressFilter = FormFilterString(CompressibleArchives)
    'Get Extractable Archive formats:
    ParseCSV GetExtractableArchives, ExtractableArchives
    'Form Extraction Filter:
    ExtractFilter = FormFilterString(ExtractableArchives)
    'Form Open Filter:
    OpenFilter = "All Archives|"
    For i = 0 To UBound(ExtractableArchives)
        OpenFilter = OpenFilter & "*." & ExtractableArchives(i) & ";"
    Next
    OpenFilter = Left(OpenFilter, Len(OpenFilter) - 1)
    'Get Default Viewer Path:
    GenericViewerPath = GetGenericViewer
    'Enabled/Disabled Menus:
    mnuCloseitem.Enabled = False
    mnuAdditem.Enabled = False
    mnuExtractitem.Enabled = False
    mnuViewitem.Enabled = False
    mnuInstallitem.Enabled = False
    mnuToolitem(0).Enabled = False
    mnuSelectAllitem.Enabled = False
    'Toolbar:
    For i = 1 To Toolbar.Buttons.Count
        Toolbar.Buttons(i).Image = ImageListToolBar.ListImages(i).Index
    Next
    'I added this because the loading session completes too fast!
    'The user cannot see the splash screen properly.
    Sleep 1000
    'When loading is complete hide the splash screen.
    EndSplash
    
ErrorHandler:
    If Err = 53 Then
        MsgBox "Codex API DLL not found. Please install MimarSinan" & _
            " Codex Suite first.", vbCritical, "DLL Not Found"
        End
    End If
    
End Sub

Private Sub Form_Resize()
    If Me.WindowState <> vbMinimized Then
        ListView.Width = Me.ScaleWidth
        ListView.Height = Me.ScaleHeight
        StatusBar.Panels(1).Width = Me.ScaleWidth
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    'Unload the plug-ins from the memory on exit.
    FreePlugIns
End Sub

Private Sub ListView_DblClick()
    If ListView.ListItems.Count > 0 Then
        mnuExtractitem_Click
    End If
End Sub

Private Sub ListView_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = vbRightButton Then
        Me.PopupMenu mnuAction
    End If
End Sub

Private Sub mnuAboutitem_Click()
    CodexAbout ExtractAssociatedIcon(App.hInstance, App.Path & "\" & App.EXEName & ".EXE", 2), _
        "ArchiveX (Codex 2.0 Implementation)", _
        "Copyright© 2002 MimarSinan International." & vbNewLine & "All rights reserved.", _
        "Designed and engineered at MimarSinan Research Labs.", _
        "http://www.mimarsinan.com", _
        "Version: " & App.Major & "." & App.Minor & "." & App.Revision
End Sub

Private Sub mnuAdditem_Click()
    AddFilesToArchive Session
End Sub

Private Sub mnuCheckOutitem_Click()
    
    Dim sArchive As String
    Dim sPath As String
    
    On Error Resume Next
    
    'Prompt archive to check out:
    If Len(Session) = 0 Then
        CommonDialog.DialogTitle = "Open Archive"
        CommonDialog.FileName = ""
        CommonDialog.Filter = ExtractFilter
        CommonDialog.Flags = cdlOFNExplorer + _
            cdlOFNFileMustExist + _
            cdlOFNHideReadOnly
        CommonDialog.ShowOpen
        If Err = cdlCancel Then
            Err.Clear
            Exit Sub
        End If
        sArchive = CommonDialog.FileName
        GetSessionParameters sArchive
        ExploreArchive sArchive, False
    Else
        sArchive = Session
    End If
    
    'Prompt destination:
    sPath = BrowseForFolder(Me.hWnd)
    If Len(sPath) = 0 Then
        Exit Sub
    End If
    
    'Check out:
    CheckOutArchive sArchive, sPath, ".exe"
    
End Sub

Private Sub mnuCloseitem_Click()
    
    'Close current Session:
    Dim i As Integer
    
    ShowInStatBar "Closed " & SessionTitle
    Session = ""
    SessionPath = ""
    SessionTitle = ""
    SessionExt = ""
    Me.Caption = "MimarSinan ArchiveX (Codex 2.0 Implementation)"
    ListView.ListItems.Clear
    mnuCloseitem.Enabled = False
    mnuAdditem.Enabled = False
    mnuExtractitem.Enabled = False
    mnuViewitem.Enabled = False
    mnuSelectAllitem.Enabled = False
    If mnuToolitem.Count > 1 Then
        mnuToolitem(0).Visible = True
        For i = mnuToolitem.UBound To 1 Step -1
            Unload mnuToolitem(i)
        Next
    End If
    For i = 3 To 5
        Toolbar.Buttons(i).Enabled = False
    Next
    
End Sub

Private Sub mnuConfigurationitem_Click()
    frmConfiguration.Show vbModal, Me
End Sub

Private Sub mnuConvertitem_Click()

    Dim sArchive As String
    Dim sNewArchive As String

    On Error Resume Next

    'Source:
    If Len(Session) = 0 Then
        CommonDialog.DialogTitle = "Convert Archive"
        CommonDialog.FileName = ""
        CommonDialog.Filter = ExtractFilter
        CommonDialog.Flags = cdlOFNExplorer + _
            cdlOFNFileMustExist + _
            cdlOFNHideReadOnly
        CommonDialog.ShowOpen
        If Err = cdlCancel Then
            Err.Clear
            Exit Sub
        End If
        sArchive = CommonDialog.FileName
    Else
        sArchive = Session
    End If
    
    'Destination:
    CommonDialog.DialogTitle = "Save Archive As"
    CommonDialog.FileName = ""
    CommonDialog.Filter = CompressFilter
    CommonDialog.Flags = cdlOFNCreatePrompt + _
        cdlOFNExplorer + _
        cdlOFNHideReadOnly
    CommonDialog.ShowSave
    If Err = cdlCancel Then
        Err.Clear
        Exit Sub
    End If
    sNewArchive = CommonDialog.FileName
    
    ConvertArchive sArchive, sNewArchive
    EraseWorkingFiles
    GetSessionParameters sNewArchive
    ExploreArchive sNewArchive, False
    
End Sub

Private Sub mnuExititem_Click()
    Unload Me
End Sub

Private Sub mnuExtractitem_Click()
    
    Dim i As Integer
    Dim iBound As Integer
    Dim FileName() As String
    Dim sFileNames As String
    Dim sPath As String
    
    If ListView.ListItems.Count = 0 Then
        MsgBox "There are no files to extract in this archive !", vbExclamation, "Extract"
        Exit Sub
    End If
    iBound = 0
    For i = 1 To ListView.ListItems.Count
        If ListView.ListItems(i).Selected Then
            ReDim Preserve FileName(i - 1)
            FileName(i - 1) = ListView.ListItems(i)
            iBound = iBound + 1
        End If
    Next
    sFileNames = ArrayToCSV(FileName)
    
    sPath = BrowseForFolder(Me.hWnd)
    If Len(sPath) = 0 Then
        Exit Sub
    End If
    ExtractArchive Session, sPath, sFileNames, "Default"
    ShowInStatBar iBound & " file(s) extracted to folder " & sPath
        
End Sub

Private Sub mnuInstallitem_Click()
    InstallArchive Session
    'Delete any temporary files:
    EraseWorkingFiles
End Sub

Private Sub mnuNewitem_Click()
    On Error Resume Next
    'Prompt the path of the new archive.
    CommonDialog.DialogTitle = "Save Archive As"
    CommonDialog.FileName = ""
    CommonDialog.Filter = CompressFilter
    CommonDialog.Flags = cdlOFNCreatePrompt + _
        cdlOFNExplorer + _
        cdlOFNHideReadOnly
    CommonDialog.ShowSave
    If Err = cdlCancel Then
        Err.Clear
        Exit Sub
    End If
    GetSessionParameters CommonDialog.FileName
    AddFilesToArchive CommonDialog.FileName
End Sub

Private Sub mnuOpenitem_Click()
    On Error Resume Next
    CommonDialog.DialogTitle = "Open Archive"
    CommonDialog.FileName = ""
    CommonDialog.Filter = OpenFilter
    CommonDialog.Flags = cdlOFNExplorer + _
        cdlOFNFileMustExist + _
        cdlOFNHideReadOnly
    CommonDialog.ShowOpen
    If Err = cdlCancel Then
        Exit Sub
    End If
    GetSessionParameters CommonDialog.FileName
    ExploreArchive CommonDialog.FileName, False
End Sub

Private Sub mnuSelectAllitem_Click()
    Dim i As Integer
    For i = 1 To ListView.ListItems.Count
        ListView.ListItems(i).Selected = True
    Next
End Sub

Private Sub mnuToolitem_Click(Index As Integer)
    
    Dim i As Integer
    Dim iBound As Integer
    Dim FileName() As String
    Dim sFileNames As String
    
    iBound = 0
    For i = 1 To ListView.ListItems.Count
        If ListView.ListItems(i).Selected Then
            ReDim Preserve FileName(iBound)
            FileName(iBound) = ListView.ListItems(i)
            iBound = iBound + 1
        End If
    Next
    sFileNames = ArrayToCSV(FileName)
    RunArchiveTool Session, sFileNames, mnuToolitem(Index).Caption
    ExploreArchive Session, True
        
End Sub

Private Sub mnuViewitem_Click()
    Dim i As Integer
    For i = 1 To ListView.ListItems.Count
        If ListView.ListItems(i).Selected = True Then
            ViewUpdateArchive Session, ListView.ListItems(i), True
            Exit For
        End If
    Next
End Sub

Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
    Case "new": mnuNewitem_Click
    Case "open": mnuOpenitem_Click
    Case "add": mnuAdditem_Click
    Case "extract": mnuExtractitem_Click
    Case "view": mnuViewitem_Click
    End Select
End Sub
