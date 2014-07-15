{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCodex, Menus, ComCtrls, StdCtrls, CheckLst, FileCtrl;

type
  TGui = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    LoadPlugIns1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    FreePlugIns1: TMenuItem;
    StatusBar: TStatusBar;
    Shell1: TMenuItem;
    CheckAssociations1: TMenuItem;
    EditAssociations1: TMenuItem;
    ForceAssociations1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ListPlugIns1: TMenuItem;
    Page: TPageControl;
    PlugTab: TTabSheet;
    PlugInList: TListBox;
    Button1: TButton;
    ArchivesSupported: TListBox;
    Button2: TButton;
    FunctionsSupported: TListBox;
    Button3: TButton;
    EditBindings1: TMenuItem;
    N3: TMenuItem;
    GetGenericViewer1: TMenuItem;
    SetGenericViewer1: TMenuItem;
    N4: TMenuItem;
    RegisterApplet1: TMenuItem;
    ArcTab: TTabSheet;
    Archives1: TMenuItem;
    N2: TMenuItem;
    GetCompressibleArchives1: TMenuItem;
    CompArc: TListBox;
    Label1: TLabel;
    ExtArc: TListBox;
    Label2: TLabel;
    GetExtractableArchives1: TMenuItem;
    GetAllSupportedArchives1: TMenuItem;
    AllArc: TListBox;
    Label3: TLabel;
    WorkTab: TTabSheet;
    Contents: TListBox;
    File2: TMenuItem;
    Open1: TMenuItem;
    Size: TLabel;
    CompSize: TLabel;
    DateTime: TLabel;
    Password: TLabel;
    OpenDialog: TOpenDialog;
    WelcomeTab: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    AllArcList: TListBox;
    GetAllArchives1: TMenuItem;
    Button4: TButton;
    Button5: TButton;
    CompProf: TListBox;
    ExtProf: TListBox;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    TabSheet1: TTabSheet;
    Label10: TLabel;
    Dir: TDirectoryListBox;
    Drv: TDriveComboBox;
    Fil: TFileListBox;
    Recursive: TCheckBox;
    Plural: TCheckBox;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    SaveDialog: TSaveDialog;
    Button17: TButton;
    SaveDialogEx: TSaveDialog;
    PopupMenu: TPopupMenu;
    procedure Exit1Click(Sender: TObject);
    procedure LoadPlugIns1Click(Sender: TObject);
    procedure FreePlugIns1Click(Sender: TObject);
    procedure CheckAssociations1Click(Sender: TObject);
    procedure ForceAssociations1Click(Sender: TObject);
    procedure EditAssociations1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ListPlugIns1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EditBindings1Click(Sender: TObject);
    procedure GetGenericViewer1Click(Sender: TObject);
    procedure SetGenericViewer1Click(Sender: TObject);
    procedure RegisterApplet1Click(Sender: TObject);
    procedure GetCompressibleArchives1Click(Sender: TObject);
    procedure GetExtractableArchives1Click(Sender: TObject);
    procedure GetAllSupportedArchives1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ContentsClick(Sender: TObject);
    procedure GetAllArchives1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure PluralClick(Sender: TObject);
    procedure PluralKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button14Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure ToolMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure OpenArchiveTemp;
  end;

var
  Gui: TGui;
  gNames, gPwdNames, gDateTimes, gSizes, gCompSizes: TStringList;

implementation

{$R *.dfm}

procedure TGui.ToolMenuClick(Sender: TObject);
var
  i: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  for i := 1 to Contents.Count do
    if Contents.Selected[i -1] then
      l.Add(Contents.Items[i -1]);
  RunArchiveTool(PChar(OpenDialog.FileName), PChar(l.CommaText),
    PChar(TMenuItem(Sender).Caption));
  l.Free;
  OpenArchiveTemp;
end;

procedure TGui.OpenArchiveTemp;
var
  Names, pwdNames, DateTimes, Sizes, CompSizes: PChar;
begin
    Contents.Items.Clear;
    StatusBar.SimpleText := QueryArchive(PChar(OpenDialog.FileName), Names, pwdNames, DateTimes, Sizes, compSizes);
    if StatusBar.SimpleText = '' then
    begin
      StatusBar.SimpleText := 'Archive opened successfully';
      Contents.Items.CommaText := Names;
      gNames.CommaText := Names;
      gPwdNames.CommaText := pwdNames;
      gDateTimes.CommaText := DateTimes;
      gSizes.CommaText := Sizes;
      gCompSizes.CommaText := CompSizes;
    end;
    Page.ActivePage := WorkTab;
end;

procedure TGui.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TGui.LoadPlugIns1Click(Sender: TObject);
begin
  StatusBar.SimpleText := IntToStr(LoadPlugIns) + ' archive types supported';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.FreePlugIns1Click(Sender: TObject);
begin
  FreePlugIns;
  StatusBar.SimpleText := 'Codex uninitialized.';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.CheckAssociations1Click(Sender: TObject);
begin
  if CheckCodexAssociations then
    StatusBar.SimpleText := 'Archive associations are valid'
  else
    StatusBar.SimpleText := 'Archive associations have recently been changed';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.ForceAssociations1Click(Sender: TObject);
begin
  ForceCodexAssociations;
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.EditAssociations1Click(Sender: TObject);
begin
  EditCodexAssociations;
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.About1Click(Sender: TObject);
begin
  CodexAbout(Application.Icon.Handle, 'MimarSinan Codex Test Skin',
    'Copyright(C) 2002 MimarSinan International', 'MimarSinan Research Labs',
    'http://www.mimarsinan.com', 'Codex API Test v1.0 - documenting the entire Codex API');
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.ListPlugIns1Click(Sender: TObject);
begin
  PlugInList.Items.CommaText := GetPlugIns;
  Page.ActivePage := PlugTab;
end;

procedure TGui.Button1Click(Sender: TObject);
begin
  ShowPlugInAbout(PChar(PlugInList.Items[PlugInList.ItemIndex]));
end;

procedure TGui.Button2Click(Sender: TObject);
begin
  ArchivesSupported.Items.CommaText :=
    GetArchivesByPlugIn(PChar(PlugInList.Items[PlugInList.ItemIndex]));
end;

procedure TGui.Button3Click(Sender: TObject);
begin
  FunctionsSupported.Items.CommaText :=
    GetArchiveFunctionsByPlugIn(PChar(ArchivesSupported.Items[ArchivesSupported.ItemIndex]),
      PChar(PlugInList.Items[PlugInList.ItemIndex]));
end;

procedure TGui.EditBindings1Click(Sender: TObject);
begin
  if EditPlugInBindings then StatusBar.SimpleText := 'Plug-in bindings have changed'
    else StatusBar.SimpleText := 'Bindings have not changed';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.GetGenericViewer1Click(Sender: TObject);
begin
  Application.MessageBox(GetGenericViewer, 'Generic Viewer',
    mb_Ok + mb_IconInformation);
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.SetGenericViewer1Click(Sender: TObject);
var
  s: String;
begin
  if InputQuery('Set Generic Viewer', 'Path:', s) then
    SetGenericViewer(PChar(s));
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.RegisterApplet1Click(Sender: TObject);
begin
  if RegisterCodexApplication('Test Skin', PChar(ParamStr(0)), nil) then
    StatusBar.SimpleText := 'Application registered to open with archives'
  else
    StatusBar.SimpleText := 'Application registration failed!';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.GetCompressibleArchives1Click(Sender: TObject);
begin
  CompArc.Items.CommaText := GetCompressibleArchives;
  Page.ActivePage := ArcTab;
end;

procedure TGui.GetExtractableArchives1Click(Sender: TObject);
begin
  ExtArc.Items.CommaText := GetExtractableArchives;
  Page.ActivePage := ArcTab;
end;

procedure TGui.GetAllSupportedArchives1Click(Sender: TObject);
begin
  AllArc.Items.CommaText := GetSupportedArchives;
  Page.ActivePage := ArcTab;
end;

procedure TGui.Open1Click(Sender: TObject);
var
  i: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  l.CommaText := GetSupportedArchives;
  if l.Count <> 0 then
  begin
    OpenDialog.Filter := 'Archive Files|';
    for i := 1 to l.Count do
      OpenDialog.Filter := OpenDialog.Filter + '*.' + l[i -1] + ';';
    OpenDialog.Filter := OpenDialog.Filter + '|';
    l.Free;
  end
  else
    OpenDialog.Filter := '';
  OpenDialog.Filter := OpenDialog.Filter + 'All Files|*.*';
  if OpenDialog.Execute then OpenArchiveTemp;
end;

procedure TGui.ContentsClick(Sender: TObject);
begin
  Size.Caption := 'Size: ' + gSizes[Contents.ItemIndex];
  CompSize.Caption := 'Compressed Size: ' + gCompSizes[Contents.ItemIndex];
  DateTime.Caption := 'Date and Time: ' + gDateTimes[Contents.ItemIndex];
  if gPwdNames.IndexOf(Contents.Items[Contents.ItemIndex]) <> -1 then
    Password.Caption := 'Password Protected: YES'
  else
    Password.Caption := 'Password Protected: NO';
end;

procedure TGui.GetAllArchives1Click(Sender: TObject);
begin
  AllArcList.Items.CommaText := GetArchives;
  Page.ActivePage := PlugTab;
end;

procedure TGui.FormCreate(Sender: TObject);
begin
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.Button4Click(Sender: TObject);
begin
  CompProf.Items.CommaText := GetCompressionProfiles(PChar(CompArc.Items[CompArc.ItemIndex]));
end;

procedure TGui.Button5Click(Sender: TObject);
begin
  ExtProf.Items.CommaText := GetExtractionProfiles(PChar(ExtArc.Items[ExtArc.ItemIndex]));
end;

procedure TGui.Button6Click(Sender: TObject);
begin
  EditCompressionProfile(PChar(CompArc.Items[CompArc.ItemIndex]),
    PChar(CompProf.Items[CompProf.ItemIndex]));
end;

procedure TGui.Button7Click(Sender: TObject);
begin
  EditExtractionProfile(PChar(ExtArc.Items[ExtArc.ItemIndex]),
    PChar(ExtProf.Items[ExtProf.ItemIndex]));
end;

procedure TGui.Button8Click(Sender: TObject);
begin
  DeleteCompressionProfile(PChar(CompArc.Items[CompArc.ItemIndex]),
    PChar(CompProf.Items[CompProf.ItemIndex]));
end;

procedure TGui.Button9Click(Sender: TObject);
begin
  DeleteExtractionProfile(PChar(ExtArc.Items[ExtArc.ItemIndex]),
    PChar(ExtProf.Items[ExtProf.ItemIndex]));
end;

procedure TGui.Button16Click(Sender: TObject);
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  l.CommaText := GetCompressibleArchives;
  if l.Count <> 0 then
  begin
    SaveDialog.Filter := 'Compressible Archives|';
    for i := 1 to l.Count do
      SaveDialog.Filter := SaveDialog.Filter + '*.' + l[i -1] + ';';
    SaveDialog.Filter := SaveDialog.Filter + '|';
  end
  else
    SaveDialog.Filter := '';
  SaveDialog.Filter := SaveDialog.Filter + 'All Files|*.*';
  if SaveDialog.Execute then
  begin
    l.Clear;
    for i := 1 to Fil.Items.Count do
      if Fil.Selected[i -1] then
      begin
        s := Fil.Items[i -1];
        if Pos('[', s) <> 0 then
        begin
          Delete(s, 1, 1);
          Delete(s, Length(s), 1);
          s := s + '\*.*';
        end;
        if Dir.Directory[Length(Dir.Directory)] <> '\' then
          s := Dir.Directory + '\' + s
        else
          s := Dir.Directory + '\' + s;
        l.Add(s);
      end;
    if Plural.Checked then
    begin
      if Recursive.Checked then
        CreateMergedArchive(PChar(SaveDialog.FileName), PChar(l.CommaText), nil, 'Default')
      else
        CreateMergedArchive(PChar(SaveDialog.FileName), nil, PChar(l.CommaText), 'Default');
    end
    else
    begin
      s := SaveDialog.FileName;
      s := ExtractFileExt(s);
      Delete(s, 1, 1);
      CreateSingularArchives(PChar(s), PChar(ExtractFilePath(SaveDialog.FileName)), PChar(l.CommaText), 'Default');
      StatusBar.SimpleText := 'Multiple archives created';
      Page.ActivePage := WelcomeTab;
    end;
    OpenDialog.FileName := SaveDialog.FileName;  
    OpenArchiveTemp;
  end;
  l.Free;
end;

procedure TGui.PluralClick(Sender: TObject);
begin
  Recursive.Enabled := Plural.Checked;
end;

procedure TGui.PluralKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Recursive.Enabled := Plural.Checked;
end;

procedure TGui.Button14Click(Sender: TObject);
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  if SelectDirectory('Select Output Folder', '', s) then
  begin
    l := TStringList.Create;
    for i := 1 to Contents.Count do
      if Contents.Selected[i -1] then
        l.Add(Contents.Items[i -1]);
    ExtractArchive(PChar(OpenDialog.FileName), PChar(s), PChar(l.CommaText), 'Default');
    l.Free;
  end;
end;

procedure TGui.Button11Click(Sender: TObject);
begin
  InstallArchive(PChar(OpenDialog.FileName));
end;

procedure TGui.Button12Click(Sender: TObject);
var
  p: PChar;
  s: String;
begin
  GetMem(p, MAX_PATH);
  GetWindowsDirectory(p, MAX_PATH);
  s := p;
  s := ExtractFileDrive(s) + '\Program Files';
  FreeMem(p);
  CheckOutArchive(PChar(OpenDialog.FileName), PChar(s),
    '.exe,.hlp,.chm');
end;

procedure TGui.Button17Click(Sender: TObject);
var
  i: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  l.CommaText := GetCompressibleArchives;
  if l.Count <> 0 then
  begin
    SaveDialogEx.Filter := 'Compressible Archives|';
    for i := 1 to l.Count do
      SaveDialogEx.Filter := SaveDialogEx.Filter + '*.' + l[i -1] + ';';
    SaveDialogEx.Filter := SaveDialogEx.Filter + '|';
  end
  else
    SaveDialogEx.Filter := '';
  SaveDialogEx.Filter := SaveDialogEx.Filter + 'All Files|*.*';
  if SaveDialogEx.Execute then
  begin
    ConvertArchive(PChar(OpenDialog.FileName), PChar(SaveDialogEx.FileName));
    OpenDialog.FileName := SaveDialogEx.FileName;
    OpenArchiveTemp;
  end;
end;

procedure TGui.Button10Click(Sender: TObject);
begin
  ViewUpdateArchive(PChar(OpenDialog.FileName),
    PChar(Contents.Items[Contents.ItemIndex]), True);
end;

procedure TGui.Button15Click(Sender: TObject);
var
  p: TPoint;
  s: String;
  i: Integer;
  m: TMenuItem;
  l: TStringList;
begin
  l := TStringList.Create;
  s := ExtractFileExt(OpenDialog.FileName);
  Delete(s, 1, 1);
  l.CommaText := GetArchiveTools(PChar(s));
  for i := PopupMenu.Items.Count downto 1 do
    PopupMenu.Items.Delete(i -1);
  for i := 1 to l.Count do
  begin
    m := TMenuItem.Create(PopupMenu);
    m.Caption := l[i -1];
    m.OnClick := ToolMenuClick;
    PopupMenu.Items.Add(m);
  end;
  l.Free;
  GetCursorPos(p);
  PopupMenu.Popup(p.X, p.Y);
end;

initialization
  gNames := TStringList.Create;
  gPwdNames := TStringList.Create;
  gDateTimes := TStringList.Create;
  gSizes := TStringList.Create;
  gCompSizes := TStringList.Create;

finalization
  gNames.Free;
  gPwdNames.Free;
  gDateTimes.Free;
  gSizes.Free;
  gCompSizes.Free;

end.
