VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Begin VB.Form frmConfiguration 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Configuration"
   ClientHeight    =   5760
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6855
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   8.25
      Charset         =   162
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmConfiguration.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   384
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   457
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdClose 
      Cancel          =   -1  'True
      Caption         =   "&Close"
      Height          =   375
      Left            =   5520
      TabIndex        =   31
      Top             =   5280
      Width           =   1215
   End
   Begin VB.Frame fraConfiguration 
      Caption         =   "Installed Plug-Ins"
      Height          =   4575
      Index           =   0
      Left            =   240
      TabIndex        =   4
      Top             =   480
      Visible         =   0   'False
      Width           =   6375
      Begin VB.ListBox lstFeatures 
         Height          =   3180
         Left            =   2520
         TabIndex        =   2
         Top             =   480
         Width           =   3735
      End
      Begin MSComctlLib.TreeView tvwPlugIns 
         Height          =   3180
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   5609
         _Version        =   393217
         LabelEdit       =   1
         LineStyle       =   1
         Style           =   7
         Appearance      =   1
      End
      Begin VB.CommandButton cmdShowPlugInAbout 
         Caption         =   "About Plug-In..."
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   4080
         Width           =   1695
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Features:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   162
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   2520
         TabIndex        =   6
         Top             =   240
         Width           =   930
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Plug-Ins:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   162
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   885
      End
      Begin VB.Label lblSupportedArchivesCount 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   162
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3120
         TabIndex        =   32
         Top             =   3720
         Width           =   375
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Total Supported Archive Formats:"
         Height          =   195
         Left            =   120
         TabIndex        =   7
         Top             =   3720
         Width           =   2895
      End
   End
   Begin VB.Frame fraConfiguration 
      Caption         =   "(De)Compression Profiles"
      Height          =   4575
      Index           =   1
      Left            =   240
      TabIndex        =   17
      Top             =   480
      Visible         =   0   'False
      Width           =   6375
      Begin VB.CommandButton cmdDeleteExtractionProfile 
         Caption         =   "Delete Profile"
         Enabled         =   0   'False
         Height          =   375
         Left            =   3240
         TabIndex        =   16
         Top             =   4080
         Width           =   3015
      End
      Begin VB.CommandButton cmdEditExtractionProfile 
         Caption         =   "Edit Profile"
         Enabled         =   0   'False
         Height          =   375
         Left            =   3240
         TabIndex        =   15
         Top             =   3600
         Width           =   3015
      End
      Begin VB.CommandButton cmdNewExtractionProfile 
         Caption         =   "New Profile"
         Enabled         =   0   'False
         Height          =   375
         Left            =   3240
         TabIndex        =   14
         Top             =   3120
         Width           =   3015
      End
      Begin VB.CommandButton cmdDeleteCompressionProfile 
         Caption         =   "Delete Profile"
         Enabled         =   0   'False
         Height          =   375
         Left            =   120
         TabIndex        =   12
         Top             =   4080
         Width           =   3015
      End
      Begin VB.CommandButton cmdEditCompressionProfile 
         Caption         =   "Edit Profile"
         Enabled         =   0   'False
         Height          =   375
         Left            =   120
         TabIndex        =   11
         Top             =   3600
         Width           =   3015
      End
      Begin VB.CommandButton cmdNewCompressionProfile 
         Caption         =   "New Profile"
         Enabled         =   0   'False
         Height          =   375
         Left            =   120
         TabIndex        =   10
         Top             =   3120
         Width           =   3015
      End
      Begin VB.ListBox lstExtractionProfiles 
         BackColor       =   &H8000000F&
         Enabled         =   0   'False
         Height          =   2010
         Left            =   3240
         TabIndex        =   13
         Top             =   960
         Width           =   3015
      End
      Begin VB.ListBox lstCompressionProfiles 
         BackColor       =   &H8000000F&
         Enabled         =   0   'False
         Height          =   2010
         Left            =   120
         TabIndex        =   9
         Top             =   960
         Width           =   3015
      End
      Begin VB.ComboBox cboArchives 
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   240
         Width           =   4215
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Decompression Profiles"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   162
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   3240
         TabIndex        =   20
         Top             =   720
         Width           =   2310
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Compression Profiles"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   162
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   19
         Top             =   720
         Width           =   2070
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Select Archive:"
         Height          =   195
         Left            =   120
         TabIndex        =   18
         Top             =   300
         Width           =   1305
      End
   End
   Begin VB.Frame fraConfiguration 
      Caption         =   "Codex Settings"
      Height          =   4575
      Index           =   2
      Left            =   240
      TabIndex        =   26
      Top             =   480
      Visible         =   0   'False
      Width           =   6375
      Begin VB.CommandButton cmdEditPlugInBindings 
         Caption         =   "Plug-In Bindings"
         Height          =   375
         Left            =   240
         TabIndex        =   25
         Top             =   3480
         Width           =   2055
      End
      Begin VB.TextBox txtViewerPath 
         Height          =   285
         Left            =   240
         TabIndex        =   21
         Top             =   600
         Width           =   5415
      End
      Begin VB.CommandButton cmdBrowseViewer 
         Caption         =   "..."
         Height          =   285
         Left            =   5760
         TabIndex        =   22
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton cmdForceCodexAssociations 
         Caption         =   "Force Associations"
         Height          =   375
         Left            =   240
         TabIndex        =   24
         Top             =   2400
         Width           =   2055
      End
      Begin VB.CommandButton cmdEditCodexAssociations 
         Caption         =   "Edit Associations"
         Height          =   375
         Left            =   240
         TabIndex        =   23
         Top             =   1560
         Width           =   2055
      End
      Begin MSComDlg.CommonDialog CommonDialog 
         Left            =   5760
         Top             =   3960
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "Manages Types:"
         Height          =   195
         Left            =   240
         TabIndex        =   30
         Top             =   3240
         Width           =   1395
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Default Viewer:"
         Height          =   195
         Left            =   240
         TabIndex        =   27
         Top             =   360
         Width           =   1335
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Force File Associations (Associate all Files with Codex):"
         Height          =   195
         Left            =   240
         TabIndex        =   29
         Top             =   2160
         Width           =   4725
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Manage File Associations (Associate Files yourself):"
         Height          =   195
         Left            =   240
         TabIndex        =   28
         Top             =   1320
         Width           =   4395
      End
   End
   Begin MSComctlLib.TabStrip TabStrip 
      Height          =   5055
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6615
      _ExtentX        =   11668
      _ExtentY        =   8916
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "&Plug-Ins"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "P&rofiles"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "&Settings"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmConfiguration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==========================================================================
'Copyright(c) 1992-2002 MimarSinan International. All rights reserved.
'This source code provided for demonstrative use only. All rights reserved.
'==========================================================================

Option Explicit

Dim RestrictedProfiles(2) As String

Private Sub cboArchives_Click()
    
    'Display the compression and extraction profiles on the ListBoxes:
    
    Dim CompressionProfiles() As String
    Dim CompressionProfilesFull As String
    Dim ExtractionProfiles() As String
    Dim ExtractionProfilesFull As String
    Dim IsEnabled As Boolean
    Dim i As Integer
    
    lstCompressionProfiles.Clear
    lstExtractionProfiles.Clear
    
    If InArray(cboArchives, CompressibleArchives) Then
        CompressionProfilesFull = GetCompressionProfiles(cboArchives)
        If Len(CompressionProfilesFull) = 0 Then
            IsEnabled = False
        Else
            IsEnabled = True
            ParseCSV CompressionProfilesFull, CompressionProfiles
            For i = 0 To UBound(CompressionProfiles)
                lstCompressionProfiles.AddItem CompressionProfiles(i)
            Next
        End If
    Else
        IsEnabled = False
    End If
    If IsEnabled Then
        lstCompressionProfiles.Enabled = True
        lstCompressionProfiles.BackColor = &H80000005
        cmdNewCompressionProfile.Enabled = True
        cmdEditCompressionProfile.Enabled = True
        cmdDeleteCompressionProfile.Enabled = True
    Else
        lstCompressionProfiles.Enabled = False
        lstCompressionProfiles.BackColor = &H8000000F
        cmdNewCompressionProfile.Enabled = False
        cmdEditCompressionProfile.Enabled = False
        cmdDeleteCompressionProfile.Enabled = False
    End If
    
    If InArray(cboArchives, ExtractableArchives) Then
        ExtractionProfilesFull = GetExtractionProfiles(cboArchives)
        If Len(ExtractionProfilesFull) = 0 Then
            IsEnabled = False
        Else
            IsEnabled = True
            ParseCSV ExtractionProfilesFull, ExtractionProfiles
            For i = 0 To UBound(ExtractionProfiles)
                lstExtractionProfiles.AddItem ExtractionProfiles(i)
            Next
        End If
    Else
        IsEnabled = False
    End If
    If IsEnabled Then
        lstExtractionProfiles.Enabled = True
        lstExtractionProfiles.BackColor = &H80000005
        cmdNewExtractionProfile.Enabled = True
        cmdEditExtractionProfile.Enabled = True
        cmdDeleteExtractionProfile.Enabled = True
    Else
        lstExtractionProfiles.Enabled = False
        lstExtractionProfiles.BackColor = &H8000000F
        cmdNewExtractionProfile.Enabled = False
        cmdEditExtractionProfile.Enabled = False
        cmdDeleteExtractionProfile.Enabled = False
    End If
    
End Sub

Private Sub cmdBrowseViewer_Click()
    'Browse for Default Viewer:
    CommonDialog.FileName = ""
    CommonDialog.Flags = cdlOFNFileMustExist + cdlOFNHideReadOnly
    CommonDialog.Filter = "Programs (*.EXE)|*.EXE"
    CommonDialog.ShowOpen
    If Len(CommonDialog.FileName) > 0 Then
        GenericViewerPath = CommonDialog.FileName
        txtViewerPath = GenericViewerPath
        SetGenericViewer GenericViewerPath
    End If
End Sub

Private Sub cmdClose_Click()
    Unload Me
End Sub

Private Sub cmdDeleteCompressionProfile_Click()
    'Delete Compression Profile:
    If lstCompressionProfiles.ListIndex = -1 Then
        MsgBox "Please select a Compression Profile to delete from the list.", _
            vbExclamation, _
            "Delete Compression Profile"
    Else
        If InArray(lstCompressionProfiles, RestrictedProfiles) Then
            MsgBox "You cannot delete Built-In profiles.", _
                vbExclamation, _
                "Delete Compression Profile"
        Else
            If MsgBox("Are you sure you want to delete the selected Compression Profile ?", _
                vbQuestion + vbYesNo, _
                "Delete Compression Profile") = vbYes Then
                DeleteCompressionProfile cboArchives, lstCompressionProfiles
                cboArchives_Click
            End If
        End If
    End If
End Sub

Private Sub cmdDeleteExtractionProfile_Click()
    'Delete Extraction Profile:
    If lstExtractionProfiles.ListIndex = -1 Then
        MsgBox "Please select a Extraction Profile to delete from the list.", _
            vbExclamation, _
            "Delete Extraction Profile"
    Else
        If InArray(lstExtractionProfiles, RestrictedProfiles) Then
            MsgBox "You cannot delete Built-In profiles.", _
                vbExclamation, _
                "Delete Extraction Profile"
        Else
            If MsgBox("Are you sure you want to delete the selected Extraction Profile ?", _
                vbQuestion + vbYesNo, _
                "Delete Extraction Profile") = vbYes Then
                DeleteExtractionProfile cboArchives, lstExtractionProfiles
                cboArchives_Click
            End If
        End If
    End If
End Sub

Private Sub cmdEditCodexAssociations_Click()
    'Edit File Associations:
    EditCodexAssociations
End Sub

Private Sub cmdEditCompressionProfile_Click()
    'Edit Compression Profile:
    If lstCompressionProfiles.ListIndex = -1 Then
        MsgBox "Please select a Compression Profile to edit from the list.", _
            vbExclamation, _
            "Edit Compression Profile"
    Else
        EditCompressionProfile cboArchives, lstCompressionProfiles
    End If
End Sub

Private Sub cmdEditExtractionProfile_Click()
    'Edit Extraction Profile:
    If lstExtractionProfiles.ListIndex = -1 Then
        MsgBox "Please select a Extraction Profile to edit from the list.", _
            vbExclamation, _
            "Edit Extraction Profile"
    Else
        EditExtractionProfile cboArchives, lstExtractionProfiles
    End If
End Sub

Private Sub cmdEditPlugInBindings_Click()
    If EditPlugInBindings Then
        FreePlugIns
        LoadPlugIns
    End If
End Sub

Private Sub cmdForceCodexAssociations_Click()
    'Force File Associations:
    ForceCodexAssociations
End Sub

Private Sub cmdNewCompressionProfile_Click()
    
    'Create a new compression profile:
    
    Dim NewCompressionProfileName As String
    
    NewCompressionProfileName = InputBox("Please enter the name of the new Compression Profile:", _
        "New Compression Profile")
    If Len(NewCompressionProfileName) > 0 Then
        If ProfileExists(NewCompressionProfileName, cboArchives, cxCompression) Then
            MsgBox "Specified Compression Profile already exists.", _
                vbExclamation, _
                "Compression Profile Exists"
        Else
            EditCompressionProfile cboArchives, NewCompressionProfileName
            lstCompressionProfiles.AddItem NewCompressionProfileName
        End If
    End If
    
End Sub

Private Sub cmdNewExtractionProfile_Click()
    
    'Create a new Extraction profile:
    
    Dim NewExtractionProfileName As String
    
    NewExtractionProfileName = InputBox("Please enter the name of the new Extraction Profile:", _
        "New Extraction Profile")
    If Len(NewExtractionProfileName) > 0 Then
        If ProfileExists(NewExtractionProfileName, cboArchives, cxExtraction) Then
            MsgBox "Specified Extraction Profile already exists.", _
                vbExclamation, _
                "Extraction Profile Exists"
        Else
            EditExtractionProfile cboArchives, NewExtractionProfileName
            lstExtractionProfiles.AddItem NewExtractionProfileName
        End If
    End If
    
End Sub

Private Sub cmdShowPlugInAbout_Click()
    'Display the about box for the chosen plug-in:
    If tvwPlugIns.SelectedItem.Children = 0 Then
        ShowPlugInAbout tvwPlugIns.SelectedItem.Parent.Key
    Else
        ShowPlugInAbout tvwPlugIns.SelectedItem.Key
    End If
End Sub

Private Sub Form_Load()
    
    Dim i As Integer
    Dim j As Integer
    Dim ArchivesByPlugIn() As String
    
    'Restricted Profiles which cannot be deleted:
    RestrictedProfiles(0) = "Default"
    RestrictedProfiles(1) = "Shell"
    RestrictedProfiles(2) = "Structured"
        
    'Plug-Ins Tab:
    For i = 0 To UBound(PlugIns)
        tvwPlugIns.Nodes.Add , , PlugIns(i), PlugIns(i)
        ParseCSV GetArchivesByPlugIn(PlugIns(i)), ArchivesByPlugIn
        For j = 0 To UBound(ArchivesByPlugIn)
            tvwPlugIns.Nodes.Add PlugIns(i), _
                tvwChild, _
                PlugIns(i) & ArchivesByPlugIn(j), _
                ArchivesByPlugIn(j)
        Next
    Next
    tvwPlugIns.Nodes(1).Selected = True
    lblSupportedArchivesCount.Caption = UBound(SupportedArchives) + 1
    
    'Profiles Tab:
    For i = 0 To UBound(SupportedArchives)
        cboArchives.AddItem SupportedArchives(i)
    Next
    
    'Program Locations Tab:
    txtViewerPath = GenericViewerPath
    
    TabStrip_Click
    
End Sub

Private Sub lstCompressionProfiles_DblClick()
    If lstCompressionProfiles.ListCount > 0 Then
        cmdEditCompressionProfile_Click
    End If
End Sub

Private Sub lstExtractionProfiles_DblClick()
    If lstExtractionProfiles.ListCount > 0 Then
        cmdEditExtractionProfile_Click
    End If
End Sub

Private Sub TabStrip_Click()
    
    Dim i As Integer
    
    For i = 0 To fraConfiguration.UBound
        fraConfiguration(i).Visible = False
    Next
    fraConfiguration(TabStrip.SelectedItem.Index - 1).Visible = True
    
End Sub

Private Sub tvwPlugIns_Click()
    'Show Plug-In features in the ListBox:
    lstFeatures.Clear
    If tvwPlugIns.SelectedItem.Children = 0 Then
        Dim ArchiveFunctionsByPlugIn() As String
        Dim i As Integer
        ParseCSV GetArchiveFunctionsByPlugIn( _
            tvwPlugIns.SelectedItem, tvwPlugIns.SelectedItem.Parent), _
            ArchiveFunctionsByPlugIn
        For i = 0 To UBound(ArchiveFunctionsByPlugIn)
            lstFeatures.AddItem ArchiveFunctionsByPlugIn(i)
        Next
    Else
        lstFeatures.AddItem "Supports " & tvwPlugIns.SelectedItem.Children & " archive(s)"
        lstFeatures.AddItem "Expand for more information"
    End If
End Sub
