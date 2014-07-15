unit mMist;

interface

uses
  Classes, Windows, ZIPmagicInclude;

(* Launches command in a hidden fashion, buffers ALL output to given output file *)
function MimarSinanMist(AppCommand, OutFile: String): Cardinal; overload;
(* Launches the command line masking module with given application name and command line, returns process handle *)
function MimarSinanMist(AppName, AppCommand: String; Avi: Integer; Mist: Boolean): Cardinal; overload;
(* Same as above, with priority support *)
function MimarSinanMist(AppName, AppCommand: String; Avi, Priority: Integer; Mist: Boolean): Cardinal; overload;
(* Same as above, with priority support and app output dump support *)
function MimarSinanMist(AppName, AppCommand, AppDump: String; Avi, Priority: Integer): Cardinal; overload;
(* Same as above, with priority and multiple commands in a single shell support *)
function MimarSinanMist(AppName: String; AppCommand: TStrings; Avi, Priority: Integer): Cardinal; overload;
(* Same as above, with priority and multiple commands and multiple ChDir's in a single shell support *)
function MimarSinanMist(AppName: String; AppCommand, ChDirs: TStrings; Avi, Priority: Integer): Cardinal; overload;

(* Mist, for DOS processes running under NTVDM *)
function MimarSinanMistEx(AppName: String; Commands, CommandPaths, StartPaths: String;
  EndStrings: TStrings; Avi, Priority: Integer): Cardinal; overload;
(* Same as above, with multiple commands in single shell support *)
function MimarSinanMistEx(AppName: String; Commands, CommandPaths, StartPaths, EndStrings: TStrings;
  Avi, Priority: Integer): Cardinal; overload;

implementation

function MimarSinanMist(AppCommand, OutFile: String): Cardinal; overload;
var
  p: PChar;
  si: TStartupInfo;
  pi: TProcessInformation;
  sX: String;
begin
  try
  GetDir(0, sX);
  ChDir(GetUACDir);
  GetMem(p, 1024);
  GetSystemDirectory(p, 1024);
  p := PChar('"' + AssertDirectoryFormat(GetUACDir) + 'mConsoleWrapper.exe" sevgi $DIRECT$ "'
    + OutFile + '" ' + AppCommand);
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
  finally
    ChDir(sX);
  end;
end;

function MimarSinanMist(AppName, AppCommand: String; Avi, Priority: Integer; Mist: Boolean): Cardinal; overload;
var
  p: PChar;
  t: TextFile;
  s: String;
  si: TStartupInfo;
  pi: TProcessInformation;
  sX: String;
begin
  try
  GetDir(0, sX);
  ChDir(GetUACDir);
  GetMem(p, 1024);
  GetTempPath(1024, p);
  s := p;
  GetTempFileName(PChar(s), 'msm', 0, p);
  s := p;
  AssignFile(t, s);
  ReWrite(t);
  WriteLn(t, AppName);
  WriteLn(t, AppCommand);
  WriteLn(t, Avi);
  WriteLn(t, Priority);
  CloseFile(t);
  GetSystemDirectory(p, 1024);
  if Mist then
    p := PChar('"' + AssertDirectoryFormat(GetUACDir) + 'mConsoleWrapper.exe" sevgi "' + s + '"')
  else
    p := PChar(AppCommand);
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
  finally
    ChDir(sX);
  end;
end;

function MimarSinanMist(AppName, AppCommand, AppDump: String; Avi, Priority: Integer): Cardinal; overload;
var
  p: PChar;
  t: TextFile;
  s: String;
  si: TStartupInfo;
  pi: TProcessInformation;
  sX: String;
begin
  try
  GetDir(0, sX);
  ChDir(GetUACDir);
  GetMem(p, 1024);
  GetTempPath(1024, p);
  s := p;
  GetTempFileName(PChar(s), 'msm', 0, p);
  s := p;
  AssignFile(t, s);
  ReWrite(t);
  WriteLn(t, AppName);
  WriteLn(t, AppCommand);
  WriteLn(t, Avi);
  WriteLn(t, Priority);
  WriteLn(t, '$');
  WriteLn(t, '$');
  WriteLn(t, AppDump);
  CloseFile(t);
  GetSystemDirectory(p, 1024);
  p := PChar('"' + AssertDirectoryFormat(GetUACDir) + 'mConsoleWrapper.exe" sevgi "' + s + '"');
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
  finally
    ChDir(sX);
  end;
end;

function MimarSinanMist(AppName, AppCommand: String; Avi: Integer; Mist: Boolean): Cardinal;
var
  p: PChar;
  t: TextFile;
  s: String;
  si: TStartupInfo;
  pi: TProcessInformation;
  sX: String;
begin
  try
  GetDir(0, sX);
  ChDir(GetUACDir);
  GetMem(p, 1024);
  GetTempPath(1024, p);
  s := p;
  GetTempFileName(PChar(s), 'msm', 0, p);
  s := p;
  AssignFile(t, s);
  ReWrite(t);
  WriteLn(t, AppName);
  WriteLn(t, AppCommand);
  WriteLn(t, Avi);
  CloseFile(t);
  GetSystemDirectory(p, 1024);
  if Mist then
    p := PChar('"' + AssertDirectoryFormat(GetUACDir) + 'mConsoleWrapper.exe" sevgi "' + s + '"')
  else
    p := PChar(AppCommand);
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
  finally
    ChDir(sX);
  end;
end;

function MimarSinanMist(AppName: String; AppCommand: TStrings; Avi, Priority: Integer): Cardinal; overload;
var
  p: PChar;
  t: TextFile;
  s: String;
  i: Integer;
  si: TStartupInfo;
  pi: TProcessInformation;
  sX: String;
begin
  try
  GetDir(0, sX);
  ChDir(GetUACDir);
  GetMem(p, 1024);
  GetTempPath(1024, p);
  s := p;
  GetTempFileName(PChar(s), 'msm', 0, p);
  s := p;
  AssignFile(t, s);
  ReWrite(t);
  WriteLn(t, AppName);
  WriteLn(t, AppCommand[0]);
  WriteLn(t, Avi);
  WriteLn(t, Priority);
  for i := 2 to AppCommand.Count do
  begin
    WriteLn(t, AppCommand[i -1]);
  end;
  WriteLn(t, '$');
  CloseFile(t);
  GetSystemDirectory(p, 1024);
  p := PChar('"' + AssertDirectoryFormat(GetUACDir) + 'mConsoleWrapper.exe" sevgi "' + s + '"');
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
  finally
    ChDir(sX);
  end;
end;

function MimarSinanMist(AppName: String; AppCommand, ChDirs: TStrings; Avi, Priority: Integer): Cardinal; overload;
var
  p: PChar;
  t: TextFile;
  s: String;
  i: Integer;
  si: TStartupInfo;                                 
  pi: TProcessInformation;
  sX: String;
begin
  try
  GetDir(0, sX);
  ChDir(GetUACDir);
  GetMem(p, 1024);
  GetTempPath(1024, p);
  s := p;
  GetTempFileName(PChar(s), 'msm', 0, p);
  s := p;
  AssignFile(t, s);
  ReWrite(t);
  WriteLn(t, AppName);
  WriteLn(t, AppCommand[0]);
  WriteLn(t, Avi);
  WriteLn(t, Priority);
  for i := 2 to AppCommand.Count do
  begin
    WriteLn(t, AppCommand[i -1]);
  end;
  WriteLn(t, '$');
  for i := 1 to ChDirs.Count do
  begin
    WriteLn(t, ChDirs[i -1]);
  end;
  WriteLn(t, '$');
  CloseFile(t);
  GetSystemDirectory(p, 1024);
  p := PChar('"' + AssertDirectoryFormat(GetUACDir) + 'mConsoleWrapper.exe" sevgi "' + s + '"');
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
  finally
    ChDir(sX);
  end;
end;

function MimarSinanMistEx(AppName: String; Commands, CommandPaths, StartPaths: String;
  EndStrings: TStrings; Avi, Priority: Integer): Cardinal; overload;
var
  c, p, s: TStringList;
begin
  c := TStringList.Create;
  p := TStringList.Create;
  s := TStringList.Create;
  c.Add(Commands);
  p.Add(CommandPaths);
  s.Add(StartPaths);
  Result := MimarSinanMistEx(AppName, c, p, s, EndStrings, Avi, Priority);
  s.Free;
  p.Free;
  c.Free;
end;

function MimarSinanMistEx(AppName: String; Commands, CommandPaths, StartPaths, EndStrings: TStrings;
  Avi, Priority: Integer): Cardinal;
var
  p: PChar;
  t: TextFile;
  s: String;
  i: Integer;
  si: TStartupInfo;
  pi: TProcessInformation;
begin
  GetMem(p, 1024);
  GetTempPath(1024, p);
  s := p;
  GetTempFileName(PChar(s), 'msm', 0, p);
  s := p;
  AssignFile(t, s);
  ReWrite(t);
  WriteLn(t, AppName);
  WriteLn(t, Avi);
  WriteLn(t, Priority);
  for i := 1 to EndStrings.Count do
  begin
    WriteLn(t, EndStrings[i -1]);
  end;
  WriteLn(t, '$');
  for i := 1 to Commands.Count do
  begin
    WriteLn(t, Commands[i -1]);
    WriteLn(t, CommandPaths[i -1]);
    WriteLn(t, StartPaths[i -1]);
  end;
  WriteLn(t, '$');
  CloseFile(t);
  GetSystemDirectory(p, 1024);
  p := PChar('"' + AssertDirectoryFormat(p) + 'mConsoleEx.exe" sevgi "' + s + '"');
  FillChar(si, SizeOf(si), #0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWDEFAULT;
  CreateProcess(nil, p, nil, nil, false, CREATE_NEW_CONSOLE or HIGH_PRIORITY_CLASS, nil,
    nil, si, pi);
  Result := pi.hProcess;
end;

end.

