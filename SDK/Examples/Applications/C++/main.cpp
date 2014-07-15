/* ========================================================================== 
   Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      
   This source code provided for demonstrative use only. All rights reserved. 
   ========================================================================== */

/*
    Modification History:

    06/06/02 - KT:
    - Start to change some DLL function pointers to global
    - Moved all dynamic loading code to loadDLLFunc.cpp
    - AppInit, AppCleanup, ArchiveCreation created.

    06/22/02 - KT:
	- strncpy is now used to copy all returned strings from the API calls
	  to avoid potential destination buffer overrun.
	- Added utility function IsExtraction to test if a file is extractable
	- ArchiveExtraction, ArchiveTools, ArchiveConversion completed.
*/

#include "stdafx.h"
#include "codexapi.h"
#include <assert.h>
#include <string.h>

void LoadPlugInFunctions( HMODULE );
void LoadInstallationFunctions( HMODULE );
void LoadArchiveFunctions( HMODULE );
void LoadArchiveProfileFunctions( HMODULE );
void LoadCommonDlgBoxFunctions( HMODULE );
void LoadShellFunctions( HMODULE );

static void PrintMenu( void );
static void AppInit( HMODULE hLib );
static void ArchiveCreation( void );
static void ArchiveExtraction( void );
static void ArchiveTools( void );
static void ArchiveConversion( void );
static void AppCleanup( void );

// Installation Functions
LPBINDPLUGIN   pBindPlugIns;
LPUNBINDPLUGIN pUnBindPlugIns;

// Plug-In Functions
LPFREEPLUGINS lpFreePlugIns;
LPGETPLUGINS  lpGetPlugIns;
LPSHOWPLUGINABOUT lpShowPlugInAbout;
LPGETARCHIVES lpGetArchives;
LPGETARCHIVESBYPLUGIN lpGetArchivesByPlugIn;
LPGETARCHIVEFUNCTIONSBYPLUGIN lpGetArchiveFunctionsByPlugIn;
LPLOADPLUGINS lpLoadPlugIns;

// Archive Functions
LPGETCOMPRESSIBLEARCHIVES lpGetCompressibleArchives;
LPGETEXTRACTABLEARCHIVES lpGetExtractableArchives;
LPGETSUPPORTEDARCHIVES lpGetSupportedArchives;
LPQUERYARCHIVE lpQueryArchive;
LPCREATEMERGEDARCHIVE lpCreateMergedArchive;
LPCREATESINGULARARCHIVES lpCreateSingularArchives;
LPEXTRACTARCHIVE lpExtractArchive;
LPINSTALLARCHIVE lpInstallArchive;
LPCHECKOUTARCHIVE lpCheckOutArchive;
LPCONVERTARCHIVE lpConvertArchive;
LPVIEWUPDATEARCHIVE lpViewUpdateArchive;
LPGETARCHIVETOOLS lpGetArchiveTools;
LPGETARCHIVETOOLHINTS lpGetArchiveToolHints;
LPRUNARCHIVETOOL lpRunArchiveTool;

// Archive Profile Functions
LPGETCOMPRESSIONPROFILES pGetCompressionProfiles;
LPGETEXTRACTIONPROFILES pGetExtractionProfiles;
LPEDITCOMPRESSIONPROFILE pEditCompressionProfile;
LPEDITEXTRACTIONPROFILE pEditExtractionProfile;
LPDELETECOMPRESSIONPROFILE pDeleteCompressionProfile;
LPDELETEEXTRACTIONPROFILE pDeleteExtractionProfile;

// Shell Functions
LPCHECKCODEXASSOCIATIONS lpCheckCodexAssociations;
LPFORCECODEXASSOCIATIONS lpForceCodexAssociations;
LPGETGENERICVIEWER lpGetGenericViewer;
LPSETGENERICVIEWER lpSetGenericViewer;
LPREGISTERCODEXAPPLICATION lpRegisterCodexApplication;
LPERASEWORKINGFILES lpEraseWorkingFiles;

int main()
{
	DWORD err = 0;

	HMODULE hLib = LoadLibrary( "mCodexAPI.dll" );
	if( hLib == NULL )
	{
		err = GetLastError();
		return 0;
	}

    AppInit( hLib );

    while(1)
    {
        int opt=-1;

        PrintMenu();
        fflush(0);
        scanf( "%d", &opt );

        switch( opt )
        {
        case 0:
            ArchiveCreation();
            break;
        case 1:
            // Archive Extraction
            ArchiveExtraction();
            break;
        case 2:
            // ArchiveTools
            ArchiveTools();
            break;
        case 3:
            // ArchiveConvesion
            ArchiveConversion();
            break;
        case 4:
            // ArchiveBrowsing
            printf( "\nTo be implemented\n" );
            break;
        case 5:
            // ArchiveProfileEdit
            printf( "\nTo be implemented\n" );
            break;
        case 6:
            // PlugInFeatureInfo
            printf( "\nTo be implemented\n" );
            break;
        case 7:
            // GUIStuff
            printf( "\nTo be implemented\n" );
            break;
        case 8:
            // LowLevelPluginAndArchiveTypeAssociation
            printf( "\nTo be implemented\n" );
            break;
        case 9:
            // ArchiveTypeAndCodexAppAssociation
            printf( "\nTo be implemented\n" );
            break;
        case 10:
            // AssignAllArchivesToCodex
            printf( "\nTo be implemented\n" );
            break;
        case 11:
            goto Bye;
        default:
            break;
        }
    }

Bye:
    AppCleanup();
	FreeLibrary( hLib );
    return 0;
}


static void AppInit( HMODULE hLib )
{
    printf( "\n ***** Application Initialization ... *****\n\n" );

    LoadPlugInFunctions( hLib );
    lpLoadPlugIns();

    LoadShellFunctions( hLib );
	LoadInstallationFunctions( hLib );
	LoadArchiveFunctions( hLib );
	LoadArchiveProfileFunctions( hLib );
	LoadCommonDlgBoxFunctions( hLib );
}

static void AppCleanup( void )
{
    //printf( "\n ***** Application Cleanup ... *****\n\n" );
	assert( lpEraseWorkingFiles != NULL );
	lpEraseWorkingFiles();

	assert( lpFreePlugIns != NULL );
	lpFreePlugIns();
}

static void ArchiveCreation( void )
{
    printf( "\nArchive Creation Sample ...\n\n" );

    int i, nChoice;
    char szSep[]=",";
    char szCompressible[512], *pToken=NULL;
    char szArchiveTypes[25][10];

    /*
        GetCompressibleArchives
        NOTE: Documentation does not say what return value is if function fails
        NOTE: Since we dont know the size of the string being returned, strncpy has
			to be used to avoid potential buffer overrun.
    */
    strncpy( szCompressible, lpGetCompressibleArchives(), sizeof(szCompressible) );

    pToken = strtok( szCompressible, szSep );
    for( i=0; pToken != NULL && i<25; i++ )
    {
        printf( "%d. %s\n", i, pToken );
        strcpy( szArchiveTypes[i], pToken );
        pToken = strtok( NULL, szSep );
    }
    printf( "\nSelect an archive type to create: " );
    scanf( "%d", &nChoice );
    printf( "You selected %s\n", szArchiveTypes[nChoice] );

    if( !stricmp(szArchiveTypes[nChoice], "bzip2") || !stricmp(szArchiveTypes[nChoice], "gzip") )
    {
        char szFiles[MAX_PATH+1]="";

        printf( "Calling CreateSingularArchives ...\n" );
        printf( "Enter full path of file (one file only, for now) to compress:" );
        scanf( "%s", &szFiles );
        /*
            CreateSingularArchive 
            NOTE: This function does not return any values => no way of knowing fail or success
        */
        lpCreateSingularArchives( szArchiveTypes[nChoice], NULL, szFiles, "Default" );
    }
    else
    {
        char szArchive[MAX_PATH+1]="", szNormal[MAX_PATH+1]="", szRecurse[MAX_PATH+1]="";

        printf( "Calling CreateMergedArchive ...\n" );

        printf( "Enter full path of archive to created:" );
        scanf( "%s", &szArchive );
        //printf( "Enter full path of file to normally compress:" );
        //scanf( "%s", &szNormal );
        printf( "Enter full path of file to recursively compress:" );
        scanf( "%s", &szRecurse );
        /*
            CreateMergedArchive 
            NOTE: This function does not return any values => no way of knowing fail or success
        */
        lpCreateMergedArchive( szArchive, NULL/*szNormal*/, szRecurse, "Default" );
    }
}

static void ArchiveExtraction( void )
{
    printf( "\nArchive Creation Sample ...\n\n" );

    char szArchive[MAX_PATH+1];//, szExt[MAX_PATH+1];*/

    printf( "Enter full path of archive to extract: " );
    scanf( "%s", szArchive );

	if( !IsExtractable(szArchive) )
		return;

	int choice;
	printf( "1. Extract\n2. Install\n3. Checkout\n4. View Update\n" );
	printf( "What would you like to do? : " );
	scanf( "%d", &choice );

	switch( choice )
	{
	case 1:
		{
			char szDest[MAX_PATH+1];
			printf( "Enter destination path: " );
			scanf( "%s", szDest );
			/*
				NOTE: API doc for ExtractArchive does not say how one should find
					the list of files in any given archive. Should add reference to QueryArchive
				NOTE: It would be nice if the function will interpret NULL (3rd parm)
					as extract all files
			*/
     		lpExtractArchive( szArchive, szDest, NULL, "Default" );
		}
		break;
	
	case 2:
		{
			lpInstallArchive( szArchive );
		}
		break;

	case 3:
		{
			char szDest[MAX_PATH+1];
			printf( "Enter output path: " );
			scanf( "%s", szDest );
			lpCheckOutArchive( szArchive, szDest, ".exe,.hlp,.chm" );
		}
		break;

	case 4:
		{
			char szFile[MAX_PATH+1];
			printf( "Enter filename to view: " );
			scanf( "%s", szFile );
			lpViewUpdateArchive( szArchive, szFile, TRUE );
		}
		break;

	default:
		break;
	}
	return;
}

static void ArchiveTools( void )
{
    printf( "\nArchive Tools Sample ...\n\n" );

	static const char szSep[]=",";
    char szArchive[MAX_PATH+1];//, szExt[MAX_PATH+1];

    printf( "Enter full path of archive: " );
    scanf( "%s", szArchive );

	if( !IsExtractable(szArchive) )
		return;

	int i, choice=-1;
	char szLongBuff[1024], *pToken=NULL;
	char szTools[80][80];

	strncpy( szLongBuff, lpGetArchiveTools(szArchive), sizeof(szLongBuff) );
		
	pToken = strtok( szLongBuff, szSep );
	for( i=0; pToken != NULL && i<80; i++ )
	{
		printf( "%d. %s\n", i, pToken );
		strncpy( szTools[i], pToken, sizeof(szTools[i]) );
		pToken = strtok( NULL, szSep );
	}

	printf( "\nSelect tool to run: " );
	scanf( "%d", &choice );

	/*
		NOTE: No mention in API doc what exactly needs to be passed to
			RunArchiveTool for each archive type?

		An error message appears after "Test file" is used on a ZIP file

		Not clear from the API doc what to do here....
	*/
	if( choice != -1 )
		lpRunArchiveTool( szArchive, NULL, szTools[choice] );

	return;
}

static void ArchiveConversion( void )
{
	char szTarget[MAX_PATH+1], szSource[MAX_PATH+1];

	printf( "Enter full filename of source file: " );
	scanf( "%s", szSource );

	/* Source archive must be supported for decompression */
	if( !IsExtractable(szSource) )
		return;

	printf( "Enter full filename of target file: " );
	scanf( "%s", szTarget );

	/*
		NOTE: Anyway to test for validity of specified szTarget ??
			Currently, passing an unsupported target type such as
			"xxx.lhf" will cause an access violation in
			GetCompressionProfiles -> Totally Unacceptable !!
	*/

	char szCompProf[512], szExtrProf[512];
	strncpy( szCompProf, pGetCompressionProfiles(szTarget), sizeof(szCompProf) );
	strncpy( szExtrProf, pGetExtractionProfiles(szSource), sizeof(szExtrProf) );

	const char sz[]="Structured";
	if( strstr(szCompProf,sz) == NULL )
	{
		printf( "No Structured compression profile for target file\n" );
		return;
	}

	if( strstr(szExtrProf,sz) == NULL )
	{
		printf( "No Structured extraction profile for source file\n" );
		return;
	}

	lpConvertArchive( szSource, szTarget );
	return;
}

static void PrintMenu( void )
{
    printf( "\n\n" );
    printf( "Codex API Sample Menu\n\n" );
    printf( "0. Archive Creation\n" );
    printf( "1. Archive Extraction\n" );
    printf( "2. Archive Tools\n" );
    printf( "3. Archive Conversion\n" );
    printf( "4. Archive Browsing\n" );
    printf( "5. Archive Profile Edit\n" );
    printf( "6. Plug-In Feature Info\n" );
    printf( "7. GUI Stuff\n" );
    printf( "8. Low-level Plugin and Archive Type Association\n" );
    printf( "9. Archive Type and Codex App Association\n" );
    printf( "10. Assign All Archives To Codex\n" );
    printf( "11. Quit\n\n" );
    printf( "->" );
}