{ ========================================================================== }
{ Copyright(c) 1992-2003 MimarSinan International. All rights reserved.      }
{ This source code provided for demonstrative use only. All rights reserved. }
{ ========================================================================== }

unit uCodex;

interface

uses
  Windows;

const
  mCodexAPI = 'mCodexAPI.dll';

procedure StartSplash(Title, Icon: PChar); stdcall;
procedure EndSplash; stdcall;
procedure CodexAbout(Icon: HIcon; Product, Copyright, Design, DesignURL, Version: PChar); stdcall;
procedure EraseWorkingFiles; stdcall;

function CheckCodexAssociations: Boolean; stdcall;
procedure EditCodexAssociations; stdcall;
function ForceCodexAssociations: Short; stdcall;
function EditPlugInBindings: Boolean; stdcall;

function GetPlugIns: PChar; stdcall; deprecated;
function GetArchives: PChar; stdcall; deprecated;
procedure ShowPlugInAbout(PlugIn: PChar); stdcall;
function GetArchivesByPlugIn(PlugIn: PChar): PChar; stdcall; deprecated;
function GetArchiveFunctionsByPlugIn(Archive, PlugIn: PChar): PChar; stdcall; deprecated;
procedure BindPlugIn(Name, Format: PChar); stdcall;
procedure UnBindPlugIn(Name, Format: PChar); stdcall;
function LoadPlugIns: Integer; stdcall;
procedure FreePlugIns; stdcall;

function GetGenericViewer: PChar; stdcall; deprecated;
procedure SetGenericViewer(Viewer: PChar); stdcall;
function RegisterCodexApplication(Name, EXE, DDE: PChar): Boolean; stdcall;

function GetCompressibleArchives: PChar; stdcall; deprecated;
function GetExtractableArchives: PChar; stdcall; deprecated;
function GetSupportedArchives: PChar; stdcall; deprecated;
procedure EditCompressionProfile(Archive, Profile: PChar); stdcall;
procedure EditExtractionProfile(Archive, Profile: PChar); stdcall;
function GetCompressionProfiles(Archive: PChar): PChar; stdcall; deprecated;
function GetExtractionProfiles(Archive: PChar): PChar; stdcall; deprecated;
procedure DeleteCompressionProfile(Archive, Profile: PChar); stdcall;
procedure DeleteExtractionProfile(Archive, Profile: PChar); stdcall;
function QueryArchive(Archive: PChar; var Names, pwdNames, DateTimes, Sizes, compSizes: PChar): PChar; stdcall; deprecated;
procedure CreateMergedArchive(Archive, recurseFiles, normalFiles, Profile: PChar); stdcall;
procedure CreateSingularArchives(ArchiveType, Path, Files, Profile: PChar); stdcall;
procedure ExtractArchive(Archive, Path, Files, Profile: PChar); stdcall;
procedure InstallArchive(Archive: PChar); stdcall;
procedure CheckOutArchive(Archive, Path, Icons: PChar); stdcall;
procedure ConvertArchive(Archive, newArchive: PChar); stdcall;
procedure ViewUpdateArchive(Archive, Item: PChar; Prompt: Boolean); stdcall;
function GetArchiveTools(Archive: PChar): PChar; stdcall; deprecated;
function GetArchiveToolHints(Archive: PChar): PChar; stdcall; deprecated;
procedure RunArchiveTool(Archive, Items, Tool: PChar); stdcall;
procedure ScanArchive(Archive: PChar); stdcall;

function GetArchiveToolsEx(Archive, Tools: PChar): Integer; stdcall;
function GetArchiveToolHintsEx(Archive, Hints: PChar): Integer; stdcall;
function QueryArchiveFieldLength(Archive: PChar; var Names, pwdNames, DateTimes, Sizes, compSizes: Integer): Integer; stdcall;
procedure QueryArchiveEx(Names, pwdNames, DateTimes, Sizes, compSizes, Error: PChar); stdcall;
function GetCompressionProfilesEx(Archive, Profiles: PChar): Integer; stdcall;
function GetExtractionProfilesEx(Archive, Profiles: PChar): Integer; stdcall;
function GetSupportedArchivesEx(Archives: PChar): Integer; stdcall;
function GetCompressibleArchivesEx(Archives: PChar): Integer; stdcall;
function GetExtractableArchivesEx(Archives: PChar): Integer; stdcall;
function GetGenericViewerEx(Viewer: PChar): Integer; stdcall;
function GetPlugInsEx(PlugIns: PChar): Integer; stdcall;
function GetArchivesEx(Archives: PChar): Integer; stdcall;
function GetArchivesByPlugInEx(PlugIn, Archives: PChar): Integer; stdcall;
function GetArchiveFunctionsByPlugInEx(Archive, PlugIn, Functions: PChar): Integer; stdcall;


implementation

procedure StartSplash(Title, Icon: PChar); external mCodexAPI name 'StartSplash';
procedure EndSplash; external mCodexAPI name 'EndSplash';
procedure CodexAbout; external mCodexAPI name 'CodexAbout';
procedure EraseWorkingFiles; external mCodexAPI name 'EraseWorkingFiles';

function CheckCodexAssociations: Boolean; external mCodexAPI name 'CheckCodexAssociations';
function ForceCodexAssociations: Short; external mCodexAPI name 'ForceCodexAssociations';
procedure EditCodexAssociations; external mCodexAPI name 'EditCodexAssociations';

function EditPlugInBindings: Boolean; external mCodexAPI name 'EditPlugInBindings';

function GetPlugIns: PChar; external mCodexAPI name 'GetPlugIns';
function GetArchives: PChar; external mCodexAPI name 'GetArchives';
procedure ShowPlugInAbout(PlugIn: PChar); external mCodexAPI name 'ShowPlugInAbout';
function GetArchivesByPlugIn(PlugIn: PChar): PChar; external mCodexAPI name 'GetArchivesByPlugIn';
function GetArchiveFunctionsByPlugIn(Archive, PlugIn: PChar): PChar; external mCodexAPI name 'GetArchiveFunctionsByPlugIn';
procedure BindPlugIn(Name, Format: PChar); external mCodexAPI name 'BindPlugIn';
procedure UnBindPlugIn(Name, Format: PChar); external mCodexAPI name 'UnBindPlugIn';
function LoadPlugIns: Integer; external mCodexAPI name 'LoadPlugIns';
procedure FreePlugIns; external mCodexAPI name 'FreePlugIns';

procedure SetExecutionMode(Serial: Boolean); external mCodexAPI name 'SetExecutionMode';
function GetGenericViewer: PChar; external mCodexAPI name 'GetGenericViewer';
procedure SetGenericViewer(Viewer: PChar); external mCodexAPI name 'SetGenericViewer';
function RegisterCodexApplication(Name, EXE, DDE: PChar): Boolean; external mCodexAPI name 'RegisterCodexApplication';

function GetCompressibleArchives: PChar; external mCodexAPI name 'GetCompressibleArchives';
function GetExtractableArchives: PChar; external mCodexAPI name 'GetExtractableArchives';
function GetSupportedArchives: PChar; external mCodexAPI name 'GetSupportedArchives';
procedure EditCompressionProfile(Archive, Profile: PChar); external mCodexAPI name 'EditCompressionProfile';
procedure EditExtractionProfile(Archive, Profile: PChar); external mCodexAPI name 'EditExtractionProfile';
function GetCompressionProfiles(Archive: PChar): PChar; external mCodexAPI name 'GetCompressionProfiles';
function GetExtractionProfiles(Archive: PChar): PChar; external mCodexAPI name 'GetExtractionProfiles';
procedure DeleteCompressionProfile(Archive, Profile: PChar); external mCodexAPI name 'DeleteCompressionProfile';
procedure DeleteExtractionProfile(Archive, Profile: PChar); external mCodexAPI name 'DeleteExtractionProfile';
function QueryArchive(Archive: PChar; var Names, pwdNames, DateTimes, Sizes, compSizes: PChar): PChar; external mCodexAPI name 'QueryArchive';
procedure CreateMergedArchive(Archive, recurseFiles, normalFiles, Profile: PChar); external mCodexAPI name 'CreateMergedArchive';
procedure CreateSingularArchives(ArchiveType, Path, Files, Profile: PChar); external mCodexAPI name 'CreateSingularArchives';
procedure ExtractArchive(Archive, Path, Files, Profile: PChar); external mCodexAPI name 'ExtractArchive';
procedure ScanArchive(Archive: PChar); external mCodexAPI name 'ScanArchive';
procedure InstallArchive(Archive: PChar); external mCodexAPI name 'InstallArchive';
procedure CheckOutArchive(Archive, Path, Icons: PChar); external mCodexAPI name 'CheckOutArchive';
procedure ConvertArchive(Archive, newArchive: PChar); external mCodexAPI name 'ConvertArchive';
procedure ViewUpdateArchive(Archive, Item: PChar; Prompt: Boolean); external mCodexAPI name 'ViewUpdateArchive';
function GetArchiveTools(Archive: PChar): PChar; external mCodexAPI name 'GetArchiveTools';
function GetArchiveToolHints(Archive: PChar): PChar; external mCodexAPI name 'GetArchiveToolHints';
procedure RunArchiveTool(Archive, Items, Tool: PChar); external mCodexAPI name 'RunArchiveTool';

function GetArchiveToolsEx(Archive, Tools: PChar): Integer; external mCodexAPI name 'GetArchiveToolsEx';
function GetArchiveToolHintsEx(Archive, Hints: PChar): Integer; external mCodexAPI name 'GetArchiveToolHintsEx';
function QueryArchiveFieldLength(Archive: PChar; var Names, pwdNames, DateTimes, Sizes, compSizes: Integer): Integer; external mCodexAPI name 'QueryArchiveFieldLength';
procedure QueryArchiveEx(Names, pwdNames, DateTimes, Sizes, compSizes, Error: PChar); external mCodexAPI name 'QueryArchiveEx';
function GetCompressionProfilesEx(Archive, Profiles: PChar): Integer; external mCodexAPI name 'GetCompressionProfilesEx';
function GetExtractionProfilesEx(Archive, Profiles: PChar): Integer; external mCodexAPI name 'GetExtractionProfilesEx';
function GetSupportedArchivesEx(Archives: PChar): Integer; external mCodexAPI name 'GetSupportedArchivesEx';
function GetCompressibleArchivesEx(Archives: PChar): Integer; external mCodexAPI name 'GetCompressibleArchivesEx';
function GetExtractableArchivesEx(Archives: PChar): Integer; external mCodexAPI name 'GetExtractableArchivesEx';
function GetGenericViewerEx(Viewer: PChar): Integer; external mCodexAPI name 'GetGenericViewerEx';
function GetPlugInsEx(PlugIns: PChar): Integer; external mCodexAPI name 'GetPlugInsEx';
function GetArchivesEx(Archives: PChar): Integer; external mCodexAPI name 'GetArchivesEx';
function GetArchivesByPlugInEx(PlugIn, Archives: PChar): Integer; external mCodexAPI name 'GetArchivesByPlugInEx';
function GetArchiveFunctionsByPlugInEx(Archive, PlugIn, Functions: PChar): Integer; external mCodexAPI name 'GetArchiveFunctionsByPlugInEx';

end.