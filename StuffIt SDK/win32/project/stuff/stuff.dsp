# Microsoft Developer Studio Project File - Name="stuff" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=stuff - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "stuff.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "stuff.mak" CFG="stuff - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "stuff - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "stuff - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "stuff - Win32 Release Static" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "stuff - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../../bin"
# PROP Intermediate_Dir "../../bin/stuff"
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

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../../binD"
# PROP Intermediate_Dir "../../binD/stuff"
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
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /debug /machine:I386 /out:"../../binD/stuffD.exe" /pdbtype:sept

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "stuff___Win32_Release_Static"
# PROP BASE Intermediate_Dir "stuff___Win32_Release_Static"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../../binS"
# PROP Intermediate_Dir "../../binS/stuff"
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
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /out:"../../binS/stuffS.exe"

!ENDIF 

# Begin Target

# Name "stuff - Win32 Release"
# Name "stuff - Win32 Debug"
# Name "stuff - Win32 Release Static"
# Begin Group "app::option::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\app\option\TextType.h
# End Source File
# End Group
# Begin Group "app::stuff::"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\src\app\stuff\BehavedWriter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\stuff\ChattyWriter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\stuff\QuietWriter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\stuff\stuff.main.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\stuff\ThreadedWriter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\stuff\ThreadedWriter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\app\stuff\Writer.h
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

!IF  "$(CFG)" == "stuff - Win32 Release"

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE="..\..\binD\stuffit5.engineD-5.1.lib"

!IF  "$(CFG)" == "stuff - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\binS\stuffit5.engineS.lib

!IF  "$(CFG)" == "stuff - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

!ENDIF 

# End Source File
# End Target
# End Project
