/* ========================================================================== 
   Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      
   This source code provided for demonstrative use only. All rights reserved. 
   ========================================================================== */

#include "stdafx.h"
#include "codexapi.h"
#include <assert.h>

// Installation Functions
extern LPBINDPLUGIN   pBindPlugIns;
extern LPUNBINDPLUGIN pUnBindPlugIns;

// Plug-In Functions
extern LPFREEPLUGINS lpFreePlugIns;
extern LPGETPLUGINS  lpGetPlugIns;
extern LPSHOWPLUGINABOUT lpShowPlugInAbout;
extern LPGETARCHIVES lpGetArchives;
extern LPGETARCHIVESBYPLUGIN lpGetArchivesByPlugIn;
extern LPGETARCHIVEFUNCTIONSBYPLUGIN lpGetArchiveFunctionsByPlugIn;
extern LPLOADPLUGINS lpLoadPlugIns;

// Archive Functions
extern LPGETCOMPRESSIBLEARCHIVES lpGetCompressibleArchives;
extern LPGETEXTRACTABLEARCHIVES lpGetExtractableArchives;
extern LPGETSUPPORTEDARCHIVES lpGetSupportedArchives;
extern LPQUERYARCHIVE lpQueryArchive;
extern LPCREATEMERGEDARCHIVE lpCreateMergedArchive;
extern LPCREATESINGULARARCHIVES lpCreateSingularArchives;
extern LPEXTRACTARCHIVE lpExtractArchive;
extern LPINSTALLARCHIVE lpInstallArchive;
extern LPCHECKOUTARCHIVE lpCheckOutArchive;
extern LPCONVERTARCHIVE lpConvertArchive;
extern LPVIEWUPDATEARCHIVE lpViewUpdateArchive;
extern LPGETARCHIVETOOLS lpGetArchiveTools;
extern LPGETARCHIVETOOLHINTS lpGetArchiveToolHints;
extern LPRUNARCHIVETOOL lpRunArchiveTool;

// Archive Profile Functions
extern LPGETCOMPRESSIONPROFILES pGetCompressionProfiles;
extern LPGETEXTRACTIONPROFILES pGetExtractionProfiles;
extern LPEDITCOMPRESSIONPROFILE pEditCompressionProfile;
extern LPEDITEXTRACTIONPROFILE pEditExtractionProfile;
extern LPDELETECOMPRESSIONPROFILE pDeleteCompressionProfile;
extern LPDELETEEXTRACTIONPROFILE pDeleteExtractionProfile;

// Shell Functions
extern LPCHECKCODEXASSOCIATIONS lpCheckCodexAssociations;
extern LPFORCECODEXASSOCIATIONS lpForceCodexAssociations;
extern LPGETGENERICVIEWER lpGetGenericViewer;
extern LPSETGENERICVIEWER lpSetGenericViewer;
extern LPREGISTERCODEXAPPLICATION lpRegisterCodexApplication;
extern LPERASEWORKINGFILES lpEraseWorkingFiles;

/*------------------------------------------------------------------------------------------------

  Function:

  Description:

  Parameters:

  Returns:

------------------------------------------------------------------------------------------------*/
void LoadInstallationFunctions( HMODULE hLib )
{
	printf( "\n ***** Loading Installation Functions ... *****\n\n" );

	pBindPlugIns = (LPBINDPLUGIN) GetProcAddress( hLib, "BindPlugIn" );
	if( pBindPlugIns == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress BindPlugIns OK\n" );
	}

	pUnBindPlugIns = (LPUNBINDPLUGIN) GetProcAddress( hLib, "UnBindPlugIn" );
	if( pUnBindPlugIns == NULL )
	{
		//MessageBox(NULL,"UnBindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress UnBindPlugIns OK\n" );
	}

	return;
}

/*------------------------------------------------------------------------------------------------

  Function:

  Description:

  Parameters:

  Returns:

------------------------------------------------------------------------------------------------*/
void LoadPlugInFunctions( HMODULE hLib )
{
	printf( "\n ***** Loading Plug-In Functions ... *****\n\n" );

	lpLoadPlugIns = (LPLOADPLUGINS) GetProcAddress( hLib, "LoadPlugIns" );
    (lpLoadPlugIns == NULL) ? assert(0) : printf( "GetProcAddress LoadPlugIns OK\n" );

	lpGetPlugIns = (LPGETPLUGINS) GetProcAddress( hLib, "GetPlugIns" );
    (lpGetPlugIns == NULL) ? assert(0) : printf( "GetProcAddress GetPlugIns OK\n" );
	//LPTSTR p = lpGetPlugIns(); // to be removed
	//printf( "  lpGetPlugIns = %s\n", p ); // to be removed

	lpShowPlugInAbout = (LPSHOWPLUGINABOUT) GetProcAddress( hLib, "ShowPlugInAbout" );
    (lpShowPlugInAbout == NULL) ? assert(0) : printf( "GetProcAddress ShowPlugInAbout OK\n" );
	//lpShowPlugInAbout( "CAB Extensions" ); // to be removed

	lpGetArchives = (LPGETARCHIVES) GetProcAddress( hLib, "GetArchives" );
    (lpGetArchives == NULL) ? assert(0) : printf( "GetProcAddress GetArchives OK\n" );
	//p = lpGetArchives(); // to be removed
	//printf( "  lpGetArchives = %s\n", p ); // to be removed

	lpGetArchivesByPlugIn = (LPGETARCHIVESBYPLUGIN) GetProcAddress(hLib, "GetArchivesByPlugIn");
    (lpGetArchivesByPlugIn == NULL) ? assert(0) : printf( "GetProcAddress GetArchivesByPlugIn OK\n" );

	lpGetArchiveFunctionsByPlugIn = (LPGETARCHIVEFUNCTIONSBYPLUGIN) GetProcAddress(hLib, "GetArchiveFunctionsByPlugIn");
    (lpGetArchiveFunctionsByPlugIn == NULL) ? assert(0) : printf( "GetProcAddress GetArchiveFunctionsByPlugIn OK\n" );

	lpFreePlugIns = (LPFREEPLUGINS) GetProcAddress( hLib, "FreePlugIns" );
    (lpFreePlugIns == NULL) ? assert(0) : printf( "GetProcAddress FreePlugIns OK\n" );

    return;
}

/*------------------------------------------------------------------------------------------------

  Function:

  Description:

  Parameters:

  Returns:

------------------------------------------------------------------------------------------------*/
void LoadArchiveFunctions( HMODULE hLib )
{
	printf( "\n ***** Loading Archive Functions ... *****\n\n" );

	lpGetCompressibleArchives = (LPGETCOMPRESSIBLEARCHIVES) GetProcAddress( hLib, "GetCompressibleArchives" );
    (lpGetCompressibleArchives == NULL) ? assert(0) : printf( "GetProcAddress lpGetCompressibleArchives OK\n" );

	lpGetExtractableArchives = (LPGETEXTRACTABLEARCHIVES) GetProcAddress( hLib, "GetExtractableArchives" );
    (lpGetExtractableArchives == NULL) ? assert(0) : printf( "GetProcAddress lpGetExtractableArchives OK\n" );

	//printf( "Extractable Archives = %s\n", lpGetExtractableArchives() );

	lpGetSupportedArchives = (LPGETSUPPORTEDARCHIVES) GetProcAddress( hLib, "GetSupportedArchives" );
    (lpGetSupportedArchives == NULL) ? assert(0) : printf( "GetProcAddress lpGetSupportedArchives OK\n" );

	//printf( "Supported Archives = %s\n", lpGetSupportedArchives() );

	lpQueryArchive = (LPQUERYARCHIVE) GetProcAddress( hLib, "QueryArchive" );
    (lpQueryArchive == NULL) ? assert(0) : printf( "GetProcAddress lpQueryArchive OK\n" );

    /*
    char pItems[128], pPwdItems[128], pDateTimes[128], pSizes[128], pCompSizes[128];
	if( lstrlen(lpQueryArchive("c:\\temp\\tas.ace", pItems, pPwdItems, pDateTimes, pSizes, pCompSizes)) == 0 )
        printf( "QueryArchive OK\n" );
    else
        printf( "QueryArchive Failed\n" );
    */

	lpCreateMergedArchive = (LPCREATEMERGEDARCHIVE) GetProcAddress( hLib, "CreateMergedArchive" );
    (lpCreateMergedArchive == NULL) ? assert(0) : printf( "GetProcAddress lpCreateMergedArchive OK\n" );

	lpCreateSingularArchives = (LPCREATESINGULARARCHIVES) GetProcAddress( hLib, "CreateSingularArchives" );
    (lpCreateSingularArchives == NULL) ? assert(0) : printf( "GetProcAddress lpCreateSingularArchives OK\n" );

	lpExtractArchive = (LPEXTRACTARCHIVE) GetProcAddress( hLib, "ExtractArchive" );
    (lpExtractArchive == NULL) ? assert(0) : printf( "GetProcAddress lpExtractArchive OK\n" );

	lpInstallArchive = (LPINSTALLARCHIVE) GetProcAddress( hLib, "InstallArchive" );
    (lpInstallArchive == NULL) ? assert(0) : printf( "GetProcAddress lpInstallArchive OK\n" );

	lpCheckOutArchive = (LPCHECKOUTARCHIVE) GetProcAddress( hLib, "CheckOutArchive" );
    (lpCheckOutArchive == NULL) ? assert(0) : printf( "GetProcAddress lpCheckOutArchive OK\n" );

	lpConvertArchive = (LPCONVERTARCHIVE) GetProcAddress( hLib, "ConvertArchive" );
    (lpConvertArchive == NULL) ? assert(0) : printf( "GetProcAddress lpConvertArchive OK\n" );

	lpViewUpdateArchive = (LPVIEWUPDATEARCHIVE) GetProcAddress( hLib, "ViewUpdateArchive" );
    (lpViewUpdateArchive == NULL) ? assert(0) : printf( "GetProcAddress lpViewUpdateArchive OK\n" );

	lpGetArchiveTools = (LPGETARCHIVETOOLS) GetProcAddress( hLib, "GetArchiveTools" );
    (lpGetArchiveTools == NULL) ? assert(0) : printf( "GetProcAddress lpGetArchiveTools OK\n" );

	lpGetArchiveToolHints = (LPGETARCHIVETOOLHINTS) GetProcAddress( hLib, "GetArchiveToolHints" );
    (lpGetArchiveToolHints == NULL) ? assert(0) : printf( "GetProcAddress lpGetArchiveToolsHints OK\n" );

	lpRunArchiveTool = (LPRUNARCHIVETOOL) GetProcAddress( hLib, "RunArchiveTool" );
    (lpRunArchiveTool == NULL) ? assert(0) : printf( "GetProcAddress lpRunArchiveTools OK\n" );

	return;
}

/*------------------------------------------------------------------------------------------------

  Function:

  Description:

  Parameters:

  Returns:

------------------------------------------------------------------------------------------------*/
void LoadArchiveProfileFunctions( HMODULE hLib )
{
	printf( "\n ***** Loading Archive Profile Functions ... *****\n\n" );

	pGetCompressionProfiles = (LPGETCOMPRESSIONPROFILES) GetProcAddress( hLib, "GetCompressionProfiles" );
	( pGetCompressionProfiles == NULL ) ? assert(0) : printf( "GetProcAddress pGetCompressionProfiles OK\n" );

	pGetExtractionProfiles = (LPGETEXTRACTIONPROFILES) GetProcAddress( hLib, "GetExtractionProfiles" );
	( pGetExtractionProfiles == NULL ) ? assert(0) : printf( "GetProcAddress pGetExtractionProfiles OK\n" );

	pEditCompressionProfile = (LPEDITCOMPRESSIONPROFILE) GetProcAddress( hLib, "EditCompressionProfile" );
	( pEditCompressionProfile == NULL ) ? assert(0) : printf( "GetProcAddress pEditCompressionProfile OK\n" );

	pEditExtractionProfile = (LPEDITEXTRACTIONPROFILE) GetProcAddress( hLib, "EditExtractionProfile" );
	( pEditExtractionProfile == NULL ) ? assert(0) : printf( "GetProcAddress pEditExtractionProfile OK\n" );

	pDeleteCompressionProfile = (LPDELETECOMPRESSIONPROFILE) GetProcAddress( hLib, "DeleteCompressionProfile" );
	( pDeleteCompressionProfile == NULL ) ? assert(0) : printf( "GetProcAddress pDeleteCompressionProfile OK\n" );

	pDeleteExtractionProfile = (LPDELETEEXTRACTIONPROFILE) GetProcAddress( hLib, "DeleteExtractionProfile" );
	( pDeleteExtractionProfile == NULL ) ? assert(0) : printf( "GetProcAddress pDeleteExtractionProfile OK\n" );
}

/*------------------------------------------------------------------------------------------------

  Function:

  Description:

  Parameters:

  Returns:

------------------------------------------------------------------------------------------------*/
void LoadCommonDlgBoxFunctions( HMODULE hLib )
{
	printf( "\n ***** Loading Common DialogBox Functions ... *****\n\n" );

	LPSTARTSPLASH pStartSplash = NULL;
	pStartSplash = (LPSTARTSPLASH) GetProcAddress( hLib, "StartSplash" );
	if( pStartSplash == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress StartSplash OK\n" );
		//pStartSplash( "CodexAPI Sample App", "d:\\winnt\\system32\\calc.exe" );
	}

	//Sleep(2000);

	LPENDSPLASH pEndSplash = NULL;
	pEndSplash = (LPENDSPLASH) GetProcAddress( hLib, "EndSplash" );
	if( pEndSplash == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress EndSplash OK\n" );
		//pEndSplash();
	}

	LPCODEXABOUT pCodexAbout = NULL;
	pCodexAbout = (LPCODEXABOUT) GetProcAddress( hLib, "CodexAbout" );
	if( pCodexAbout == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress CodexAbout OK\n" );
		char szProduct[] = "CodexAPI Sample App";
		char szCopy[] = "This app is copyrighted. Violators will be shot.";
		char szDesign[] = ":-)";
		char szURL[] = "www.mimarsinan.com";
		char szVersion[] = "Version 0.01";

		//pCodexAbout( LoadIcon(NULL,IDI_APPLICATION), szProduct, szCopy, szDesign, szURL, szVersion );
	}
	// LPEDITCODEXASSOCIATIONS

	LPEDITPLUGINBINDINGS pEditPlugInBindings = NULL;
	pEditPlugInBindings = (LPEDITPLUGINBINDINGS) GetProcAddress( hLib, "EditPlugInBindings" );
	if( pEditPlugInBindings == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress EditPlugInBindings OK\n" );
	}
}

/*------------------------------------------------------------------------------------------------

  Function:

  Description:

  Parameters:

  Returns:

------------------------------------------------------------------------------------------------*/
void LoadShellFunctions( HMODULE hLib )
{
	lpCheckCodexAssociations = (LPCHECKCODEXASSOCIATIONS) GetProcAddress( hLib, "CheckCodexAssociations" );
	if( lpCheckCodexAssociations == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress lpCheckCodexAssociations OK\n" );
	}

	lpForceCodexAssociations = (LPFORCECODEXASSOCIATIONS) GetProcAddress( hLib, "ForceCodexAssociations" );
	if( lpForceCodexAssociations == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress ForceCodexAssociations OK\n" );
	}

	lpGetGenericViewer = (LPGETGENERICVIEWER) GetProcAddress( hLib, "GetGenericViewer" );
	if( lpGetGenericViewer == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress GetGenericViewer OK\n" );
	}

	lpSetGenericViewer = (LPSETGENERICVIEWER) GetProcAddress( hLib, "SetGenericViewer" );
	if( lpSetGenericViewer == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress SetGenericViewer OK\n" );
	}

	lpRegisterCodexApplication = (LPREGISTERCODEXAPPLICATION) GetProcAddress( hLib, "RegisterCodexApplication" );
	if( lpRegisterCodexApplication == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress RegisterCodexApplication OK\n" );
	}

    lpEraseWorkingFiles = (LPERASEWORKINGFILES) GetProcAddress( hLib, "EraseWorkingFiles" );
	if( lpEraseWorkingFiles == NULL )
	{
		//MessageBox(NULL,"BindPlugIn","Info",MB_ICONSTOP|MB_OK);
		printf( "error\n" );
	}
	else
	{
		printf( "GetProcAddress EraseWorkingFiles OK\n" );
	}
}
