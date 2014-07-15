program mConsoleWrapper;

uses
  Forms,
  Redirect,
  SysUtils,
  Windows,
  mConsoleGUI in 'mConsoleGUI.pas' {Wrap},
  mConsoleThread in 'mConsoleThread.pas',
  uLocalize in '..\mTVEx\uLocalize.pas',
  ZIPmagicInclude in '..\mTVEx\ZIPmagicInclude.pas';

{$R *.RES}
{$R 7icons.res}

type
  TC = class(TObject)
    procedure ConsoleData(Sender: TRedirector; buffer: Pointer; Size: Integer);
  end;

var
  c: TC;
  i: Integer;
  t: TextFile;
  r: TRedirector;

procedure TC.ConsoleData(Sender: TRedirector; buffer: Pointer;
  Size: Integer);
var
  p: PChar;
begin
  p := StrAlloc(Size + 1);
  StrLCopy(p, buffer, Size);
  p[Size] := #0;
  Write(t, String(p));
  StrDispose(p);
end;

begin
  //messagebox(0, getcommandline, nil, 0);
  try
    if ParamStr(2) = '$DIRECT$' then
    begin
      AssignFile(t, ParamStr(3));
      ReWrite(t);
      r := TRedirector.Create(nil);
      c := TC.Create;
      for i := 4 to ParamCount do
      r.CommandLine := r.CommandLine + '"' + ParamStr(i) + '" ';
      r.OnData := c.ConsoleData;
      r.DefaultErrorMode := false;
      r.InitialPriority := pcDefault; // low thread priority to prevent deadlocks when two simult. copies are running (tooltip)
      r.Interval := 1; // high poll interval to improve performance
      r.KillOnDestroy := True;
      r.StartSuspended := false;
      r.Start;
      repeat
        Application.HandleMessage;
      until not r.Running;
      r.Free;
      c.Free;
      CloseFile(t);
      Exit;
    end;
    Application.Initialize;
    Application.Title := 'MimarSinan Console Wrapper';
    Application.CreateForm(TWrap, Wrap);
    Application.Run;
  finally
    TerminateProcess(GetCurrentProcess, ExitCode);
  end;  
end.
