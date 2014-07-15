{ ========================================================================== }
{ Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      }
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
procedure EraseWorkingFiles; stdcall; export;

function CheckCodexAssociations: Boolean; stdcall;
procedure EditCodexAssociations; stdcall;
function ForceCodexAssociations: Short; stdcall;
function EditPlugInBindings: Boolean; stdcall;

function GetPlugIns: PChar; stdcall;
function GetArchives: PChar; stdcall;
procedure ShowPlugInAbout(PlugIn: PChar); stdcall;
function GetArchivesByPlugIn(PlugIn: PChar): PChar; stdcall;
function GetArchiveFunctionsByPlugIn(Archive, PlugIn: PChar): PChar; stdcall;
procedure BindPlugIn(Name, Format: PChar); stdcall;
procedure UnBindPlugIn(Name, Format: PChar); stdcall;
function LoadPlugIns: Integer; stdcall;
procedure FreePlugIns; stdcall;

function GetGenericViewer: PChar; stdcall;
procedure SetGenericViewer(Viewer: PChar); stdcall;
function RegisterCodexApplication(Name, EXE, DDE: PChar): Boolean; stdcall;

function GetCompressibleArchives: PChar; stdcall;
function GetExtractableArchives: PChar; stdcall;
function GetSupportedArchives: PChar; stdcall;
procedure EditCompressionProfile(Archive, Profile: PChar); stdcall;
procedure EditExtractionProfile(Archive, Profile: PChar); stdcall;
function GetCompressionProfiles(Archive: PChar): PChar; stdcall;
function GetExtractionProfiles(Archive: PChar): PChar; stdcall;
procedure DeleteCompressionProfile(Archive, Profile: PChar); stdcall;
procedure DeleteExtractionProfile(Archive, Profile: PChar); stdcall;
function QueryArchive(Archive: PChar; var Names, pwdNames, DateTimes, Sizes, compSizes: PChar): PChar; stdcall;
procedure CreateMergedArchive(Archive, recurseFiles, normalFiles, Profile: PChar); stdcall;
procedure CreateSingularArchives(ArchiveType, Path, Files, Profile: PChar); stdcall;
procedure ExtractArchive(Archive, Path, Files, Profile: PChar); stdcall;
procedure InstallArchive(Archive: PChar); stdcall;
procedure CheckOutArchive(Archive, Path, Icons: PChar); stdcall;
procedure ConvertArchive(Archive, newArchive: PChar); stdcall;
procedure ViewUpdateArchive(Archive, Item: PChar; Prompt: Boolean); stdcall;
function GetArchiveTools(Archive: PChar): PChar; stdcall;
function GetArchiveToolHints(Archive: PChar): PChar; stdcall;
procedure RunArchiveTool(Archive, Items, Tool: PChar); stdcall;
procedure ScanArchive(Archive: PChar); stdcall;


implementation

procedure StartSplash(Title, Icon: PChar); external mCodexAPI name 'StartSplash';
procedure EndSplash; external mCodexAPI name 'EndSplash';
procedure CodexAbout; external mCodexAPI name 'CodexAbout';
procedure EraseWorkingFiles; external mCodexAPI name 'EraseWorkingFiles';

function CheckCodexAssociations: Boolean; external mCodexAPI name 'CheckCodexAssociations';
function ForceCodexAssociations; external mCodexAPI name 'ForceCodexAssociations';
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


end.
