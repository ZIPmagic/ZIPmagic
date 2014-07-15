unit uAddin;

interface

uses
  Classes, Windows, ComObj, ActiveX, CxOutlook_TLB, StdVcl, Registry,
  contnrs, Sysutils, ShellAPI, Graphics, clipbrd, Forms, Dialogs, Buttons,
  Controls, extctrls, Variants, uSharedDLL, uCodex,
  AddInDesignerObjects_TLB, uOutlookEvents, Outlook_TLB, Office_TLB;

type

  TCodexFactory = class(TAutoObjectFactory)
  public
    procedure UpdateRegistry(Register: Boolean); override;
  end;

  TCodex = class(TAutoObject, ICodex, _IDTExtensibility2)
  private
    FApplication : OleVariant;
    FInspectors : TOutlookInspectors;
    FInspectorsList : TObjectList;
    FExplorers : TOutlookExplorers;
    FExplorersList : TObjectList;
    FOutlookApplication : TOutlookApplication;
  protected
    { Protected declarations }
  public
    //_IDTExtensibility2
    procedure OnConnection(const Application: IDispatch; ConnectMode: ext_ConnectMode;
                           const AddInInst: IDispatch; var custom: PSafeArray); safecall;
    procedure OnDisconnection(RemoveMode: ext_DisconnectMode; var custom: PSafeArray); safecall;
    procedure OnAddInsUpdate(var custom: PSafeArray); safecall;
    procedure OnStartupComplete(var custom: PSafeArray); safecall;
    procedure OnBeginShutdown(var custom: PSafeArray); safecall;
    //VCL
    procedure AfterConstruction;override;
    destructor Destroy;override;
    procedure OnOptionsPagesAdd(Sender : TOutlookApplication; const Pages: PropertyPages);
    procedure OnItemSend(Sender : TOutlookApplication; const Item: IDispatch; var Cancel: WordBool);
  end;

implementation

uses ComServ;

{ TCodexFactory }

procedure TCodexFactory.UpdateRegistry(Register: Boolean);
var Reg:TRegistry;
begin
  inherited;
  Reg:=TRegistry.Create;
  try
    Reg.RootKey:=HKEY_LOCAL_MACHINE;//HKEY_CURRENT_USER;
    if Register then begin
      if Reg.OpenKey('Software\Microsoft\Office\Outlook\Addins\'+GetProgID, TRUE) then begin
        Reg.WriteString('FriendlyName', 'Codex Outlook Add-In');
        Reg.WriteInteger('LoadBehavior', 3);
        Reg.CloseKey;
      end;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.Access := KEY_WRITE;
      Reg.OpenKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In', True);
      Reg.WriteString('', 'ZIP');
      Reg.WriteString('note', 'yes');
      Reg.CloseKey;
    end
    else begin
      if Reg.KeyExists('Software\Microsoft\Office\Outlook\Addins\'+GetProgID) then begin
        Reg.DeleteKey('Software\Microsoft\Office\Outlook\Addins\'+GetProgID);
      end;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.Access := KEY_WRITE;
      Reg.DeleteKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In');
    end;
  finally
    Reg.Free;
  end;
end;

{ TCodex }

procedure TCodex.AfterConstruction;
begin
  inherited;
  FInspectorsList := TObjectList.Create(TRUE);
  FExplorersList := TObjectList.Create(TRUE);
  FInspectors:=nil;
  FExplorers:=nil;
  FOutlookApplication:=nil;
  LoadPlugIns;
end;

destructor TCodex.Destroy;
begin
  FreePlugIns;
  FreeAndNil(FInspectors);
  FreeAndNil(FInspectorsList);
  FreeAndNil(FExplorers);
  FreeAndNil(FExplorersList);
  FreeAndNil(FOutlookApplication);
  inherited;
end;

procedure TCodex.OnAddInsUpdate(var custom: PSafeArray);
begin
  //nothing
end;

procedure TCodex.OnBeginShutdown(var custom: PSafeArray);
begin
  //nothing
end;

procedure TCodex.OnConnection(const Application: IDispatch;
  ConnectMode: ext_ConnectMode; const AddInInst: IDispatch;
  var custom: PSafeArray);
begin
  FApplication:=Application;
  FOutlookApplication:=TOutlookApplication.Create(Application);
  FOutlookApplication.OnOptionsPagesAdd:=OnOptionsPagesAdd;
  FOutlookApplication.OnItemSend := OnItemSend;
end;

procedure TCodex.OnDisconnection(RemoveMode: ext_DisconnectMode;
  var custom: PSafeArray);
begin
  FreeAndNil(FOutlookApplication);
  FApplication:=Unassigned;
end;

procedure TCodex.OnStartupComplete(var custom: PSafeArray);
begin
  //nothing
end;

procedure TCodex.OnOptionsPagesAdd(Sender: TOutlookApplication;
  const Pages: PropertyPages);
begin
  try
    Pages.Add('CxOutlook.ToolsOptionsPage', 'Codex');
  except
    //oops...
  end;
end;

procedure TCodex.OnItemSend(Sender: TOutlookApplication;
  const Item: IDispatch; var Cancel: WordBool);
var
  i: Integer;
  p: PChar;
  s: String;
  r: TRegistry;
  g: TGUID;
  l: TStringList;
  t: TextFile;
  b: Boolean;
  sPath, sFile, sTempDir, sArchive: String;
  ItemOL: OLEVariant;
begin
  ItemOL := Item;
  b := false;
  if not VarIsNull(ItemOL) and not VarIsEmpty(ItemOL) then
    if itemOL.Attachments.Count <> 0 then
    begin
      // get default archive type for this session
      r := TRegistry.Create;
      r.RootKey := HKEY_LOCAL_MACHINE;
      r.Access := KEY_READ;
      r.OpenKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In\', True);
      sArchive := r.ReadString('');
      r.CloseKey;
      r.Free;
      if sArchive = 'Don''t compress' then Exit;
      if sArchive = '' then sArchive := 'ZIP';
      // assert that specified archive type is available
      l := TStringList.Create;
      l.CommaText := GetCompressibleArchives;
      if l.IndexOf(sArchive) = -1 then
      begin
        MessageBox(GetForegroundWindow, 'Attachments to this message cannot be compressed, because you have not chosen a valid archive type:'#13#13'1. Click the Tools menu, and choose Options,'#13'2. Select the Codex tab, and choose an available archive type.', 'Codex Add-In', mb_Ok + mb_IconStop);
        Cancel := True;
        Exit;
      end;
      l.Free;
      // get temp path for this session
      GetMem(p, MAX_PATH);
      GetTempPath(MAX_PATH, p);
      s := AssertDirectoryFormat(p) + 'mCodex\Power Toys\Outlook Add-In\';
      FreeMem(p);
      CoCreateGUID(g);
      sTempDir := AssertDirectoryFormat(s + GUIDToString(g));
      ForceDirectories(sTempDir);
      // process attachments
      for i := itemOL.Attachments.Count downto 1 do
      begin
        // get attachment file info
        sPath := itemOL.Attachments.Item(i).PathName;
        sFile := itemOL.Attachments.Item(i).FileName;
        if sPath <> '' then
        begin
          // only a link; so use the full path information
          if LowerCase(ExtractFileExt(sPath)) = LowerCase('.' + sArchive) then
          begin
            b := True;
            Continue;
          end;
          CopyFile(PChar(sPath), PChar(sTempDir + ExtractFileName(sPath)), false);
          itemOL.Attachments.Item(i).Delete;
        end;
        if sFile <> '' then
        begin
          // actual embedded file; so save and restore
          if LowerCase(ExtractFileExt(sFile)) = LowerCase('.' + sArchive) then
          begin
            b := True;
            Continue;
          end;
          while FileExists(sTempDir + sFile) do
            sFile := sFile + '_';
          itemOL.Attachments.Item(i).SaveAsFile(sTempDir + sFile);
          itemOL.Attachments.Item(i).Delete;
        end;
      end;
      // make compression list
      DeleteFile(sTempDir + 'attachment.html');
      l := FindAllFiles(sTempDir, '*.*', false);
      if l.Count <> 0 then
      begin
        CreateMergedArchive(PChar(sTempDir + 'attachment.' + sArchive), nil, PChar(l.CommaText), 'Shell');
        itemOL.Attachments.Add(sTempDir + 'attachment.' + sArchive, olByValue, 1, 'Compressed Attachments');
        b := True;
      end;
      if b then
      begin
        // add extraction note
        r := TRegistry.Create;
        r.RootKey := HKEY_LOCAL_MACHINE;
        r.Access := KEY_READ;
        r.OpenKey('SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Outlook Add-In\', True);
        if r.ReadString('note') = 'yes' then
        begin
          AssignFile(t, sTempDir + 'attachment.html');
          ReWrite(t);
          WriteLn(t, '<html>');
          WriteLn(t, '<head>');
          WriteLn(t, '<title>Archive XP 2003</title>');
          WriteLn(t, '</head>');
          WriteLn(t, '<body style="font-family: Tahoma; font-size: 10pt">');
          WriteLn(t, '<p>This email contains a <b>' + sArchive + ' </b>attachment. We recommended you');
          WriteLn(t, '<a href="http://www.cyberspacehq.com/products/codex">download');
          WriteLn(t, 'Archive XP</a> to extract the files inside this compressed attachment.</p>');
          WriteLn(t, '<p><a href="http://www.cyberspacehq.com/products/codex">Archive XP</a>');
          WriteLn(t, 'integrates with Outlook 2000/2002, transparently compressing your email');
          WriteLn(t, 'attachments, just like this email you received. It also makes archives appear as');
          WriteLn(t, 'regular folders in Explorer, so you can easily browse, compress, and extract');
          WriteLn(t, 'your archives. It supports 25 archive types for compression and 40 for');
          WriteLn(t, 'extraction.</p>');
          WriteLn(t, '<p>If you already have a compression tool installed on your computer which can');
          WriteLn(t, 'extract <b>' + sArchive + ' </b>files, you do not need to');
          WriteLn(t, '<a href="http://www.cyberspacehq.com/products/codex">download');
          WriteLn(t, 'Archive XP</a> to extract this attachment.</p>');
          WriteLn(t, '</body>');
          WriteLn(t, '</html>');
          CloseFile(t);
          itemOL.Attachments.Add(sTempDir + 'attachment.html', olByValue, 1, 'How to Extract the Attachments');
        end;
        r.CloseKey;
        r.Free;
      end;
      for i := 1 to l.Count do
        DeleteFile(l[i -1]);
      DeleteFile(sTempDir + 'attachment.' + sArchive);
      DeleteFile(sTempDir + 'attachment.html');
      RemoveDirectory(PChar(sTempDir));
      l.Free;
    end;
end;

initialization
  TCodexFactory.Create(ComServer, TCodex, Class_Codex,
    ciMultiInstance, tmApartment);
end.
