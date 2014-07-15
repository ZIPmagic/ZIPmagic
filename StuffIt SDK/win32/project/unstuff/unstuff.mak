# Microsoft Developer Studio Generated NMAKE File, Based on unstuff.dsp
!IF "$(CFG)" == ""
CFG=unstuff - Win32 Debug
!MESSAGE No configuration specified. Defaulting to unstuff - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "unstuff - Win32 Release" && "$(CFG)" != "unstuff - Win32 Debug" && "$(CFG)" != "unstuff - Win32 Release Static"
!MESSAGE Invalid configuration "$(CFG)" specified.
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
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "unstuff - Win32 Release"

OUTDIR=.\../../bin
INTDIR=.\../../bin/unstuff
# Begin Custom Macros
OutDir=.\../../bin
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\unstuff.exe"

!ELSE 

ALL : "engine51 - Win32 Release" "engine - Win32 Release" "$(OUTDIR)\unstuff.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"engine - Win32 ReleaseCLEAN" "engine51 - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\command.CommandElement.obj"
	-@erase "$(INTDIR)\command.CommandLine.obj"
	-@erase "$(INTDIR)\data.OSType.obj"
	-@erase "$(INTDIR)\stream.Input.obj"
	-@erase "$(INTDIR)\stream.Output.obj"
	-@erase "$(INTDIR)\ThreadedReader.obj"
	-@erase "$(INTDIR)\un.tokenizer.obj"
	-@erase "$(INTDIR)\unstuff.main.obj"
	-@erase "$(INTDIR)\util.System.w32.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\unstuff.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP_PROJ=/nologo /MD /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\unstuff.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\unstuff.pdb" /machine:I386 /out:"$(OUTDIR)\unstuff.exe" 
LINK32_OBJS= \
	"$(INTDIR)\ThreadedReader.obj" \
	"$(INTDIR)\unstuff.main.obj" \
	"$(INTDIR)\data.OSType.obj" \
	"$(INTDIR)\stream.Input.obj" \
	"$(INTDIR)\stream.Output.obj" \
	"$(INTDIR)\util.System.w32.obj" \
	"$(INTDIR)\command.CommandElement.obj" \
	"$(INTDIR)\command.CommandLine.obj" \
	"$(OUTDIR)\stuffit5.engine-5.1.lib" \
	"$(INTDIR)\un.tokenizer.obj" \
	"$(OUTDIR)\stuffit5.engine.lib"

"$(OUTDIR)\unstuff.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

OUTDIR=.\../../binD
INTDIR=.\../../binD/unstuff
# Begin Custom Macros
OutDir=.\../../binD
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\unstuffD.exe"

!ELSE 

ALL : "engine51 - Win32 Debug" "engine - Win32 Debug" "$(OUTDIR)\unstuffD.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"engine - Win32 DebugCLEAN" "engine51 - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\command.CommandElement.obj"
	-@erase "$(INTDIR)\command.CommandLine.obj"
	-@erase "$(INTDIR)\data.OSType.obj"
	-@erase "$(INTDIR)\stream.Input.obj"
	-@erase "$(INTDIR)\stream.Output.obj"
	-@erase "$(INTDIR)\ThreadedReader.obj"
	-@erase "$(INTDIR)\un.tokenizer.obj"
	-@erase "$(INTDIR)\unstuff.main.obj"
	-@erase "$(INTDIR)\util.System.w32.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\unstuffD.exe"
	-@erase "$(OUTDIR)\unstuffD.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP_PROJ=/nologo /MDd /W3 /Gm /GX /Zi /Od /I "../../../src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\unstuff.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\unstuffD.pdb" /debug /machine:I386 /out:"$(OUTDIR)\unstuffD.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\ThreadedReader.obj" \
	"$(INTDIR)\unstuff.main.obj" \
	"$(INTDIR)\data.OSType.obj" \
	"$(INTDIR)\stream.Input.obj" \
	"$(INTDIR)\stream.Output.obj" \
	"$(INTDIR)\util.System.w32.obj" \
	"$(INTDIR)\command.CommandElement.obj" \
	"$(INTDIR)\command.CommandLine.obj" \
	"$(OUTDIR)\stuffit5.engineD-5.1.lib" \
	"$(INTDIR)\un.tokenizer.obj" \
	"$(OUTDIR)\stuffit5.engineD.lib"

"$(OUTDIR)\unstuffD.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

OUTDIR=.\../../binS
INTDIR=.\../../binS/unstuff
# Begin Custom Macros
OutDir=.\../../binS
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\unstuffS.exe"

!ELSE 

ALL : "engine51 - Win32 Release Static" "engine - Win32 Release Static" "$(OUTDIR)\unstuffS.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"engine - Win32 Release StaticCLEAN" "engine51 - Win32 Release StaticCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\command.CommandElement.obj"
	-@erase "$(INTDIR)\command.CommandLine.obj"
	-@erase "$(INTDIR)\data.OSType.obj"
	-@erase "$(INTDIR)\stream.Input.obj"
	-@erase "$(INTDIR)\stream.Output.obj"
	-@erase "$(INTDIR)\ThreadedReader.obj"
	-@erase "$(INTDIR)\un.tokenizer.obj"
	-@erase "$(INTDIR)\unstuff.main.obj"
	-@erase "$(INTDIR)\util.System.w32.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\unstuffS.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP_PROJ=/nologo /MT /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\unstuff.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\unstuffS.pdb" /machine:I386 /out:"$(OUTDIR)\unstuffS.exe" 
LINK32_OBJS= \
	"$(INTDIR)\ThreadedReader.obj" \
	"$(INTDIR)\unstuff.main.obj" \
	"$(INTDIR)\data.OSType.obj" \
	"$(INTDIR)\stream.Input.obj" \
	"$(INTDIR)\stream.Output.obj" \
	"$(INTDIR)\util.System.w32.obj" \
	"$(INTDIR)\command.CommandElement.obj" \
	"$(INTDIR)\command.CommandLine.obj" \
	"$(OUTDIR)\stuffit5.engineS.lib" \
	"$(INTDIR)\un.tokenizer.obj" \
	"$(OUTDIR)\stuffit5.engineS-5.1.lib"

"$(OUTDIR)\unstuffS.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("unstuff.dep")
!INCLUDE "unstuff.dep"
!ELSE 
!MESSAGE Warning: cannot find "unstuff.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "unstuff - Win32 Release" || "$(CFG)" == "unstuff - Win32 Debug" || "$(CFG)" == "unstuff - Win32 Release Static"
SOURCE=..\..\..\src\app\unstuff\ThreadedReader.cpp

"$(INTDIR)\ThreadedReader.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\app\unstuff\unstuff.main.cpp

"$(INTDIR)\unstuff.main.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\format\data\data.OSType.cpp

"$(INTDIR)\data.OSType.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\stream\stream.Input.cpp

"$(INTDIR)\stream.Input.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\stream\stream.Output.cpp

"$(INTDIR)\stream.Output.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\un\un.tokenizer.cpp

"$(INTDIR)\un.tokenizer.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\util\util.System.w32.cpp

"$(INTDIR)\util.System.w32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\util\command\command.CommandElement.cpp

"$(INTDIR)\command.CommandElement.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\util\command\command.CommandLine.cpp

"$(INTDIR)\command.CommandLine.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!IF  "$(CFG)" == "unstuff - Win32 Release"

"engine - Win32 Release" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release" 
   cd "..\unstuff"

"engine - Win32 ReleaseCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release" RECURSE=1 CLEAN 
   cd "..\unstuff"

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

"engine - Win32 Debug" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Debug" 
   cd "..\unstuff"

"engine - Win32 DebugCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\unstuff"

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

"engine - Win32 Release Static" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release Static" 
   cd "..\unstuff"

"engine - Win32 Release StaticCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release Static" RECURSE=1 CLEAN 
   cd "..\unstuff"

!ENDIF 

!IF  "$(CFG)" == "unstuff - Win32 Release"

"engine51 - Win32 Release" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release" 
   cd "..\unstuff"

"engine51 - Win32 ReleaseCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release" RECURSE=1 CLEAN 
   cd "..\unstuff"

!ELSEIF  "$(CFG)" == "unstuff - Win32 Debug"

"engine51 - Win32 Debug" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Debug" 
   cd "..\unstuff"

"engine51 - Win32 DebugCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\unstuff"

!ELSEIF  "$(CFG)" == "unstuff - Win32 Release Static"

"engine51 - Win32 Release Static" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release Static" 
   cd "..\unstuff"

"engine51 - Win32 Release StaticCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release Static" RECURSE=1 CLEAN 
   cd "..\unstuff"

!ENDIF 


!ENDIF 

