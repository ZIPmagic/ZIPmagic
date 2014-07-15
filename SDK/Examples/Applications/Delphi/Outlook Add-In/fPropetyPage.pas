unit fPropetyPage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, CxOutlook_TLB, StdVcl, Outlook_TLB, StdCtrls, ExtCtrls,
  ShellAPI, uSharedDLL, uCodex, Registry;

type
  TToolsOptionsPage = class(TActiveForm, IToolsOptionsPage, PropertyPage)
    Label1: TLabel;
    Bevel1: TBevel;
    Image1: TImage;
    Label2: TLabel;
    ArchiveTypes: TComboBox;
    Button1: TButton;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    Button2: TButton;
    Label6: TLabel;
    Bevel3: TBevel;
    Image2: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Button4: TButton;
    Image4: TImage;
    Note: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure ArchiveTypesChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure NoteClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Initialize; override;
    destructor Destroy;override;
    //PropertyPage
    function  GetPageInfo(var HelpFile: WideString; var HelpContext: Integer): HResult; stdcall;
    function  Get_Dirty(out Dirty: WordBool): HResult; stdcall;
    function  Apply: HResult; stdcall;
  end;

implementation

uses ComObj, ComServ;

var
  ModuleFile, ModuleFolder: String;
  p: PChar;

{$R *.DFM}

{ TActiveFormX }

function TToolsOptionsPage.Apply: HResult;
begin
  Result:=S_OK;
end;

function TToolsOptionsPage.Get_Dirty(out Dirty: WordBool): HResult;
begin
  Result:=S_OK;
end;

function TToolsOptionsPage.GetPageInfo(var HelpFile: WideString;
  var HelpContext: Integer): HResult;
begin
  Result:=S_OK;
end;

procedure TToolsOptionsPage.Initialize;
var
  s: String;
  r: TRegistry;
begin
  inherited Initialize;
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_READ;
  r.OpenKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In', True);
  s := r.ReadString('');
  Note.Checked := r.ReadString('note') = 'yes';
  r.CloseKey;
  r.Free;
  ArchiveTypes.Items.CommaText := GetCompressibleArchives;
  ArchiveTypes.Items.Insert(0, 'Don''t compress');
  if s = '' then
  begin
    if ArchiveTypes.Items.IndexOf('ZIP') <> -1 then
      ArchiveTypes.ItemIndex := ArchiveTypes.Items.IndexOf('ZIP')
    else
      ArchiveTypes.ItemIndex := 0;
  end
  else
  begin
    if ArchiveTypes.Items.IndexOf(s) <> -1 then
      ArchiveTypes.ItemIndex := ArchiveTypes.Items.IndexOf(s)
    else
      ArchiveTypes.ItemIndex := 0;
  end;
end;

destructor TToolsOptionsPage.Destroy;
begin
  inherited;
end;

procedure TToolsOptionsPage.Button2Click(Sender: TObject);
var
  p: PChar;
  s: String;
begin
  GetMem(p, MAX_PATH);
  GetSystemDirectory(p, MAX_PATH);
  s := AssertDirectoryFormat(p);
  FreeMem(p);
  WinExec(PChar('"' + s + 'mCodexDLLStub.exe" "' + s + 'mCodexAPI.dll" sample'), SW_SHOW);
end;

procedure TToolsOptionsPage.ArchiveTypesChange(Sender: TObject);
var
  r: TRegistry;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Self.Handle, 'Administrative rights required. Please contact your system administrator for help.',
      'Unable to change Codex setting', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_WRITE;
  r.OpenKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In', True);
  r.WriteString('', ArchiveTypes.Text);
  r.CloseKey;
  r.Free;
end;

procedure TToolsOptionsPage.Button1Click(Sender: TObject);
begin
  if ArchiveTypes.ItemIndex <> 0 then
    EditCompressionProfile(PChar(ArchiveTypes.Text), 'Shell');
end;

procedure TToolsOptionsPage.Button4Click(Sender: TObject);
begin
  CodexAbout(0, 'Codex Outlook Add-In',
    'Copyright© 1992-2002 MimarSinan International',
    'Designed and engineered at MimarSinan Research Labs.',
    'http://www.mimarsinan.com',
    PChar('Version: ' + GetFileDisplayVersion(ModuleFile)));
end;

procedure TToolsOptionsPage.NoteClick(Sender: TObject);
var
  r: TRegistry;
begin
  if not IsRegistryWritable then
  begin
    MessageBox(Self.Handle, 'Administrative rights required. Please contact your system administrator for help.',
      'Unable to change Codex setting', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_WRITE;
  r.OpenKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In', True);
  if Note.Checked then r.WriteString('note', 'yes')
    else r.WriteString('note', 'no');
  r.CloseKey;
  r.Free;
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TToolsOptionsPage,
    Class_ToolsOptionsPage,
    2,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
  GetMem(p, MAX_PATH);
  GetModuleFileName(GetModuleHandle('mCodexAddIn.dll'), p, MAX_PATH);
  ModuleFile := p;
  ModuleFolder := ExtractFilePath(p);
  FreeMem(p);

end.
