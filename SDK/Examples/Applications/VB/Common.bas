Attribute VB_Name = "Common"
'==========================================================================
'Copyright(c) 1992-2002 MimarSinan International. All rights reserved.
'This source code provided for demonstrative use only. All rights reserved.
'==========================================================================

Option Explicit

'Private Module Declarations:

Private Const BIF_RETURNONLYFSDIRS = 1
Private Const MAX_PATH = 260

Private Declare Sub CoTaskMemFree Lib "ole32.dll" (ByVal hMem As Long)
Private Declare Function lstrcat Lib "kernel32" Alias "lstrcatA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long
Private Declare Function SHBrowseForFolder Lib "shell32" (lpbi As BrowseInfo) As Long
Private Declare Function SHGetPathFromIDList Lib "shell32" (ByVal pidList As Long, ByVal lpBuffer As String) As Long

Private Type BrowseInfo
    hWndOwner As Long
    pIDLRoot As Long
    pszDisplayName As Long
    lpszTitle As Long
    ulFlags As Long
    lpfnCallback As Long
    lParam As Long
    iImage As Long
End Type

'Public Declarations:

'Arrays:
Public PlugIns() As String
Public SupportedArchives() As String
Public CompressibleArchives() As String
Public ExtractableArchives() As String

'Variables:
Public Session As String
Public SessionPath As String
Public SessionTitle As String
Public SessionExt As String

Public GenericViewerPath As String

'Public Enums:
Public Enum CodexJobTypes
    cxExtraction = 0
    cxCompression = 1
End Enum

'Functions and Procedures:

'Windows API:

Public Declare Function ExtractAssociatedIcon Lib "shell32.dll" Alias "ExtractAssociatedIconA" (ByVal hInst As Long, ByVal lpIconPath As String, lpiIcon As Long) As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

'Common:

'Converts an array into a commatext.
'Examples:
'Array: 1, 10, 100 - CommaText: "1,10,100"
'Array: String1, Str,ing2, Str"ing3 - CommaText: "String1,"Str,ing2",Str""ing3"
Public Function ArrayToCSV(SourceArray As Variant) As String

    Dim i As Integer
    Dim sFull As String
    Dim sItem As String
    Dim iPos As Integer

    If UBound(SourceArray) = 0 Then
        sFull = """" & SourceArray(0) & """"
    Else
        sFull = ""
        For i = 0 To UBound(SourceArray)
            sItem = SourceArray(i)
            iPos = 1
            Do
                iPos = InStr(iPos, sItem, """")
                If iPos = 0 Then
                    Exit Do
                End If
                sItem = Mid(sItem, 1, iPos) & """" & Mid(sItem, iPos + 1)
                iPos = iPos + 2
            Loop
            If InStr(1, sItem, ",") > 0 Or InStr(1, sItem, " ") > 0 Then
                sItem = """" & sItem & """"
            End If
            iPos = 0
            sFull = sFull & sItem & ","
        Next
        sFull = Left(sFull, Len(sFull) - 1)
    End If
    ArrayToCSV = sFull

End Function

'Opens 'Browse for Folder' dialog.
'Returns the Folder selected.
'Return NULL if the user presses 'Cancel' button.
Public Function BrowseForFolder(hWnd As Long) As String
    
    Dim iNull As Integer
    Dim lpIDList As Long
    Dim lResult As Long
    Dim sPath As String
    Dim udtBI As BrowseInfo

    With udtBI
        .hWndOwner = hWnd
        .lpszTitle = lstrcat("C:\", "")
        .ulFlags = BIF_RETURNONLYFSDIRS
    End With

    lpIDList = SHBrowseForFolder(udtBI)
    If lpIDList Then
        sPath = String$(MAX_PATH, 0)
        SHGetPathFromIDList lpIDList, sPath
        CoTaskMemFree lpIDList
        iNull = InStr(sPath, vbNullChar)
        If iNull Then
            sPath = Left$(sPath, iNull - 1)
        End If
    End If

    BrowseForFolder = sPath

End Function

'Converts the FileName Property of CommonDialog to CommaText.
Public Function FormFilesCSV(cdlFileName As String) As String
    
    Dim iPos As Integer
    Dim sPath As String
    
    FormFilesCSV = ""
    If InStr(1, cdlFileName, vbNullChar) = 0 Then
        'Only one file selected.
        FormFilesCSV = """" & cdlFileName & """"
    Else
        'Extract the sPath:
        iPos = InStr(1, cdlFileName, vbNullChar)
        sPath = Mid(cdlFileName, 1, iPos - 1)
        cdlFileName = Mid(cdlFileName, iPos + 1)
        'Extract each file:
        Do
            iPos = InStr(1, cdlFileName, vbNullChar)
            If iPos = 0 Then
                Exit Do
            End If
            FormFilesCSV = FormFilesCSV & """" & sPath & "\" & Mid(cdlFileName, 1, iPos - 1) & ""","
            cdlFileName = Mid(cdlFileName, iPos + 1)
        Loop
        FormFilesCSV = FormFilesCSV & """" & sPath & "\" & cdlFileName & """"
    End If
    
End Function

'Forms the Filter Strings for CommonDialog.
Public Function FormFilterString(SourceArray() As String) As String

    Dim i As Integer
    Dim s As String
    
    FormFilterString = ""
    For i = 0 To UBound(SourceArray)
        s = SourceArray(i)
        FormFilterString = FormFilterString & s & " (*." & s & ")|*." & s & "|"
    Next
    FormFilterString = Left(FormFilterString, Len(FormFilterString) - 1)

End Function

'Returns whether the specified item exists in a given array.
Public Function InArray(SearchString As String, StringArray() As String) As Boolean
    Dim i As Integer
    InArray = False
    For i = 0 To UBound(StringArray)
        If UCase(SearchString) = UCase(StringArray(i)) Then
            InArray = True
            Exit For
        End If
    Next
End Function

'Returns whether the specified Compression/Extraction Profile exits.
Public Function ProfileExists(ProfileName As String, Archive As String, JobType As CodexJobTypes) As Boolean
    
    Dim sArray() As String
    Dim s As String
    
    If JobType = cxCompression Then
        s = GetCompressionProfiles(Archive)
    Else
        s = GetExtractionProfiles(Archive)
    End If
    ParseCSV s, sArray
    If InArray(ProfileName, sArray) Then
        ProfileExists = True
    Else
        ProfileExists = False
    End If
    
End Function

'Parses the given CommaText into Array.
'Examples:
'CommaText: "1,10,100" - Array: 1, 10, 100
'CommaText: "String1,"Str,ing2",Str""ing3" - Array: String1, Str,ing2, Str"ing3
Public Sub ParseCSV(CommaText As String, TargetArray As Variant)
    
    Dim i As Integer
    Dim sChr As String
    Dim sNextChr As String
    Dim iFirstPos As Integer
    Dim iNextPos As Integer
    Dim iBound As Integer
    
    ReDim TargetArray(0)
    iFirstPos = InStr(1, CommaText, vbNullChar)
    If iFirstPos > 0 Then
        CommaText = Mid(CommaText, 1, iFirstPos - 1)
    End If
    iBound = 0
    Do
        For i = 1 To Len(CommaText)
            iFirstPos = 0
            sChr = Mid(CommaText, i, 1)
            If sChr = """" Or sChr = "," Or sChr = " " Then
                iFirstPos = i
                Exit For
            End If
        Next
        If InStr(1, CommaText, """") = 0 And InStr(1, CommaText, ",") = 0 And InStr(1, CommaText, " ") = 0 Then
            If Len(CommaText) > 0 Then
                ReDim Preserve TargetArray(iBound)
                TargetArray(iBound) = CommaText
            End If
            Exit Do
        End If
        ReDim Preserve TargetArray(iBound)
        If sChr = """" Then
            iNextPos = iFirstPos + 1
            Do
                If Mid(CommaText, iNextPos, 1) = """" Then
                    sNextChr = Mid(CommaText, iNextPos + 1, 1)
                    If sNextChr = """" Then
                        iNextPos = iNextPos + 2
                    ElseIf sNextChr = "," Or sNextChr = " " Or iNextPos = Len(CommaText) Then
                        Exit Do
                    End If
                Else
                    iNextPos = iNextPos + 1
                End If
            Loop
            TargetArray(iBound) = Mid(CommaText, iFirstPos + 1, iNextPos - 2)
            CommaText = Mid(CommaText, iNextPos + 2)
        ElseIf sChr = "," Or sChr = " " Then
            TargetArray(iBound) = Mid(CommaText, 1, iFirstPos - 1)
            CommaText = Mid(CommaText, iFirstPos + 1)
        End If
        iBound = iBound + 1
    Loop
    For i = 0 To UBound(TargetArray)
        Do
            iFirstPos = InStr(1, TargetArray(i), """""")
            If iFirstPos = 0 Then
                Exit Do
            End If
            TargetArray(i) = Mid(TargetArray(i), 1, iFirstPos) & Mid(TargetArray(i), iFirstPos + 2)
        Loop
    Next
    
End Sub

'Displays the given text in the StatusBar.
Public Sub ShowInStatBar(StatusBarString As String)
    frmGUI.StatusBar.Panels(1) = StatusBarString
End Sub
