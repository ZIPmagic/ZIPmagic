#include "stdafx.h"
#include "codexapi.h"
#include <string.h>

extern LPGETEXTRACTABLEARCHIVES lpGetExtractableArchives;

BOOL IsExtractable( LPCTSTR );

BOOL IsExtractable( LPCTSTR szArchive )
{
	if( szArchive == NULL )
		return FALSE;

	char szExt[MAX_PATH+1]="";

    strcpy( szExt, szArchive );
    strrev( szExt );
    strupr( szExt );
    if( strchr(szExt,'.') != NULL )
    {
        *( strchr(szExt,'.') ) = '\0';
        strrev( szExt );
    }
    else
    {
        printf( "Archive name does not contain valid extension\n" );
        return FALSE;
    }

	/* Make sure the specified archive is extractable */
	char szExtractable[512], *pToken=NULL, szSep[]=",";
	strncpy( szExtractable, lpGetExtractableArchives(), sizeof(szExtractable) );
	pToken = strtok( szExtractable, szSep );
	while( pToken != NULL )
	{
		if( strcmpi(szExt, pToken) == 0 )
			return TRUE;
		pToken = strtok( NULL, szSep );
	}
	printf( "Archive is not supported.\n\nExtractable archive types: %s\n", lpGetExtractableArchives() );
	return FALSE;
}
