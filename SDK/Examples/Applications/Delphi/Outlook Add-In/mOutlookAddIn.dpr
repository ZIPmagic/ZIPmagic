library mOutlookAddIn;

uses
  ComServ,
  uAddin in 'uAddin.pas' {Codex: CoClass},
  AddInDesignerObjects_TLB in 'AddInDesignerObjects_TLB.pas',
  uOutlookEvents in 'uOutlookEvents.pas',
  uParentedWnd in 'uParentedWnd.pas',
  fPropetyPage in 'fPropetyPage.pas' {ToolsOptionsPage: TActiveForm} {ActiveFormX: CoClass},
  uSharedDLL in 'uSharedDLL.pas',
  uCodex in 'uCodex.pas',
  CxOutlook_TLB in 'CxOutlook_TLB.pas';

{$E dll}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.RES}
{$R *.TLB}

begin
end.
