{ ========================================================================== }
{ Copyright(c) 1992-2003 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MimarSinan.Codex, Menus, ComCtrls, StdCtrls, CheckLst, FileCtrl,
  System.ComponentModel, System.Runtime.InteropServices, System.Text;

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
  RunArchiveTool(OpenDialog.FileName, l.CommaText, TMenuItem(Sender).Caption);
  l.Free;
  OpenArchiveTemp;
end;

procedure TGui.OpenArchiveTemp;
var
  Error, Names, pwdNames, DateTimes, Sizes, compSizes: StringBuilder;
  iError, iNames, ipwdNames, iDateTimes, iSizes, icompSizes: Integer;
begin
  Contents.Items.Clear;
  // determine sizes of buffers to receive archive information
  iError := QueryArchiveFieldLength(OpenDialog.FileName, iNames, ipwdNames, iDateTimes, iSizes, icompSizes);
  // allocate required buffer space
  Error := StringBuilder.Create(iError +1);
  Names := StringBuilder.Create(iNames +1);
  pwdNames := StringBuilder.Create(ipwdNames +1);
  Sizes := StringBuilder.Create(iSizes +1);
  compSizes := StringBuilder.Create(icompSizes +1);
  DateTimes := StringBuilder.Create(iDateTimes +1);
  // receive actual data into buffers
  QueryArchiveEx(Names, pwdNames, DateTimes, Sizes, compSizes, Error);
  if iError = 0 then
  begin
    StatusBar.SimpleText := 'Archive opened successfully';
    Contents.Items.CommaText := Names.ToString;
    gNames.CommaText := Names.ToString;
    gPwdNames.CommaText := pwdNames.ToString;
    gDateTimes.CommaText := DateTimes.ToString;
    gSizes.CommaText := Sizes.ToString;
    gCompSizes.CommaText := CompSizes.ToString;
  end
  else
    StatusBar.SimpleText := Error.ToString;
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
  CodexAbout(Application.Icon.Handle, 'MimarSinan Codex Test Skin for the Microsoft .NET Platform',
    'Copyright(C) 2002-2003 MimarSinan International', 'MimarSinan Research Labs',
    'http://www.mimarsinan.com', 'Codex API Test v1.0 - documenting the entire Codex API');
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.ListPlugIns1Click(Sender: TObject);
var
  PlugIns: StringBuilder;
begin
  PlugIns := StringBuilder.Create(GetPlugInsEx(nil) +1);
  GetPlugInsEx(PlugIns);
  PlugInList.Items.CommaText := PlugIns.ToString;
  Page.ActivePage := PlugTab;
end;

procedure TGui.Button1Click(Sender: TObject);
begin
  ShowPlugInAbout(PlugInList.Items[PlugInList.ItemIndex]);
end;

procedure TGui.Button2Click(Sender: TObject);
var
  Archives: StringBuilder;
begin
  Archives := StringBuilder.Create(
    GetArchivesByPlugInEx(PlugInList.Items[PlugInList.ItemIndex], nil) +1);
  GetArchivesByPlugInEx(PlugInList.Items[PlugInList.ItemIndex], Archives);
  ArchivesSupported.Items.CommaText := Archives.ToString;
end;

procedure TGui.Button3Click(Sender: TObject);
var
  Functions: StringBuilder;
begin
  Functions := StringBuilder.Create(
    GetArchiveFunctionsByPlugInEx(
    ArchivesSupported.Items[ArchivesSupported.ItemIndex],
    PlugInList.Items[PlugInList.ItemIndex], nil) +1);
  GetArchiveFunctionsByPlugInEx(
    ArchivesSupported.Items[ArchivesSupported.ItemIndex],
    PlugInList.Items[PlugInList.ItemIndex], Functions);
  FunctionsSupported.Items.CommaText := Functions.ToString;
end;

procedure TGui.EditBindings1Click(Sender: TObject);
begin
  if EditPlugInBindings then StatusBar.SimpleText := 'Plug-in bindings have changed'
    else StatusBar.SimpleText := 'Bindings have not changed';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.GetGenericViewer1Click(Sender: TObject);
var
  GenericViewer: StringBuilder;
begin
  GenericViewer := StringBuilder.Create(GetGenericViewerEx(nil) +1);
  GetGenericViewerEx(GenericViewer);
  Application.MessageBox(GenericViewer.ToString, 'Generic Viewer',
    mb_Ok + mb_IconInformation);
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.SetGenericViewer1Click(Sender: TObject);
var
  s: String;
begin
  if InputQuery('Set Generic Viewer', 'Path:', s) then
    SetGenericViewer(s);
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.RegisterApplet1Click(Sender: TObject);
begin
  if RegisterCodexApplication('Test Skin', ParamStr(0), nil) then
    StatusBar.SimpleText := 'Application registered to open with archives'
  else
    StatusBar.SimpleText := 'Application registration failed!';
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.GetCompressibleArchives1Click(Sender: TObject);
var
  Compressible: StringBuilder;
begin
  Compressible := StringBuilder.Create(GetCompressibleArchivesEx(nil) +1);
  GetCompressibleArchivesEx(Compressible);
  CompArc.Items.CommaText := Compressible.ToString;
  Page.ActivePage := ArcTab;
end;

procedure TGui.GetExtractableArchives1Click(Sender: TObject);
var
  Extractable: StringBuilder;
begin
  Extractable := StringBuilder.Create(GetExtractableArchivesEx(nil) +1);
  GetExtractableArchivesEx(Extractable);
  ExtArc.Items.CommaText := Extractable.ToString;
  Page.ActivePage := ArcTab;
end;

procedure TGui.GetAllSupportedArchives1Click(Sender: TObject);
var
  Supported: StringBuilder;
begin
  Supported := StringBuilder.Create(GetSupportedArchivesEx(nil) +1);
  GetSupportedArchivesEx(Supported);
  AllArc.Items.CommaText := Supported.ToString;
  Page.ActivePage := ArcTab;
end;

procedure TGui.Open1Click(Sender: TObject);
var
  i: Integer;
  l: TStringList;
  Supported: StringBuilder;
begin
  l := TStringList.Create;
  Supported := StringBuilder.Create(GetSupportedArchivesEx(nil) +1);
  GetSupportedArchivesEx(Supported);
  l.CommaText := Supported.ToString;
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
var
  Archives: StringBuilder;
begin
  Archives := StringBuilder.Create(GetArchivesEx(nil) +1);
  GetArchivesEx(Archives);
  AllArcList.Items.CommaText := Archives.ToString;
  Page.ActivePage := PlugTab;
end;

procedure TGui.FormCreate(Sender: TObject);
begin
  Page.ActivePage := WelcomeTab;
end;

procedure TGui.Button4Click(Sender: TObject);
var
  cProf: StringBuilder;
begin
  cProf := StringBuilder.Create(GetCompressionProfilesEx(CompArc.Items[CompArc.ItemIndex], nil) +1);
  GetCompressionProfilesEx(CompArc.Items[CompArc.ItemIndex], cProf);
  CompProf.Items.CommaText := cProf.ToString;
end;

procedure TGui.Button5Click(Sender: TObject);
var
  eProf: StringBuilder;
begin
  eProf := StringBuilder.Create(GetExtractionProfilesEx(ExtArc.Items[ExtArc.ItemIndex], nil) +1);
  GetExtractionProfilesEx(ExtArc.Items[ExtArc.ItemIndex], eProf);
  ExtProf.Items.CommaText := eProf.ToString;
end;

procedure TGui.Button6Click(Sender: TObject);
begin
  EditCompressionProfile(CompArc.Items[CompArc.ItemIndex],
    CompProf.Items[CompProf.ItemIndex]);
end;

procedure TGui.Button7Click(Sender: TObject);
begin
  EditExtractionProfile(ExtArc.Items[ExtArc.ItemIndex],
    ExtProf.Items[ExtProf.ItemIndex]);
end;

procedure TGui.Button8Click(Sender: TObject);
begin
  DeleteCompressionProfile(CompArc.Items[CompArc.ItemIndex],
    CompProf.Items[CompProf.ItemIndex]);
end;

procedure TGui.Button9Click(Sender: TObject);
begin
  DeleteExtractionProfile(ExtArc.Items[ExtArc.ItemIndex],
    ExtProf.Items[ExtProf.ItemIndex]);
end;

procedure TGui.Button16Click(Sender: TObject);
var
  s: String;
  i: Integer;
  l: TStringList;
  CompressibleArchives: StringBuilder;
begin
  l := TStringList.Create;
  CompressibleArchives := StringBuilder.Create(GetCompressibleArchivesEx(nil) +1);
  GetCompressibleArchivesEx(CompressibleArchives);
  l.CommaText := CompressibleArchives.ToString;
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
        CreateMergedArchive(SaveDialog.FileName, l.CommaText, nil, 'Default')
      else
        CreateMergedArchive(SaveDialog.FileName, nil, l.CommaText, 'Default');
    end
    else
    begin
      s := SaveDialog.FileName;
      s := ExtractFileExt(s);
      Delete(s, 1, 1);
      CreateSingularArchives(s, ExtractFilePath(SaveDialog.FileName), l.CommaText, 'Default');
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
    ExtractArchive(OpenDialog.FileName, s, l.CommaText, 'Default');
    l.Free;
  end;
end;

procedure TGui.Button11Click(Sender: TObject);
begin
  InstallArchive(OpenDialog.FileName);
end;

procedure TGui.Button12Click(Sender: TObject);
var
  b: StringBuilder;
  s: String;
begin
  b := StringBuilder.Create(MAX_PATH);
  GetWindowsDirectory(b, b.Capacity);
  s := b.ToString;
  s := ExtractFileDrive(s) + '\Program Files';
  CheckOutArchive(OpenDialog.FileName, s,
    '.exe,.hlp,.chm');
end;

procedure TGui.Button17Click(Sender: TObject);
var
  i: Integer;
  l: TStringList;
  Compressible: StringBuilder;
begin
  l := TStringList.Create;
  Compressible := StringBuilder.Create(GetCompressibleArchivesEx(nil) +1);
  GetCompressibleArchivesEx(Compressible);
  l.CommaText := Compressible.ToString;
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
    ConvertArchive(OpenDialog.FileName, SaveDialogEx.FileName);
    OpenDialog.FileName := SaveDialogEx.FileName;
    OpenArchiveTemp;
  end;
end;

procedure TGui.Button10Click(Sender: TObject);
begin
  ViewUpdateArchive(OpenDialog.FileName,
    Contents.Items[Contents.ItemIndex], True);
end;

procedure TGui.Button15Click(Sender: TObject);
var
  p: TPoint;
  s: String;
  i: Integer;
  m: TMenuItem;
  l: TStringList;
  Tools: StringBuilder;
begin
  l := TStringList.Create;
  s := ExtractFileExt(OpenDialog.FileName);
  Delete(s, 1, 1);
  Tools := StringBuilder.Create(GetArchiveToolsEx(s, nil) +1);
  GetArchiveToolsEx(s, Tools);
  l.CommaText := Tools.ToString;
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
