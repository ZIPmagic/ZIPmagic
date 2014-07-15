# Microsoft Developer Studio Project File - Name="unstuff" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=unstuff - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "unstuff.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "unstuff.mak" CFG="unstuff - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "unstuff - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "unstuff - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "unstuff - Win32 Release Static" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "unstuff - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../../bin"
# PROP Intermediate_Dir "../../bin/unstuff"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../../binD"
# PROP Intermediate_Dir "../../binD/unstuff"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /Zi /Od /I "../../../src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /debug /machine:I386 /out:"../../binD/unstuffD.exe" /pdbtype:sept

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "unstuff___Win32_Release_Static"
# PROP BASE Intermediate_Dir "unstuff___Win32_Release_Static"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../../binS"
# PROP Intermediate_Dir "../../binS/unstuff"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT BASE CPP /YX
# ADD CPP /nologo /MT /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /out:"../../binS/unstuffS.exe"

!ENDIF 

# Begin Target

# Name "unstuff - Win32 Release"
# Name "unstuff - Win32 Debug"
# Name "unstuff - Win32 Release Static"
# Begin Group "app::option::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\app\option\MacBinaryOutput.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\option\TextConversion.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\option\TextType.h
# End Source File
# End Group
# Begin Group "app::unstuff::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\BehavedReader.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\ChattyReader.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\QuietReader.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\Reader.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\ThreadedReader.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\ThreadedReader.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\unstuff\unstuff.main.cpp
# End Source File
# End Group
# Begin Group "format::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\format\Exception.h
# End Source File
# End Group
# Begin Group "format::data::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\format\data\data.OSType.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\format\data\OSType.h
# End Source File
# End Group
# Begin Group "stream::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\stream\common.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\CopyInput.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\CopyOutput.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\Exception.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\Input.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\Output.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\Readable.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\stream.Input.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\stream.Output.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\TextType.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\stream\Writable.h
# End Source File
# End Group
# Begin Group "un::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\un\un.tokenizer.cpp
# End Source File
# End Group
# Begin Group "util::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\util\System.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\util.System.w32.cpp
# End Source File
# End Group
# Begin Group "util::command::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\util\command\command.CommandElement.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\command.CommandLine.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\Command.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\CommandElement.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\CommandElementLess.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\CommandException.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\CommandLine.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\util\command\CommandSynonym.h
# End Source File
# End Group
# Begin Source File

SOURCE="..\..\bin\stuffit5.engine-5.1.lib"

!IF  "$(CFG)" == "unstuff - Win32 Release"

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE="..\..\binD\stuffit5.engineD-5.1.lib"

!IF  "$(CFG)" == "unstuff - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\binS\stuffit5.engineS.lib

!IF  "$(CFG)" == "unstuff - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

!ENDIF 

# End Source File
# End Target
# End Project
