unit Redirect;

interface

uses
  Windows, SysUtils, Classes;

type
  TRedirector = class;

  TPriorityClass = (pcDefault, pcIdle, pcNormal, pcHigh, pcRealtime);

  TDataEvent = procedure (Sender : TRedirector; buffer : POINTER; Size : INTEGER) of object;

  TRedirector = class(TComponent)
  private
    FAvailable        : INTEGER;
    procedure ReadStdOutput;
    procedure ReadStdError;
    procedure ProcessTerminated;
  protected
    FProcessInfo      : TProcessInformation;
    FInterval         : INTEGER;
    FExitCode         : INTEGER;
    FDefaultErrorMode : BOOLEAN;
    FStartSuspended   : BOOLEAN;
    FKillOnDestroy    : BOOLEAN;
    FCommandLine      : STRING;
    FDirectory        : STRING;
    FEnvironment      : POINTER;
    FInitialPriority  : TPriorityClass;
    FPipeInput,
    FPipeOutput,
    FPipeError        :
      record
        hRead,
        hWrite        : DWORD;
      end;
    FThread           : TThread;
    FOnData,
    FOnErrorData      : TDataEvent;
    FOnTerminated     : TNotifyEvent;
    procedure Error (msg : STRING);
    procedure WinError (msg : STRING);
    procedure CreatePipes;
    procedure ClosePipes;

    function  GetRunning : BOOLEAN;
    function  GetExitCode : INTEGER;
    function  GetProcessID : INTEGER;
    function  GetThreadID : INTEGER;
    function  GetProcessHandle : INTEGER;
    function  GetThreadHandle : INTEGER;
    procedure SetDefaultErrorMode (value : BOOLEAN);
    procedure SetStartSuspended (value : BOOLEAN);
    procedure SetInitialPriority (value : TPriorityClass);
    procedure SetDirectory (value : STRING);
    procedure SetEnvironment (value : POINTER);
    property  ProcessHandle : INTEGER
      read GetProcessHandle;
    property  ThreadHandle : INTEGER
      read GetThreadHandle;
  public
    destructor Destroy; override;
    procedure Terminate (dwExitCode : INTEGER);
    procedure Suspend;
    procedure Resume;
    function  Start: Integer;
    procedure SendData (Buffer : POINTER; BufferSize : INTEGER);
    procedure SendText (s : STRING);
    property  Running : BOOLEAN
      read GetRunning;
    property  ExitCode : INTEGER
      read GetExitCode;
    property  ProcessID : INTEGER
      read GetProcessID;
    property  ThreadID : INTEGER
      read GetThreadID;
    property  Environment : POINTER
      read FEnvironment
      write SetEnvironment;
  published
    property  KillOnDestroy : BOOLEAN
      read FKillOnDestroy
      write FKillOnDestroy;
    property  CommandLine : STRING
      read FCommandLine
      write FCommandLine;
    property  Interval : INTEGER
      read FInterval
      write FInterval;
    property  DefaultErrorMode : BOOLEAN
      read FDefaultErrorMode
      write SetDefaultErrorMode;
    property  StartSuspended : BOOLEAN
      read FStartSuspended
      write SetStartSuspended;
    property  InitialPriority : TPriorityClass
      read FInitialPriority
      write SetInitialPriority;
    property  Directory : STRING
      read FDirectory
      write SetDirectory;
    property OnData : TDataEvent
      read FOnData
      write FOnData;
    property OnErrorData : TDataEvent
      read FOnErrorData
      write FOnErrorData;
    property OnTerminated : TNotifyEvent
      read FOnTerminated
      write FOnTerminated;
  end;

procedure Register;

implementation

const
  DUPLICATE_CLOSE_SOURCE = 1;
  DUPLICATE_SAME_ACCESS  = 2;

type
  TRedirectorThread = class (TThread)
  protected
    FRedirector     : TRedirector;
    procedure Execute; override;
    constructor Create(ARedirector : TRedirector);
  end;

////////////////////////////////////////////////////////////////////////////////
// Misc. internal methods
////////////////////////////////////////////////////////////////////////////////

procedure TRedirector.Error (msg : STRING);
begin
  raise Exception.Create(msg);
end;

procedure TRedirector.WinError (msg : STRING);
begin
  Error (msg + IntToStr(GetLastError));
end;


procedure TRedirector.CreatePipes;
var
  SecAttr : TSecurityAttributes;
begin
  SecAttr.nLength := SizeOf(SecAttr);
  SecAttr.lpSecurityDescriptor := nil;
  SecAttr.bInheritHandle := TRUE;

  with FPipeInput do begin
    if not CreatePipe (hRead, hWrite, @SecAttr, 1024)
      then WinError('Error on STDIN pipe creation : ');
    if not DuplicateHandle (GetCurrentProcess, hRead, GetCurrentProcess, @hRead, 0, TRUE, DUPLICATE_CLOSE_SOURCE or DUPLICATE_SAME_ACCESS)
      then WinError('Error on STDIN pipe duplication : '); 
  end;
  with FPipeOutput do begin
    if not CreatePipe (hRead, hWrite, @SecAttr, 1024)
      then WinError('Error on STDOUT pipe creation : ');
    if not DuplicateHandle (GetCurrentProcess, hWrite, GetCurrentProcess, @hWrite, 0, TRUE, DUPLICATE_CLOSE_SOURCE or DUPLICATE_SAME_ACCESS)
      then WinError('Error on STDOUT pipe duplication : ');
  end;
  with FPipeError do begin
    if not CreatePipe (hRead, hWrite, @SecAttr, 1024)
      then WinError('Error on STDERR pipe creation : ');
    if not DuplicateHandle (GetCurrentProcess, hWrite, GetCurrentProcess, @hWrite, 0, TRUE, DUPLICATE_CLOSE_SOURCE or DUPLICATE_SAME_ACCESS)
      then WinError('Error on STDERR pipe duplication : ');
  end;
end;

procedure TRedirector.ClosePipes;
begin
  with FPipeInput do begin
    if hRead <> 0 then CloseHandle (hRead);
    if hWrite <> 0 then CloseHandle (hWrite);
    hRead := 0;
    hWrite := 0;
  end;
  with FPipeOutput do begin
    if hRead <> 0 then CloseHandle (hRead);
    if hWrite <> 0 then CloseHandle (hWrite);
    hRead := 0;
    hWrite := 0;
  end;
  with FPipeError do begin
    if hRead <> 0 then CloseHandle (hRead);
    if hWrite <> 0 then CloseHandle (hWrite);
    hRead := 0;
    hWrite := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Property implementations
////////////////////////////////////////////////////////////////////////////////
function  TRedirector.GetRunning : BOOLEAN;
begin
  Result := ProcessHandle<>0;
end;

function  TRedirector.GetExitCode : INTEGER;
begin
  if Running
    then Result := STILL_ACTIVE
    else Result := FExitCode;
end;

function  TRedirector.GetProcessID : INTEGER;
begin
  Result := FProcessInfo.dwProcessID;
end;

function  TRedirector.GetThreadID : INTEGER;
begin
  Result := FProcessInfo.dwThreadID;
end;

function  TRedirector.GetProcessHandle : INTEGER;
begin
  Result := FProcessInfo.hProcess;
end;

function  TRedirector.GetThreadHandle : INTEGER;
begin
  Result := FProcessInfo.hThread;
end;

procedure TRedirector.SetDefaultErrorMode (value : BOOLEAN);
begin
  if (value = DefaultErrorMode) or not Running
    then FDefaultErrorMode := value
  else if Running
    then Error('Cannot change DefaultErrorMode while process is active');
end;

procedure TRedirector.SetStartSuspended (value : BOOLEAN);
begin
  if (value = DefaultErrorMode) or not Running
    then FStartSuspended:= value
  else if Running
    then Error('Cannot change StartSuspended while process is active');
end;

procedure TRedirector.SetInitialPriority (value : TPriorityClass);
begin
  if (value = InitialPriority) or not Running
    then FInitialPriority := value
  else if Running
    then Error('Cannot change InititalPriority while process is active');
end;

procedure TRedirector.SetDirectory (value : STRING);
begin
  if (ANSICompareText (value, Directory) = 0) or (not Running)
    then FDirectory:= value
  else if Running
    then Error('Cannot change Directory while process is active');
end;

procedure TRedirector.SetEnvironment (value : POINTER);
begin
  if (value = Environment) or not Running
    then FEnvironment := value
  else if Running
    then Error('Cannot change Environment while process is active'); 
end;


procedure TRedirector.ReadStdOutput;
var
  BytesRead : Cardinal;
  buffer    : POINTER;
begin
  GetMem (buffer, FAvailable);
  try
    if not ReadFile (FPipeOutput.hRead, buffer^, FAvailable, BytesRead, nil) then begin
      FThread.Terminate;
      WinError('Error reading STDOUT pipe : ');
    end;
    if Assigned (FOnData) then begin
      FOnData(Self, buffer, BytesRead);      
    end;    
  finally
    FreeMem(buffer);
  end;
end;

procedure TRedirector.ReadStdError;
var
  BytesRead : Cardinal;
  buffer    : POINTER;
begin
  GetMem (buffer, FAvailable);
  try
    if not ReadFile (FPipeError.hRead, buffer^, FAvailable, BytesRead, nil) then begin
      FThread.Terminate;
      WinError('Error reading STDERR pipe : ');
    end;
    if Assigned (FOnErrorData) then begin
      FOnErrorData(Self, buffer, BytesRead);
    end;
  finally
    FreeMem(buffer);
  end;
end;

procedure TRedirector.ProcessTerminated;
begin
  FThread.Terminate;
  if Assigned (FOnTerminated) then FOnTerminated(Self);
  ClosePipes;
  CloseHandle(FProcessInfo.hProcess);
  CloseHandle(FProcessInfo.hThread);
  FillChar(FProcessInfo, SizeOf(FProcessInfo), 0);
end;

////////////////////////////////////////////////////////////////////////////////
// Public methods
////////////////////////////////////////////////////////////////////////////////
procedure TRedirector.Terminate (dwExitCode : INTEGER);
begin
  if Running
    then
      TerminateProcess(ProcessHandle, dwExitCode)
    else
      Error('Cannot Terminate an inactive process');
end;

procedure TRedirector.Suspend;
begin
  SuspendThread(ThreadHandle);
end;

procedure TRedirector.Resume;
begin
  ResumeThread(ThreadHandle);
end;

function TRedirector.Start: Integer;
var
  StartupInfo   : TStartupInfo;
  iPriority     : Integer;
  szDirectory   : PChar;
begin
  if Running then Error ('Process is already active');
  if Trim(FCommandLine)='' then Error('No commandline to run');
  try
    CreatePipes;

    FillChar(StartupInfo, SizeOf(StartupInfo), 0);
    StartupInfo.cb := SizeOf(StartupInfo);

    StartupInfo.wShowWindow := SW_HIDE;
    StartupInfo.hStdInput := FPipeInput.hRead;
    StartupInfo.hStdOutput := FPipeOutput.hWrite;
    StartupInfo.hStdError := FPipeError.hWrite;
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;

    if Trim(Directory)=''
      then szDirectory := nil
      else szDirectory := PChar(FDirectory);

    case FInitialPriority of
      pcRealTime: iPriority := REALTIME_PRIORITY_CLASS;
      pcHigh: iPriority := HIGH_PRIORITY_CLASS;
      pcNormal: iPriority := NORMAL_PRIORITY_CLASS;
      pcIdle: iPriority := IDLE_PRIORITY_CLASS;
      pcDefault: iPriority := 0;
    end;

    if CreateProcess (
      nil,
      PChar(FCommandLine),
      nil,
      nil,
      TRUE,
      (CREATE_DEFAULT_ERROR_MODE and INTEGER(FDefaultErrorMode)) or CREATE_NEW_PROCESS_GROUP or CREATE_NEW_CONSOLE
      or (CREATE_SUSPENDED and INTEGER(FStartSuspended)) or iPriority,
      Environment,
      szDirectory,
      StartupInfo,
      FProcessInfo)
    then begin
      FThread := TRedirectorThread.Create(Self);
      Result := 0;
    end else Result := GetLastError;
  except
    on Exception do begin
      ClosePipes;
      CloseHandle(FProcessInfo.hProcess);
      CloseHandle(FProcessInfo.hThread);
      FillChar(FProcessInfo, SizeOf(FProcessInfo), 0);
      raise;
    end;
  end;
end;

procedure TRedirector.SendData (Buffer : POINTER; BufferSize : INTEGER);
var
  BytesWritten : Cardinal;
begin
  if not Running then Error ('Can''t send data to an inactive process');
  if not WriteFile (FPipeInput.hWrite, Buffer^, BufferSize, BytesWritten, nil)
    then WinError('Error writing to STDIN pipe : '); 
end;

procedure TRedirector.SendText (s : STRING);
begin
  SendData(PChar(s), Length(s));
end;

destructor TRedirector.Destroy;
begin
  if Running and KillOnDestroy then begin
    FOnTerminated := nil;
    FThread.Terminate;
    Terminate(0);
  end;
  inherited Destroy;
end;

constructor TRedirectorThread.Create(ARedirector : TRedirector);
begin
  FRedirector := ARedirector;
  inherited Create(FALSE);
end;

procedure TRedirectorThread.Execute;
var
  Idle    : BOOLEAN;

  function DoReadOutput : BOOLEAN;
  begin
    Result := PeekNamedPipe(FRedirector.FPipeOutput.hRead, nil, 0, nil, @FRedirector.FAvailable, nil) and (FRedirector.FAvailable>0);
    if Result then begin
      Synchronize(FRedirector.ReadStdOutput);
      Idle := FALSE;
    end;
  end;

  function DoReadError : BOOLEAN;
  begin
    Result := PeekNamedPipe(FRedirector.FPipeError.hRead, nil, 0, nil, @FRedirector.FAvailable, nil) and (FRedirector.FAvailable>0);
    if Result then begin
      Synchronize(FRedirector.ReadStdError);
      Idle := FALSE;
    end;
  end;

begin
  FreeOnTerminate := TRUE;
  while not Terminated do begin
    Idle := TRUE;
    DoReadOutput;
    DoReadError;
    if Idle and (WaitForSingleObject(FRedirector.ProcessHandle, FRedirector.FInterval)=WAIT_OBJECT_0) then begin
      repeat
        sleep(FRedirector.FInterval);
      until not DoReadOutput and not DoReadError;
      if not Terminated then Synchronize(FRedirector.ProcessTerminated);
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('xTek', [TRedirector]);
end;

end.
