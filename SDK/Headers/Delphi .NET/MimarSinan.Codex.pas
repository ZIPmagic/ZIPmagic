{ ========================================================================== }
{ Copyright(c) 1992-2003 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit MimarSinan.Codex platform;

interface

uses
  Windows, System.Runtime.InteropServices, System.Text;

const
  mCodexAPI = 'mCodexAPI.dll';

procedure StartSplash(Title, Icon: String);
procedure EndSplash;
procedure CodexAbout(Icon: HIcon; Product, Copyright, Design, DesignURL, Version: String);
procedure EraseWorkingFiles;

function CheckCodexAssociations: Boolean;
procedure EditCodexAssociations;
function ForceCodexAssociations: Short;
function EditPlugInBindings: Boolean;

procedure ShowPlugInAbout(PlugIn: String);
procedure BindPlugIn(Name, Format: String);
procedure UnBindPlugIn(Name, Format: String);
function LoadPlugIns: Integer;
procedure FreePlugIns;

procedure SetGenericViewer(Viewer: String);
function RegisterCodexApplication(Name, EXE, DDE: String): Boolean;

procedure EditCompressionProfile(Archive, Profile: String);
procedure EditExtractionProfile(Archive, Profile: String);
procedure DeleteCompressionProfile(Archive, Profile: String);
procedure DeleteExtractionProfile(Archive, Profile: String);
procedure CreateMergedArchive(Archive, recurseFiles, normalFiles, Profile: String);
procedure CreateSingularArchives(ArchiveType, Path, Files, Profile: String);
procedure ExtractArchive(Archive, Path, Files, Profile: String);
procedure InstallArchive(Archive: String);
procedure CheckOutArchive(Archive, Path, Icons: String);
procedure ConvertArchive(Archive, newArchive: String);
procedure ViewUpdateArchive(Archive, Item: String; Prompt: Boolean);
procedure RunArchiveTool(Archive, Items, Tool: String);
procedure ScanArchive(Archive: String);

function GetArchiveToolsEx(Archive: String; Tools: StringBuilder): Integer;
function GetArchiveToolHintsEx(Archive: String; Hints: StringBuilder): Integer;
function QueryArchiveFieldLength(Archive: String; var Names, pwdNames, DateTimes, Sizes, compSizes: Integer): Integer;
procedure QueryArchiveEx(Names, pwdNames, DateTimes, Sizes, compSizes, Error: StringBuilder);
function GetCompressionProfilesEx(Archive: String; Profiles: StringBuilder): Integer;
function GetExtractionProfilesEx(Archive: String; Profiles: StringBuilder): Integer;
function GetSupportedArchivesEx(Archives: StringBuilder): Integer;
function GetCompressibleArchivesEx(Archives: StringBuilder): Integer;
function GetExtractableArchivesEx(Archives: StringBuilder): Integer;
function GetGenericViewerEx(Viewer: StringBuilder): Integer;
function GetPlugInsEx(PlugIns: StringBuilder): Integer;
function GetArchivesEx(Archives: StringBuilder): Integer;
function GetArchivesByPlugInEx(PlugIn: String; Archives: StringBuilder): Integer;
function GetArchiveFunctionsByPlugInEx(Archive, PlugIn: String; Functions: StringBuilder): Integer;


implementation

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'StartSplash')]
procedure StartSplash; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'EndSplash')]
procedure EndSplash; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'CodexAbout')]
procedure CodexAbout; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'EraseWorkingFiles')]
procedure EraseWorkingFiles; external;

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'CheckCodexAssociations')]
function CheckCodexAssociations; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'ForceCodexAssociations')]
function ForceCodexAssociations; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'EditCodexAssociations')]
procedure EditCodexAssociations; external;

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'EditPlugInBindings')]
function EditPlugInBindings: Boolean; external;

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'ShowPlugInAbout')]
procedure ShowPlugInAbout; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'BindPlugIn')]
procedure BindPlugIn; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'UnBindPlugIn')]
procedure UnBindPlugIn; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'LoadPlugIns')]
function LoadPlugIns; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'FreePlugIns')]
procedure FreePlugIns; external;

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'SetExecutionMode')]
procedure SetExecutionMode; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'SetGenericViewer')]
procedure SetGenericViewer; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'RegisterCodexApplication')]
function RegisterCodexApplication; external;

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'EditCompressionProfile')]
procedure EditCompressionProfile; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'EditExtractionProfile')]
procedure EditExtractionProfile; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'DeleteCompressionProfile')]
procedure DeleteCompressionProfile; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'DeleteExtractionProfile')]
procedure DeleteExtractionProfile; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'CreateMergedArchive')]
procedure CreateMergedArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'CreateSingularArchives')]
procedure CreateSingularArchives; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'ExtractArchive')]
procedure ExtractArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'ScanArchive')]
procedure ScanArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'InstallArchive')]
procedure InstallArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'CheckOutArchive')]
procedure CheckOutArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'ConvertArchive')]
procedure ConvertArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'ViewUpdateArchive')]
procedure ViewUpdateArchive; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'RunArchiveTool')]
procedure RunArchiveTool; external;

[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetArchiveToolsEx')]
function GetArchiveToolsEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetArchiveToolHintsEx')]
function GetArchiveToolHintsEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'QueryArchiveFieldLength')]
function QueryArchiveFieldLength; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'QueryArchiveEx')]
procedure QueryArchiveEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetCompressionProfilesEx')]
function GetCompressionProfilesEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetExtractionProfilesEx')]
function GetExtractionProfilesEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetSupportedArchivesEx')]
function GetSupportedArchivesEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetCompressibleArchivesEx')]
function GetCompressibleArchivesEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetExtractableArchivesEx')]
function GetExtractableArchivesEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetGenericViewerEx')]
function GetGenericViewerEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetPlugInsEx')]
function GetPlugInsEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetArchivesEx')]
function GetArchivesEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetArchivesByPlugInEx')]
function GetArchivesByPlugInEx; external;
[DllImport(mCodexAPI, CharSet = CharSet.Ansi, EntryPoint = 'GetArchiveFunctionsByPlugInEx')]
function GetArchiveFunctionsByPlugInEx; external;

end.
