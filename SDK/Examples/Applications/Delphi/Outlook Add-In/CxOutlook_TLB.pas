unit CxOutlook_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 11/25/02 4:29:56 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\Outlook Add-In\mOutlookAddIn.tlb (1)
// LIBID: {77D07218-0044-11D7-B569-00B0D066795E}
// LCID: 0
// Helpfile: 
// HelpString: CxOutlook Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\StdOle2.Tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CxOutlookMajorVersion = 1;
  CxOutlookMinorVersion = 0;

  LIBID_CxOutlook: TGUID = '{77D07218-0044-11D7-B569-00B0D066795E}';

  IID_ICodex: TGUID = '{77D07219-0044-11D7-B569-00B0D066795E}';
  CLASS_Codex: TGUID = '{77D0721A-0044-11D7-B569-00B0D066795E}';
  IID_IToolsOptionsPage: TGUID = '{77D0721B-0044-11D7-B569-00B0D066795E}';
  CLASS_ToolsOptionsPage: TGUID = '{77D0721C-0044-11D7-B569-00B0D066795E}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICodex = interface;
  ICodexDisp = dispinterface;
  IToolsOptionsPage = interface;
  IToolsOptionsPageDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Codex = ICodex;
  ToolsOptionsPage = IToolsOptionsPage;


// *********************************************************************//
// Interface: ICodex
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {77D07219-0044-11D7-B569-00B0D066795E}
// *********************************************************************//
  ICodex = interface(IDispatch)
    ['{77D07219-0044-11D7-B569-00B0D066795E}']
  end;

// *********************************************************************//
// DispIntf:  ICodexDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {77D07219-0044-11D7-B569-00B0D066795E}
// *********************************************************************//
  ICodexDisp = dispinterface
    ['{77D07219-0044-11D7-B569-00B0D066795E}']
  end;

// *********************************************************************//
// Interface: IToolsOptionsPage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {77D0721B-0044-11D7-B569-00B0D066795E}
// *********************************************************************//
  IToolsOptionsPage = interface(IDispatch)
    ['{77D0721B-0044-11D7-B569-00B0D066795E}']
  end;

// *********************************************************************//
// DispIntf:  IToolsOptionsPageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {77D0721B-0044-11D7-B569-00B0D066795E}
// *********************************************************************//
  IToolsOptionsPageDisp = dispinterface
    ['{77D0721B-0044-11D7-B569-00B0D066795E}']
  end;

// *********************************************************************//
// The Class CoCodex provides a Create and CreateRemote method to          
// create instances of the default interface ICodex exposed by              
// the CoClass Codex. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCodex = class
    class function Create: ICodex;
    class function CreateRemote(const MachineName: string): ICodex;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TToolsOptionsPage
// Help String      : 
// Default Interface: IToolsOptionsPage
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TToolsOptionsPage = class(TOleControl)
  private
    FIntf: IToolsOptionsPage;
    function  GetControlInterface: IToolsOptionsPage;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IToolsOptionsPage read GetControlInterface;
    property  DefaultInterface: IToolsOptionsPage read GetControlInterface;
  published
    property Anchors;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoCodex.Create: ICodex;
begin
  Result := CreateComObject(CLASS_Codex) as ICodex;
end;

class function CoCodex.CreateRemote(const MachineName: string): ICodex;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Codex) as ICodex;
end;

procedure TToolsOptionsPage.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{77D0721C-0044-11D7-B569-00B0D066795E}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TToolsOptionsPage.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IToolsOptionsPage;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TToolsOptionsPage.GetControlInterface: IToolsOptionsPage;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TToolsOptionsPage]);
end;

end.
