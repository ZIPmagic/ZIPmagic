Attribute VB_Name = "CodexModule"
'==========================================================================
'Copyright(c) 1992-2002 MimarSinan International. All rights reserved.
'This source code provided for demonstrative use only. All rights reserved.
'==========================================================================

Option Explicit

Public Declare Sub BindPlugIn Lib "mCodexAPI" ( _
    ByVal lpName As String, _
    ByVal lpArchive As String)

Public Declare Sub UnBindPlugIn Lib "mCodexAPI" ( _
    ByVal lpName As String, _
    ByVal lpArchive As String)

Public Declare Function GetCompressibleArchives Lib "mCodexAPI" () As String

Public Declare Function GetExtractableArchives Lib "mCodexAPI" () As String

Public Declare Function GetSupportedArchives Lib "mCodexAPI" () As String

Public Declare Function QueryArchive Lib "mCodexAPI" ( _
    ByVal lbFileName As String, _
    ByRef lpItems As String, _
    ByRef lpPwdItems As String, _
    ByRef lpDateItems As String, _
    ByRef lpSizes As String, _
    ByRef lpCompSizes As String) As String

Public Declare Sub CreateMergedArchive Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpRecurse As String, _
    ByVal lpNormal As String, _
    ByVal lpProfile As String)
    
Public Declare Sub CreateSingularArchives Lib "mCodexAPI" ( _
    ByVal lpArchiveType As String, _
    ByVal lpPath As String, _
    ByVal lpFiles As String, _
    ByVal lpProfie As String)

Public Declare Sub ExtractArchive Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpPath As String, _
    ByVal lpFiles As String, _
    ByVal lpProfile As String)

Public Declare Sub InstallArchive Lib "mCodexAPI" (ByVal lpArchive As String)

Public Declare Sub CheckOutArchive Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpPath As String, _
    ByVal lpIcons As String)

Public Declare Sub ConvertArchive Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpNewArchive As String)

Public Declare Sub ViewUpdateArchive Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpItem As String, _
    ByVal bPrompt As Boolean)

Public Declare Function GetArchiveTools Lib "mCodexAPI" ( _
    ByVal lpArchive As String) As String
    
Public Declare Function GetArchiveToolHints Lib "mCodexAPI" ( _
    ByVal lpArchive As String) As String

Public Declare Sub RunArchiveTool Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpItems As String, _
    ByVal lpTool As String)

Public Declare Function GetCompressionProfiles Lib "mCodexAPI" ( _
    ByVal lpArchive As String) As String

Public Declare Function GetExtractionProfiles Lib "mCodexAPI" ( _
    ByVal lpArchive As String) As String

Public Declare Sub EditCompressionProfile Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpProfile As String)

Public Declare Sub EditExtractionProfile Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpProfile As String)

Public Declare Sub DeleteCompressionProfile Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpProfile As String)

Public Declare Sub DeleteExtractionProfile Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpProfile As String)

Public Declare Function LoadPlugIns Lib "mCodexAPI" () As Integer

Public Declare Sub FreePlugIns Lib "mCodexAPI" ()

Public Declare Function GetPlugIns Lib "mCodexAPI" () As String

Public Declare Sub ShowPlugInAbout Lib "mCodexAPI" (ByVal lpPlugIn As String)

Public Declare Function GetArchives Lib "mCodexAPI" () As String

Public Declare Function GetArchivesByPlugIn Lib "mCodexAPI" ( _
    ByVal lpPlugIn As String) As String

Public Declare Function GetArchiveFunctionsByPlugIn Lib "mCodexAPI" ( _
    ByVal lpArchive As String, _
    ByVal lpPlugIn As String) As String

Public Declare Sub StartSplash Lib "mCodexAPI" ( _
    ByVal lpTitle As String, _
    ByVal lpIcon As String)

Public Declare Sub EndSplash Lib "mCodexAPI" ()

Public Declare Sub CodexAbout Lib "mCodexAPI" ( _
    ByVal hIcon As Long, _
    ByVal lpProduct As String, _
    ByVal lpCopyright As String, _
    ByVal lpDesign As String, _
    ByVal lpDesignURL As String, _
    ByVal lpVersion As String)

Public Declare Sub EditCodexAssociations Lib "mCodexAPI" ()

Public Declare Function EditPlugInBindings Lib "mCodexAPI" () As Boolean

Public Declare Sub CheckCodexAssociations Lib "mCodexAPI" ()

Public Declare Function ForceCodexAssociations Lib "mCodexAPI" () As Integer

Public Declare Function GetGenericViewer Lib "mCodexAPI" () As String

Public Declare Sub SetGenericViewer Lib "mCodexAPI" (ByVal lpViewer As String)

Public Declare Sub EraseWorkingFiles Lib "mCodexAPI" ()

Public Declare Function GetArhiveInfo Lib "mCodexAPI" ( _
    ByVal lpFileName As String, _
    ByVal bSilent As Boolean, _
    ByRef lpItems As String, _
    ByRef lpPwdItems As String, _
    ByRef lpDateItems As String, _
    ByRef lpSizes As String, _
    ByRef lpCompSizes As String) As Integer

Public Declare Sub GetArchiveError Lib "mCodexAPI" ( _
    ByRef lpError As String)

Public Declare Sub CodexStandardFunction Lib "mCodexAPI" ( _
    lpFunction As String, _
    lpParam1 As String, _
    lpParam2 As String)

