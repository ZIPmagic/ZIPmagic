# Microsoft Developer Studio Generated NMAKE File, Based on stuff.dsp
!IF "$(CFG)" == ""
CFG=stuff - Win32 Debug
!MESSAGE No configuration specified. Defaulting to stuff - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "stuff - Win32 Release" && "$(CFG)" != "stuff - Win32 Debug" && "$(CFG)" != "stuff - Win32 Release Static"
!MESSAGE Invalid configuration "$(CFG)" specified.
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
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "stuff - Win32 Release"

OUTDIR=.\../../bin
INTDIR=.\../../bin/stuff
# Begin Custom Macros
OutDir=.\../../bin
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\stuff.exe"

!ELSE 

ALL : "engine51 - Win32 Release" "engine - Win32 Release" "$(OUTDIR)\stuff.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"engine - Win32 ReleaseCLEAN" "engine51 - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\command.CommandElement.obj"
	-@erase "$(INTDIR)\command.CommandLine.obj"
	-@erase "$(INTDIR)\stuff.main.obj"
	-@erase "$(INTDIR)\ThreadedWriter.obj"
	-@erase "$(INTDIR)\un.tokenizer.obj"
	-@erase "$(INTDIR)\util.System.w32.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\stuff.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP_PROJ=/nologo /MD /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\stuff.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\stuff.pdb" /machine:I386 /out:"$(OUTDIR)\stuff.exe" 
LINK32_OBJS= \
	"$(INTDIR)\stuff.main.obj" \
	"$(INTDIR)\ThreadedWriter.obj" \
	"$(INTDIR)\util.System.w32.obj" \
	"$(INTDIR)\command.CommandElement.obj" \
	"$(INTDIR)\command.CommandLine.obj" \
	"$(OUTDIR)\stuffit5.engine-5.1.lib" \
	"$(INTDIR)\un.tokenizer.obj" \
	"$(OUTDIR)\stuffit5.engine.lib"

"$(OUTDIR)\stuff.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

OUTDIR=.\../../binD
INTDIR=.\../../binD/stuff
# Begin Custom Macros
OutDir=.\../../binD
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\stuffD.exe"

!ELSE 

ALL : "engine51 - Win32 Debug" "engine - Win32 Debug" "$(OUTDIR)\stuffD.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"engine - Win32 DebugCLEAN" "engine51 - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\command.CommandElement.obj"
	-@erase "$(INTDIR)\command.CommandLine.obj"
	-@erase "$(INTDIR)\stuff.main.obj"
	-@erase "$(INTDIR)\ThreadedWriter.obj"
	-@erase "$(INTDIR)\un.tokenizer.obj"
	-@erase "$(INTDIR)\util.System.w32.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\stuffD.exe"
	-@erase "$(OUTDIR)\stuffD.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP_PROJ=/nologo /MDd /W3 /Gm /GX /Zi /Od /I "../../../src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\stuff.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\stuffD.pdb" /debug /machine:I386 /out:"$(OUTDIR)\stuffD.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\stuff.main.obj" \
	"$(INTDIR)\ThreadedWriter.obj" \
	"$(INTDIR)\util.System.w32.obj" \
	"$(INTDIR)\command.CommandElement.obj" \
	"$(INTDIR)\command.CommandLine.obj" \
	"$(OUTDIR)\stuffit5.engineD-5.1.lib" \
	"$(INTDIR)\un.tokenizer.obj" \
	"$(OUTDIR)\stuffit5.engineD.lib"

"$(OUTDIR)\stuffD.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

OUTDIR=.\../../binS
INTDIR=.\../../binS/stuff
# Begin Custom Macros
OutDir=.\../../binS
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\stuffS.exe"

!ELSE 

ALL : "engine51 - Win32 Release Static" "engine - Win32 Release Static" "$(OUTDIR)\stuffS.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"engine - Win32 Release StaticCLEAN" "engine51 - Win32 Release StaticCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\command.CommandElement.obj"
	-@erase "$(INTDIR)\command.CommandLine.obj"
	-@erase "$(INTDIR)\stuff.main.obj"
	-@erase "$(INTDIR)\ThreadedWriter.obj"
	-@erase "$(INTDIR)\un.tokenizer.obj"
	-@erase "$(INTDIR)\util.System.w32.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\stuffS.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP_PROJ=/nologo /MT /W3 /GX /O2 /I "../../../src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\stuff.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\stuffS.pdb" /machine:I386 /out:"$(OUTDIR)\stuffS.exe" 
LINK32_OBJS= \
	"$(INTDIR)\stuff.main.obj" \
	"$(INTDIR)\ThreadedWriter.obj" \
	"$(INTDIR)\util.System.w32.obj" \
	"$(INTDIR)\command.CommandElement.obj" \
	"$(INTDIR)\command.CommandLine.obj" \
	"$(OUTDIR)\stuffit5.engineS.lib" \
	"$(INTDIR)\un.tokenizer.obj" \
	"$(OUTDIR)\stuffit5.engineS-5.1.lib"

"$(OUTDIR)\stuffS.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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
!IF EXISTS("stuff.dep")
!INCLUDE "stuff.dep"
!ELSE 
!MESSAGE Warning: cannot find "stuff.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "stuff - Win32 Release" || "$(CFG)" == "stuff - Win32 Debug" || "$(CFG)" == "stuff - Win32 Release Static"
SOURCE=..\..\..\src\app\stuff\stuff.main.cpp

"$(INTDIR)\stuff.main.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\src\app\stuff\ThreadedWriter.cpp

"$(INTDIR)\ThreadedWriter.obj" : $(SOURCE) "$(INTDIR)"
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


!IF  "$(CFG)" == "stuff - Win32 Release"

"engine - Win32 Release" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release" 
   cd "..\stuff"

"engine - Win32 ReleaseCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release" RECURSE=1 CLEAN 
   cd "..\stuff"

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

"engine - Win32 Debug" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Debug" 
   cd "..\stuff"

"engine - Win32 DebugCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\stuff"

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

"engine - Win32 Release Static" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release Static" 
   cd "..\stuff"

"engine - Win32 Release StaticCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine"
   $(MAKE) /$(MAKEFLAGS) /F .\engine.mak CFG="engine - Win32 Release Static" RECURSE=1 CLEAN 
   cd "..\stuff"

!ENDIF 

!IF  "$(CFG)" == "stuff - Win32 Release"

"engine51 - Win32 Release" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release" 
   cd "..\stuff"

"engine51 - Win32 ReleaseCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release" RECURSE=1 CLEAN 
   cd "..\stuff"

!ELSEIF  "$(CFG)" == "stuff - Win32 Debug"

"engine51 - Win32 Debug" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Debug" 
   cd "..\stuff"

"engine51 - Win32 DebugCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\stuff"

!ELSEIF  "$(CFG)" == "stuff - Win32 Release Static"

"engine51 - Win32 Release Static" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release Static" 
   cd "..\stuff"

"engine51 - Win32 Release StaticCLEAN" : 
   cd "\work\remote\engine516\win32\project\engine51"
   $(MAKE) /$(MAKEFLAGS) /F .\engine51.mak CFG="engine51 - Win32 Release Static" RECURSE=1 CLEAN 
   cd "..\stuff"

!ENDIF 


!ENDIF 

