{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

program mSkin;

uses
  Forms,
  SysUtils,
  uForm in 'uForm.pas' {Gui},
  uCodex in 'uCodex.pas';

{$R *.res}

begin
  StartSplash('MimarSinan Codex Test Skin', PChar(ParamStr(0)));
  CheckCodexAssociations;
  Application.Initialize;
  Application.Title := 'MimarSinan Codex Test Skin';
  Application.CreateForm(TGui, Gui);
  EndSplash;
  Application.Run;
  EraseWorkingFiles;
end.
