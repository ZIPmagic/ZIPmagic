{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uRecursiveExtract;

interface

uses
  Windows, ActiveX, ComObj, ShlObj, Dialogs;

type
  TContextMenu = class(TComObject, IShellExtInit, IContextMenu)
  private
    FFileName: array[0..MAX_PATH] of Char;
  protected
    { IShellExtInit }
    function IShellExtInit.Initialize = SEIInitialize; // Avoid compiler warning
    function SEIInitialize(pidlFolder: PItemIDList; lpdobj: IDataObject;
      hKeyProgID: HKEY): HResult; stdcall;
    { IContextMenu }
    function QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst, idCmdLast,
      uFlags: UINT): HResult; stdcall;
    function InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult; stdcall;
    function GetCommandString(idCmd, uType: UINT; pwReserved: PUINT;
      pszName: LPSTR; cchMax: UINT): HResult; stdcall;
  end;

const
  Class_ContextMenu: TGUID = '{7918F428-735F-4BB2-A8E5-9A5EA532CD1F}';

implementation

uses ComServ, SysUtils, ShellApi, Registry;

function TContextMenu.SEIInitialize(pidlFolder: PItemIDList; lpdobj: IDataObject;
  hKeyProgID: HKEY): HResult;
var
  StgMedium: TStgMedium;
  FormatEtc: TFormatEtc;
begin
  // Fail the call if lpdobj is Nil.
  if (lpdobj = nil) then begin
    Result := E_INVALIDARG;
    Exit;
  end;

  with FormatEtc do begin
    cfFormat := CF_HDROP;
    ptd      := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex   := -1;
    tymed    := TYMED_HGLOBAL;
  end;

  // Render the data referenced by the IDataObject pointer to an HGLOBAL
  // storage medium in CF_HDROP format.
  Result := lpdobj.GetData(FormatEtc, StgMedium);
  if Failed(Result) then
    Exit;

  // If only one file is selected, retrieve the file name and store it in
  // FFileName. Otherwise fail the call.
  if (DragQueryFile(StgMedium.hGlobal, $FFFFFFFF, nil, 0) = 1) then begin
    DragQueryFile(StgMedium.hGlobal, 0, FFileName, SizeOf(FFileName));
    Result := NOERROR;
  end
  else begin
    FFileName[0] := #0;
    Result := E_FAIL;
  end;

  ReleaseStgMedium(StgMedium);
end;

function TContextMenu.QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst,
          idCmdLast, uFlags: UINT): HResult;
begin
  Result := 0; // or use MakeResult(SEVERITY_SUCCESS, FACILITY_NULL, 0);

  if ((uFlags and $0000000F) = CMF_NORMAL) or
     ((uFlags and CMF_EXPLORE) <> 0) then begin

    // Add one menu item to context menu
    InsertMenu(Menu, indexMenu, MF_STRING or MF_BYPOSITION, idCmdFirst,
      'Recursive Extract');

    // Return number of menu items added
    Result := 1; // or use MakeResult(SEVERITY_SUCCESS, FACILITY_NULL, 1)
  end;
end;

function GetCompilerPath: string;
// Returns string containing path to Delphi command line compiler
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    with Reg do begin
      RootKey := HKEY_LOCAL_MACHINE;
      Access := KEY_READ;
      OpenKeyReadOnly('\SOFTWARE\MimarSinan\Codex\2.0\Power Toys\Recursive Extract');
      Result := ReadString('');
    end;
    if AnsiPos(' ', Result) <> 0 then
      Result := ExtractShortPathName(Result);
    Result := Result + ' "%s"';
  finally
    Reg.Free;
  end;
end;

function TContextMenu.InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult;
resourcestring
  sPathError = 'Error setting current directory';

var
  H: THandle;
  PrevDir: string;

begin
  Result := E_FAIL;
  // Make sure we are not being called by an application
  if (HiWord(Integer(lpici.lpVerb)) <> 0) then
  begin
    Exit;
  end;

  // Make sure we aren't being passed an invalid argument number
  if (LoWord(lpici.lpVerb) <> 0) then begin
    Result := E_INVALIDARG;
    Exit;
  end;

  // Execute the command specified by lpici.lpVerb
  // by invoking the Delphi command line compiler.
  PrevDir := GetCurrentDir;
  try
    if not SetCurrentDir(ExtractFilePath(FFileName)) then
      raise Exception.CreateRes(@sPathError);

    H := WinExec(PChar(Format(GetCompilerPath, [FFileName])), lpici.nShow);

    if (H < 32) then
      MessageBox(lpici.hWnd, 'Error executing the Recursive Extract tool. Please reinstall the tool.', 'Recursive Extract',
        MB_ICONERROR or MB_OK);
    Result := NOERROR;
  finally
    SetCurrentDir(PrevDir);
  end;
end;

function TContextMenu.GetCommandString(idCmd, uType: UINT; pwReserved: PUINT;
  pszName: LPSTR; cchMax: UINT): HRESULT;
begin
  if (idCmd = 0) then begin
    if (uType = GCS_HELPTEXT) then
      // return help string for menu item
      StrCopy(pszName, 'Extract all files from selected archive, including files inside nested archives in the archive');
    Result := NOERROR;
  end
  else
    Result := E_INVALIDARG;
end;

type
  TContextMenuFactory = class(TComObjectFactory)
  public
    procedure UpdateRegistry(Register: Boolean); override;
  end;

procedure TContextMenuFactory.UpdateRegistry(Register: Boolean);
var
  ClassID: string;
begin
  if Register then begin
    inherited UpdateRegistry(Register);

    ClassID := GUIDToString(Class_ContextMenu);
    CreateRegKey('MimarSinan Codex\shellex', '', '');
    CreateRegKey('MimarSinan Codex\shellex\ContextMenuHandlers', '', '');
    CreateRegKey('MimarSinan Codex\shellex\ContextMenuHandlers\Recursive Extract', '', ClassID);

    if (Win32Platform = VER_PLATFORM_WIN32_NT) then
      with TRegistry.Create do
        try
          RootKey := HKEY_LOCAL_MACHINE;
          OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions', True);
          OpenKey('Approved', True);
          WriteString(ClassID, 'MimarSinan Codex Recursive Extract');
        finally
          Free;
        end;
  end
  else begin
    DeleteRegKey('MimarSinan Codex\shellex\ContextMenuHandlers\Recursive Extract');

    inherited UpdateRegistry(Register);
  end;
end;

initialization
  TContextMenuFactory.Create(ComServer, TContextMenu, Class_ContextMenu,
    '', 'MimarSinan Codex Recursive Extract', ciMultiInstance,
    tmApartment);
end.
