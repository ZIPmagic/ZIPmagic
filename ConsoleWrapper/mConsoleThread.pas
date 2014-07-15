unit mConsoleThread;

interface

uses
  SysUtils, Windows, Classes;

type
  cThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure FailedMist;
    procedure AddCurrent;
  end;

var
  PauseCap: String = '';
  BigMax, BigCurrent: Integer;

implementation

uses
  uLocalize,
  mConsoleGui;

var
  i: Integer;

procedure cThread.AddCurrent;
begin
  BigCurrent := BigCurrent +1;
end;

procedure cThread.Execute;
var
  j: Integer;
  b: Boolean;
begin
  for j := 1 to Commands.Count do
    if not Quit then
    begin
      Wrap.Console.CommandLine := Commands[j -1];
      //messagebox(0, pchar(Wrap.Console.CommandLine), nil, 0);
      if CdPaths.Count > 0 then
      begin
        {$I-}
        ChDir(CdPaths[j -1]);
        {$I+}
      end;
      i := Wrap.Console.Start;
      b := false; // indicates low priority
      if GetPriorityClass(Wrap.Console.ProcessID) = IDLE_PRIORITY_CLASS then b:= True
        else if GetThreadPriority(Wrap.Console.ThreadID) < THREAD_PRIORITY_NORMAL then b := True;
      if b then PauseCap := cSpeedUp
        else PauseCap := cSlowDown;
      if i <> 0 then Synchronize(FailedMist);
      repeat
        Sleep(900);
      until not Wrap.Console.Running;
      Synchronize(AddCurrent);
    end;
  Quit := True;
end;

procedure cThread.FailedMist;
begin
  MessageBox(Wrap.Handle, PChar(cw2 + IntToStr(i) + #13 + cw3),
    PChar(Wrap.Caption), mb_Ok + mb_IconStop);
  Halt(0);
end;

end.

