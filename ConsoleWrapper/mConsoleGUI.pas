// MAKE THE MEMO FONT REALLY, REALLY SMALL!
// OTHERWISE IT WILL FREEZE THE THING!!!
unit mConsoleGUI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileLbl, ComCtrls, ExtCtrls, mConsoleThread, uLocalize,
  Redirect, uTCodexAnimate;

type
  TWrap = class(TForm)
    Major: TProgressBar;
    Cancel: TButton;
    pause: TButton;
    Timer: TTimer;
    Console: TRedirector;
    Memo: TMemo;
    Target: TFileLabel;
    DOSEmu: TMemo;
    details: TLabel;
    Anim: TCodexAnimate;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure pauseClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure ConsoleTerminated(Sender: TObject);
    procedure ConsoleData(Sender: TRedirector; buffer: Pointer;
      Size: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DOSEmuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure detailsClick(Sender: TObject);
    procedure ConsoleErrorData(Sender: TRedirector; buffer: Pointer;
      Size: Integer);
    procedure detailsMouseEnter(Sender: TObject);
    procedure detailsMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ReadDirective(Src: String; Trg: TRedirector);
    procedure ParseText(Source: String; Target: TMemo; var Percent: Integer);
  end;

var
  Wrap: TWrap;
  Thread: cThread;
  Quit: Boolean = false;
  Start: Boolean = True;
  Commands, CdPaths: TStringList;
  HexDump: String;
  Big: Integer = 0;

implementation

{$R *.DFM}

procedure TWrap.ParseText(Source: String; Target: TMemo; var Percent: Integer);
var
  i, j, k: Integer;
  b: Boolean;
  s: String;
begin
  if Target.Lines.Count = 0 then
    Target.Lines.Add('');
  Source := Target.Lines[Target.Lines.Count -1] + Source;
  i := 1;
  while i <= Length(Source) do
  begin
    if Source[i] = #8 then
    begin
      Delete(Source, i -1, 2);
      i := i -3;
    end;
    if Source[i] = #9 then
    begin
      k := 0; // MAX 16 iterations - new failsafe code...
      while i mod 8 <> 0 do
      begin
        Insert(' ', Source, i);
        k := k +1;
        if k = 16 then Break;
      end;
    end;
    if Source[i] = '%' then
    begin
      b := True;
      s := '';
      j := i;
      k := 0; // MAX 12 iterations - new failsafe code...
      repeat
        try
          j := j -1;
          s := Copy(Source, j, i -j);
          if Pos('.', s) <> 0 then // compensate for floating point values: ignore
            Delete(s, Pos('.', s), 999);
          if s <> '' then // compensate for floating point adjustments
            Percent := StrToInt(s);
          k := k + 1;
          if k = 12 then Break;
        except
          b := false;
        end
      until (not b) or ((i -j) =6);
    end;
    i := i +1;
  end;
  Target.Lines[Target.Lines.Count -1] := Source;
end;

procedure TWrap.ReadDirective(Src: String; Trg: TRedirector);
var
  s: String;
  i: Integer;
  ddf: TextFile;
begin
  { console wrapper name
    console command line
    console masker image
    console priority - optional for makecompat
    console command line - optional for makecompat
    ...
    console command line - optional for makecompat
    $ - optional for makecompat
    console command line chdir path - optional for makecompat
    ...
    console command line chdir path - optional for makecompat
    $ - optional for makecompat
    console output dump text file target - optional for makecompat }
  AssignFile(ddf, src);
  Reset(ddf);
  ReadLn(ddf, s);
  Application.Title := s;
  Wrap.Caption := s;
  ReadLn(ddf, s);
  Commands.Add(s);
  //Trg.CommandLine := s;
  ReadLn(ddf, i);
  case i of
    0: anim.CommonAVI := codexNone;
    1: anim.CommonAVI := codexFind;
    2: anim.CommonAVI := codexTest;
    3: anim.CommonAVI := codexFind;
    4: anim.CommonAVI := codexCompress;
    5: anim.CommonAVI := codexExtract;
    6: anim.CommonAVI := codexDelete;
    7: anim.CommonAVI := codexNuke;
    8: anim.CommonAVI := codexDelete;
  end;
  anim.Active := True;
  // makeCompat block 1
  if not EOF(ddf) then
  begin
    ReadLn(ddf, i);
    case i of
      0: Trg.InitialPriority := pcRealTime;
      1: Trg.InitialPriority := pcHigh;
      2: Trg.InitialPriority := pcNormal;
      3: Trg.InitialPriority := pcIdle;
    else
      Trg.InitialPriority := pcDefault;
    end;
  end;
  // makeCompat block 2
  if not EOF(ddf) then
  begin
    ReadLn(ddf, s);
    while s <> '$' do
    begin
      Commands.Add(s);
      ReadLn(ddf, s);
    end;
  end;
  // makeCompat block 3
  if not EOF(ddf) then
  begin
    ReadLn(ddf, s);
    while s <> '$' do
    begin
      CdPaths.Add(s);
      ReadLn(ddf, s);
    end;
  end;
  // makeCompat block 4
  if not EOF(ddf) then
    ReadLn(ddf, HexDump)
  else
    HexDump := '';  
  CloseFile(ddf);
  Erase(ddf);
  BigMax := Commands.Count;
  BigCurrent := 0;
end;

procedure TWrap.FormCreate(Sender: TObject);
begin
  //SetFormIcons(Handle, 'books', 'books');
  if ParamStr(1) <> 'sevgi' then
  begin
    Application.MessageBox(PChar(cInternal), nil, 0);
    Exit;
  end;
  if not FileExists(ParamStr(2)) then
  begin
    Application.MessageBox(PChar(cBadDir), nil, 0);
    Exit;
  end;
  Cancel.Caption := cCancel;
  Pause.Caption := '';
  details.Caption := cw0;
  ReadDirective(ParamStr(2), Console);
  TimerTimer(nil);
end;

procedure TWrap.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := false;
  if Quit then
  begin
    if HexDump <> '' then
      Memo.Lines.SaveToFile(HexDump);
    //messagebox(0, pchar(Memo.Lines.text), nil, 0);
    Application.Terminate;
  end;
  if Start then
  begin
    Start := false;
    Thread := cThread.Create(True);
    Thread.FreeOnTerminate := True;
    Thread.Resume;
  end;
  if Pause.Caption = '' then
    if PauseCap <> '' then
      Pause.Caption := PauseCap;
  Target.FileName := Memo.Lines[Memo.Lines.Count -1];
  Major.Position := Big;
  Win7TaskBarSet(Application.Handle, Big);
  Timer.Enabled := True;
end;

procedure TWrap.pauseClick(Sender: TObject);
begin
  if Pause.Caption = cSpeedUp then
  begin
    Pause.Caption := cSlowDown;
    SetThreadPriority(Console.ThreadID, THREAD_PRIORITY_NORMAL);
    SetPriorityClass(Console.ProcessID, NORMAL_PRIORITY_CLASS);
  end
  else
  begin
    Pause.Caption := cSpeedUp;
    SetThreadPriority(Console.ThreadID, THREAD_PRIORITY_BELOW_NORMAL);
    SetPriorityClass(Console.ProcessID, IDLE_PRIORITY_CLASS);
  end;
end;

procedure TWrap.CancelClick(Sender: TObject);
begin
  // protection for when we are switching between tasks
  if not Console.Running then Exit;
  Cancel.Caption := cWait;
  Cancel.Enabled := false;
  Console.Terminate(0);
  Quit := True;
end;

procedure TWrap.ConsoleTerminated(Sender: TObject);
begin
  //Quit := True; permit multiple sessions
  if HexDump <> '' then // make sure latest session does get saved!!!
    Memo.Lines.SaveToFile(HexDump);
end;

procedure TWrap.ConsoleData(Sender: TRedirector; buffer: Pointer;
  Size: Integer);
var
  p: PChar;
  s, sX: String;
  i, j, k: Integer;
begin
  p := StrAlloc(Size + 1);
  StrLCopy(p, buffer, Size);
  p[Size] := #0;
  ParseText(String(p), Memo, i);
  if i <> 0 then
  begin
    //Big := i;
    k := i div BigMax;
    j := BigCurrent * (100 div BigMax);
    Big := k + j;
  end;
  sX := '';
  s := p;
  for i := 1 to Length(s) do
    if s[i] <> #8 then
      sX := sX + s[i];
  if DOSEmu.Lines.Count = 0 then DOSEmu.Lines.Add('');
  DOSEmu.Lines[DOSEmu.Lines.Count -1] := sX;
  StrDispose(p);
  Application.HandleMessage;
end;

procedure TWrap.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Console.SendText(Chr(Key)+#10); // only #10 required to designate new input!
end;

procedure TWrap.DOSEmuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Console.SendText(Chr(Key)+#10); // only #10 required to designate new input!
end;

procedure TWrap.detailsClick(Sender: TObject);
begin
  DOSEmu.Visible := not DOSEmu.Visible;
  anim.Visible := not anim.Visible;
  if DOSEmu.Visible then details.Caption := cw1
    else details.Caption := cw0;
end;

procedure TWrap.ConsoleErrorData(Sender: TRedirector; buffer: Pointer;
  Size: Integer);
var
  p: PChar;
  i, j, k: Integer;
  s, sX: String;
begin
  p := StrAlloc(Size + 1);
  StrLCopy(p, buffer, Size);
  p[Size] := #0;
  ParseText(String(p), Memo, i);
  if i <> 0 then
  begin
    //Big := i;
    k := i div BigMax;
    j := BigCurrent * (100 div BigMax);
    Big := k + j;
    //BigMax := Commands.Count;
    //BigCurrent := 0;
    // 100 div BigMax = current progress spatializer; 100 div 1 = 100; 100 div 3 = 33;
    // BigCurrent * (100 div BigMax) = current progress bonus; 0 * 100 = 0; 0 * 33 = 0; 1 * 33 = 33; 2 * 33 = 66;
    // Big div BigMax = progress actualizer; 50 div 1 = 50; 50 div 3 = 16;
  end;
  sX := '';
  s := p;
  for i := 1 to Length(s) do
    if s[i] <> #8 then
      sX := sX + s[i];
  if DOSEmu.Lines.Count = 0 then DOSEmu.Lines.Add('');
  DOSEmu.Lines[DOSEmu.Lines.Count -1] := sX;
  StrDispose(p);
  Application.HandleMessage;
end;

procedure TWrap.detailsMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsUnderline];
end;

procedure TWrap.detailsMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
end;

initialization
begin
  Commands := TStringList.Create;
  CdPaths := TStringList.Create;
end;

finalization
begin
  Commands.Free;
  CdPaths.Free;
end;

end.

