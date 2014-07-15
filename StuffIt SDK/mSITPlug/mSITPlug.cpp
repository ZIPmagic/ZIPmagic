/*

  Problems with the current implementation:
  
	1. Compression is unable to store relative path names.

*/

#include "stdafx.h"
#include "stdlib.h"
#include "mSITPlug.h"
#include "un/warnings.h"
#include "stuffit5/Version.h"
#include <iostream>
#include <string>
#include "app/option/MacBinaryOutput.h"
#include "app/option/TextType.h"
#include "app/option/TextConversion.h"
#include "app/unstuff/BehavedReader.h"
#include "app/unstuff/ChattyReader.h"
#include "app/unstuff/QuietReader.h"
#include "un/auto_ptr.h"
#include "stuffit5/Format.h"
#include "un/config.h"
#include "MyReader.h"
#include "codexapi.h"
#include <commctrl.h>
#include <shlwapi.h>
#include "stuffit5/Writer.h"
#include "stuffit5/StuffIt5CompressionLevel.h"
#include "stuffit5/ZipCompressionLevel.h"

// Global Variables
HMODULE Shell32DLL;

unsigned long ExtractThreadID;
HWND ExtractDialogHandle;
std::list<std::string> PostExtractList;
std::list<std::string> PureExtractList;
std::list<std::string> PureExtractListFiles;
std::list<std::string> ExtractList;
char TargetDir[MAX_PATH];
bool PreservePath;
char TempPath[MAX_PATH];

unsigned long CompressThreadID;
HWND CompressDialogHandle;
char CompressFormat[MAX_PATH];
char TargetArchive[MAX_PATH];

char ModuleFile[MAX_PATH], ModuleFolder[MAX_PATH];
char *formats[] = {"ARC","ARJ","BZ","TBZ","TBZ2","GZ","TGZ","LHA","LZH","RAR","Z","SIT",
				   "ZIP","B64","MIM","HQX","PF","TAR","UU","UUE"};
char *encodeformats[] = {"SIT","ZIP","Z","HQX","B64","PF","UU","UUE"};
HANDLE PlugInModule;

char ActiveProfile[MAX_PATH];
char ActiveDirective[MAX_PATH];
char Overwrite;
int ItemCount, ItemPosition;

// Plug-In Installation Imports (Codex API)
LPBINDPLUGIN   pBindPlugIns;
LPUNBINDPLUGIN pUnBindPlugIns;

/* Utility Functions */
char* FixUpPath(char* Path)
{
	for (int i = 0; i <= strlen(Path); i++)
	{
		if (Path[i] == '/')
		{
			Path[i] = '\\';
		}
	}
	return Path;
}

char* ExtractFilePath(char* Path)
{
	char* last = strrchr(Path, '\\');
	int lastpos = last - Path;
	Path[lastpos + 1] = '\0';
	return Path;
}

char* DeWildCard(char* Path)
{
	char* last = strchr(Path, '*');
	if (last != NULL)
	{
		int lastpos = last - Path;
		Path[lastpos] = '\0';
	}
	if (Path[strlen(Path) - 1] == '\\')
	{
		Path[strlen(Path) - 1] = '\0';
	}
	return Path;
}

char* ExtractFileName(char* Path)
{ 
	char* last = strrchr(Path, '\\') + 1;
	return last;
}

char* ExtractFileNameOnly(char* Path)
{ 
	Path = ExtractFileName(Path);
	char* last = strrchr(Path, '.');
	int lastpos = last - Path;
	Path[lastpos] = '\0';
	return Path;
}

char* AssertDir(char* Path)
{
	if (Path[strlen(Path) -1] != '\\')
	{
		strcat(Path, "\\");
	}
	return Path;
}

bool IsRegistryWritable(void)
{
	HKEY Key;

	if (RegCreateKeyEx(HKEY_LOCAL_MACHINE,
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Shell Extensions\\Approved\\MSIN\\Registry",
		0,
		NULL,
		0,
		KEY_WRITE,
		NULL,
		&Key,
		NULL) == ERROR_SUCCESS)
	{
		RegCloseKey(Key);
		return TRUE;
	}
	else
	{
		return FALSE;
	}

}

// DLL entry point
BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	PlugInModule = hModule;
	
	GetModuleFileName(GetModuleHandle("mSITPlug.dll"), ModuleFile, MAX_PATH);
	strcpy(ModuleFolder, ModuleFile);
	ExtractFilePath(ModuleFolder);

	HMODULE hLib = LoadLibrary( "mCodexAPI.dll" );
	pBindPlugIns = (LPBINDPLUGIN) GetProcAddress( hLib, "BindPlugIn" );
	pUnBindPlugIns = (LPUNBINDPLUGIN) GetProcAddress( hLib, "UnBindPlugIn" );

    switch (ul_reason_for_call)
	{
		case DLL_PROCESS_ATTACH:
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
    }
    return TRUE;
}

/* Dialog Box Functions */

int CALLBACK ExtractSettingsProc(HWND hwndDlg,
							UINT uMsg,    
							WPARAM wParam,
							LPARAM lParam)
{
	int Result = 0;
	char Caption[MAX_PATH];
	char Buffer[MAX_PATH];
	FILE* fptr;

	strcpy(Caption, "Macintosh Archives Extract Settings: ");
	strcat(Caption, ExtractFileName(ActiveProfile));

	switch (uMsg)
	{
	case WM_INITDIALOG:
		Result = 1;
		SendMessage(hwndDlg, WM_SETTEXT, 0, (long)Caption);
		fptr = fopen(ActiveProfile, "r");
		if (fptr != NULL)
		{
			fgets(Buffer, MAX_PATH, fptr);
			Buffer[strlen(Buffer) - 1] = '\0';
			SetDlgItemText(hwndDlg, 101, Buffer);
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 102, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 102, BST_UNCHECKED);
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 103, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 103, BST_UNCHECKED);
			fgets(Buffer, MAX_PATH, fptr);
			Buffer[strlen(Buffer) - 1] = '\0';
			SetDlgItemText(hwndDlg, 104, Buffer);
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 105, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 105, BST_UNCHECKED);
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 106, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 106, BST_UNCHECKED);
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 107, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 107, BST_UNCHECKED);
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 108, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 108, BST_UNCHECKED);
			fclose(fptr);
		}
		else
		{
			SetDlgItemText(hwndDlg, 101, NULL);
			CheckDlgButton(hwndDlg, 102, BST_CHECKED);
			CheckDlgButton(hwndDlg, 103, BST_CHECKED);
			SetDlgItemText(hwndDlg, 104, NULL);
			CheckDlgButton(hwndDlg, 105, BST_UNCHECKED);
			CheckDlgButton(hwndDlg, 106, BST_CHECKED);
			CheckDlgButton(hwndDlg, 107, BST_UNCHECKED);
			CheckDlgButton(hwndDlg, 108, BST_UNCHECKED);
		}
		break;
	case WM_COMMAND:
		if (LOWORD(wParam) == 110 && HIWORD(wParam) == BN_CLICKED)
		{
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		if (LOWORD(wParam) == 109 && HIWORD(wParam) == BN_CLICKED)
		{
			fptr = fopen(ActiveProfile, "w");
			GetDlgItemText(hwndDlg, 101, Buffer, MAX_PATH);
			strcat(Buffer, "\n");
			fputs(Buffer, fptr);
			if (IsDlgButtonChecked(hwndDlg, 102) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			if (IsDlgButtonChecked(hwndDlg, 103) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			GetDlgItemText(hwndDlg, 104, Buffer, MAX_PATH);
			strcat(Buffer, "\n");
			fputs(Buffer, fptr);
			if (IsDlgButtonChecked(hwndDlg, 105) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			if (IsDlgButtonChecked(hwndDlg, 106) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			if (IsDlgButtonChecked(hwndDlg, 107) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			if (IsDlgButtonChecked(hwndDlg, 108) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			fclose(fptr);
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		break;
	case WM_CLOSE:
		EndDialog(hwndDlg, 0);
		break;
	}
	return Result;
}

int CALLBACK CompressSettingsProc(HWND hwndDlg,
								  UINT uMsg,    
								  WPARAM wParam,
								  LPARAM lParam)
{
	int Result = 0;
	char Caption[MAX_PATH];
	char Buffer[MAX_PATH];
	FILE* fptr;

	strcpy(Caption, "Macintosh Archives Compress Settings: ");
	strcat(Caption, ExtractFileName(ActiveProfile));

	switch (uMsg)
	{
	case WM_INITDIALOG:
		Result = 1;
		SendMessage(hwndDlg, WM_SETTEXT, 0, (long)Caption);
		SendDlgItemMessage(hwndDlg, 102, CB_ADDSTRING, 0, (long)"Arsenic (best, version 5+)");
		SendDlgItemMessage(hwndDlg, 102, CB_ADDSTRING, 0, (long)"Deluxe (good, version 3+)");
		SendDlgItemMessage(hwndDlg, 102, CB_ADDSTRING, 0, (long)"None (fastest)");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"9 (best)");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"8");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"7");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"6");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"5 (good)");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"4");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"3");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"2");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"1 (fastest)");
		SendDlgItemMessage(hwndDlg, 103, CB_ADDSTRING, 0, (long)"0 (none)");
		fptr = fopen(ActiveProfile, "r");
		if (fptr != NULL)
		{
			fgets(Buffer, MAX_PATH, fptr);
			Buffer[strlen(Buffer) - 1] = '\0';
			SetDlgItemText(hwndDlg, 101, Buffer);
			fgets(Buffer, MAX_PATH, fptr);
			switch (Buffer[0])
			{
			case 'A': 
				SendDlgItemMessage(hwndDlg, 102, CB_SETCURSEL, 0, 0);
				break;
			case 'D': 
				SendDlgItemMessage(hwndDlg, 102, CB_SETCURSEL, 1, 0);
				break;
			case 'N': 
				SendDlgItemMessage(hwndDlg, 102, CB_SETCURSEL, 2, 0);
				break;
			}
			fgets(Buffer, MAX_PATH, fptr);
			switch (Buffer[0])
			{
			case '9': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 0, 0);
				break;
			case '8': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 1, 0);
				break;
			case '7': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 2, 0);
				break;
			case '6': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 3, 0);
				break;
			case '5': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 4, 0);
				break;
			case '4': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 5, 0);
				break;
			case '3': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 6, 0);
				break;
			case '2': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 7, 0);
				break;
			case '1': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 8, 0);
				break;
			case '0': 
				SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 9, 0);
				break;
			}
			fgets(Buffer, MAX_PATH, fptr);
			if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
				CheckDlgButton(hwndDlg, 104, BST_CHECKED);
			else
				CheckDlgButton(hwndDlg, 104, BST_UNCHECKED);
			fclose(fptr);
		}
		else
		{
			CheckDlgButton(hwndDlg, 104, BST_CHECKED);
			SendDlgItemMessage(hwndDlg, 103, CB_SETCURSEL, 0, 0);
			SendDlgItemMessage(hwndDlg, 102, CB_SETCURSEL, 0, 0);
			SetDlgItemText(hwndDlg, 101, NULL);
		}
		break;
	case WM_COMMAND:
		if (LOWORD(wParam) == 106 && HIWORD(wParam) == BN_CLICKED)
		{
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		if (LOWORD(wParam) == 105 && HIWORD(wParam) == BN_CLICKED)
		{
			fptr = fopen(ActiveProfile, "w");
			GetDlgItemText(hwndDlg, 101, Buffer, MAX_PATH);
			strcat(Buffer, "\n");
			fputs(Buffer, fptr);
			GetDlgItemText(hwndDlg, 102, Buffer, MAX_PATH);
			strcat(Buffer, "\n");
			fputs(Buffer, fptr);
			GetDlgItemText(hwndDlg, 103, Buffer, MAX_PATH);
			strcat(Buffer, "\n");
			fputs(Buffer, fptr);
			if (IsDlgButtonChecked(hwndDlg, 104) == BST_CHECKED)
				fputs("TRUE\n", fptr);
			else
				fputs("FALSE\n", fptr);
			fclose(fptr);
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		break;
	case WM_CLOSE:
		EndDialog(hwndDlg, 0);
		break;
	}
	return Result;
}

int CALLBACK AboutProc(HWND hwndDlg,
					   UINT uMsg,    
					   WPARAM wParam,
					   LPARAM lParam)
{
	int Result = 0;

	switch (uMsg)
	{
	case WM_INITDIALOG:
		Result = 1;
		SetDlgItemText(hwndDlg, 101, stuffit5::Version::readable());
		break;
	case WM_COMMAND:
		if (LOWORD(wParam) == 102 && HIWORD(wParam) == BN_CLICKED)
		{
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		break;
	case WM_CLOSE:
		EndDialog(hwndDlg, 0);
		break;
	}
	return Result;
}

bool ExtractErrorEvent(stuffit5_Error_type error, stuffit5_Reader reader)
{
	char errStr[MAX_PATH];
	strcpy(errStr, "An error has occured:");
	strcat(errStr, "\n");
	strcat(errStr, stuffit5_Error_description(error));

	if (MessageBox(ExtractDialogHandle, errStr, "Continue Operation?", MB_OKCANCEL || MB_ICONEXCLAMATION) == IDCANCEL)
	{
		return false;
	}
	return true;
}

bool CompressErrorEvent(stuffit5_Error_type error, stuffit5_Writer writer)
{
	char errStr[MAX_PATH];
	strcpy(errStr, "An error has occured:");
	strcat(errStr, "\n");
	strcat(errStr, stuffit5_Error_description(error));

	if (MessageBox(CompressDialogHandle, errStr, "Continue Operation?", MB_OKCANCEL || MB_ICONEXCLAMATION) == IDCANCEL)
	{
		return false;
	}
	return true;
}

bool progressFilesBeginEvent(uint32_t size, stuffit5_Writer writer)
{
	ItemCount = size;
	SendDlgItemMessage(CompressDialogHandle, 101, PBM_SETRANGE, 0, MAKELONG(0, ItemCount));
	ItemPosition = 0;
	return true;
}


bool fileInfoEvent(uint32_t position, stuffit5_Reader reader)
{
    stuffit5_FileInfo file = stuffit5_Reader_fileInfo(reader);
	
	char temp[MAX_PATH];
	strcpy(temp, TargetDir);
	strcat(temp, stuffit5_FileInfo_getName(file));

	PureExtractListFiles.push_back(temp);
	return true;
}

bool folderInfoEvent(uint32_t position, stuffit5_Reader reader)
{
    stuffit5_FolderInfo folder = stuffit5_Reader_folderInfo(reader);
	
	char temp[MAX_PATH];
	strcpy(temp, TargetDir);
	strcat(temp, stuffit5_FolderInfo_getName(folder));

	PureExtractList.push_back(temp);

	return true;
}

bool folderDecodeBeginEvent(unsigned int position, stuffit5_Reader reader) 
{
    stuffit5_FolderInfo folder = stuffit5_Reader_folderInfo(reader);
	
	const char* temp;
	std::string buf;

	PostExtractList.push_back(stuffit5_FolderInfo_getName(folder));

	buf = *PureExtractList.begin();
	temp = buf.c_str();
	PureExtractList.pop_front();

	if (PreservePath)
	{
		stuffit5_FolderInfo_setName(temp, folder);
	}
	else
	{
		stuffit5_FolderInfo_setName(TargetDir, folder);
	}
	
	return true;
}

bool fileDecodeBeginEvent(unsigned int position, stuffit5_Reader reader) 
{
	// adapt file name to targetdir
	stuffit5_FileInfo file = stuffit5_Reader_fileInfo(reader);

	const char* temp;
	std::string buf;
	
	char FinalName[MAX_PATH];

	buf = *PureExtractListFiles.begin();
	temp = buf.c_str();
	PureExtractListFiles.pop_front();
	
	stuffit5_FileInfo_setName(temp, file);

	if (PreservePath)
	{
		strcpy(FinalName, temp);
	}
	else
	{
		char tempAdapter[MAX_PATH];
		char tempAdapted[MAX_PATH];

		strcpy(tempAdapter, TargetDir);
		strcpy(tempAdapted, stuffit5_FileInfo_getName(file));
		
		char* basicName = ExtractFileName(tempAdapted);

		strcat(tempAdapter, basicName);
		strcpy(FinalName, tempAdapter);
	}

	// determine if file is to be really extracted
	bool doExtract = false;
	std::list<std::string>::iterator i;
	char tempCmp[MAX_PATH];

    for (i = ExtractList.begin(); i != ExtractList.end(); i++)
	{
		buf = *i;
		
		strcpy(tempCmp, TargetDir);
		strcat(tempCmp, buf.c_str());

		if (_stricmp(stuffit5_FileInfo_getName(file), tempCmp) == 0)
		{
			doExtract = true;
			break;
		}
	}

	if (!doExtract)
	{
		return false;
	}
	else
	{
		stuffit5_FileInfo_setName(FinalName, file);
	}

	// proceed with extraction
	ItemPosition++;

	char shortname[MAX_PATH];
	strcpy(shortname, stuffit5_FileInfo_getName(file));
	strcpy(shortname, ExtractFileName(shortname));
	
	SendDlgItemMessage(ExtractDialogHandle, 103, WM_SETTEXT, 0, (long)shortname);
	SendDlgItemMessage(ExtractDialogHandle, 101, PBM_SETPOS, ItemPosition, 0);

	if (!PathIsDirectory(stuffit5_ArchiveInfo_getName(file)))
	{
		if (PathFileExists(stuffit5_ArchiveInfo_getName(file)))
		{
			if (Overwrite == 'R') return true;
			if (Overwrite == 'Y')
			{
				SetFileAttributes(stuffit5_ArchiveInfo_getName(file), FILE_ATTRIBUTE_NORMAL);
				DeleteFile(stuffit5_ArchiveInfo_getName(file));
				return true;
			}
			if (Overwrite == 'A')
			{
				int j = MessageBox(ExtractDialogHandle, stuffit5_ArchiveInfo_getName(file),
					"Overwrite File?", MB_YESNOCANCEL + MB_ICONEXCLAMATION);
				if (j == IDYES)
				{
					SetFileAttributes(stuffit5_ArchiveInfo_getName(file), FILE_ATTRIBUTE_NORMAL);
					DeleteFile(stuffit5_ArchiveInfo_getName(file));
					return true;
				}
				if (j == IDNO)
				{
					return false;
				}
				if (j == IDCANCEL)
				{
					SendMessage(ExtractDialogHandle, WM_CLOSE, 0, 0);
					return false;
				}
			}
			if (Overwrite == 'N') return false;
		}
	}

    return true;
}

bool fileEncodeBeginEvent(stuffit5_Writer writer) 
{
	ItemPosition++;
	stuffit5_FileInfo file = stuffit5_Writer_fileInfo(writer);

	char temp[MAX_PATH];
	strcpy(temp, stuffit5_FileInfo_getName(file));
	strcpy(temp, ExtractFileName(temp));

    SendDlgItemMessage(CompressDialogHandle, 103, WM_SETTEXT, 0, (long)temp);
	SendDlgItemMessage(CompressDialogHandle, 101, PBM_SETPOS, ItemPosition, 0);
    return true;
}

unsigned long CALLBACK ExtractThreadProc(void* lpParameter)
{
	char Buffer[MAX_PATH];

	char ArchiveFile[MAX_PATH];
	FILE* fptr;
	
	// set defaults
	PostExtractList.clear();
	PureExtractList.clear();
	PureExtractListFiles.clear();
	ExtractList.clear();
	stuffit5_Reader ExtractReader = stuffit5_Reader_new();
	stuffit5_Reader_setTextType(stuffit5::TextType::native, ExtractReader);
	stuffit5_Reader_addFileDecodeBeginListener(fileDecodeBeginEvent, ExtractReader);
	stuffit5_Reader_addFolderDecodeBeginListener(folderDecodeBeginEvent, ExtractReader);
	stuffit5_Reader_addErrorListener(ExtractErrorEvent, ExtractReader);
	stuffit5_Reader_addFolderInfoListener(folderInfoEvent, ExtractReader);
	stuffit5_Reader_addFileInfoListener(fileInfoEvent, ExtractReader);
	stuffit5_Reader_setMacBinaryOutput(stuffit5::MacBinaryOutput::automatic, ExtractReader);

	/* get decompression directives */
	fptr = fopen(ActiveDirective, "r");
	fgets(ArchiveFile, MAX_PATH, fptr);
	ArchiveFile[strlen(ArchiveFile) - 1] = '\0';
	stuffit5_Reader_open(ArchiveFile, ExtractReader);
	fgets(TargetDir, MAX_PATH, fptr);
	TargetDir[strlen(TargetDir) - 1] = '\0';
	AssertDir(TargetDir);
	ItemCount = 0;
	while (strcmp(Buffer, "$") != 0)
	{
		fgets(Buffer, MAX_PATH, fptr);
		Buffer[strlen(Buffer) - 1] = '\0';
		ExtractList.push_back(Buffer);
		ItemCount++;
	}
	fclose(fptr);

	/* get decompression profile directives */

	// set password
	fptr = fopen(ActiveProfile, "r");
	fgets(Buffer, MAX_PATH, fptr);
	Buffer[strlen(Buffer) - 1] = '\0';
	stuffit5_Reader_setPassword(Buffer, ExtractReader);
	// folder name preservation
	fgets(Buffer, MAX_PATH, fptr);
	if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
	{
		PreservePath = true;
	}
	else
	{
		PreservePath = false;
	}
	// target directory
	fgets(Buffer, MAX_PATH, fptr);
	if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
	{
		strcat(TargetDir, ExtractFileNameOnly(ArchiveFile));
		fgets(Buffer, MAX_PATH, fptr);
		Buffer[strlen(Buffer) -1] = '\0';
		strcat(TargetDir, Buffer);
		AssertDir(TargetDir);
	}
	else
	{
		fgets(Buffer, MAX_PATH, fptr);
	}
	// overwrite settings
	fgets(Buffer, MAX_PATH, fptr);
	if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
	{
		Overwrite = 'N';
	}
	fgets(Buffer, MAX_PATH, fptr);
	if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
	{
		Overwrite = 'A';
	}
	fgets(Buffer, MAX_PATH, fptr);
	if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
	{
		Overwrite = 'Y';
	}
	fgets(Buffer, MAX_PATH, fptr);
	if (strncmp(Buffer, "TRUE", strlen(Buffer) - 1) == 0)
	{
		Overwrite = 'R';
	}
	fclose(fptr);

	/* adjust ui */
	SendDlgItemMessage(ExtractDialogHandle, 101, PBM_SETRANGE, 0, MAKELONG(0, ItemCount));
	ItemPosition = 0;
	
	/* do extraction */
	CreateDirectory(TargetDir, NULL);
	
	GetTempPath(MAX_PATH, TempPath);
	AssertDir(TempPath);
	strcat(TempPath, "mCodex\\");

	stuffit5_Reader_setDestinationFolder(TempPath, ExtractReader); // prevent target folders from being auto-renamed!
	
	if (!stuffit5_Reader_decode(ExtractReader))
	{
		MessageBox(ExtractDialogHandle, stuffit5_Error_description(stuffit5_Reader_getError(ExtractReader)),
			"Fatal Error!", 0);
	}
	stuffit5_Reader_close(ExtractReader);
	stuffit5_Reader_delete(ExtractReader);
	
	/* finish! */
	SendMessage(ExtractDialogHandle, WM_CLOSE, 0, 0);

	return 0;
}

unsigned long CALLBACK CompressThreadProc(void* lpParameter)
{
	char Buffer[MAX_PATH];

	char ArchiveFile[MAX_PATH];
	FILE* fptr;

	stuffit5_Format_type ArchiveFormat;
	stuffit5_ArchiveInfo ArchiveInfo;
	
    const char** RecurseFiles;
	
	// set defaults
	stuffit5_Writer CompressWriter = stuffit5_Writer_new();
	stuffit5_Writer_setTextType(stuffit5::TextType::native, CompressWriter);
	stuffit5_Writer_addErrorListener(CompressErrorEvent, CompressWriter);
	stuffit5_Writer_addFileEncodeBeginListener(fileEncodeBeginEvent, CompressWriter);
	stuffit5_Writer_addProgressFilesBeginListener(progressFilesBeginEvent, CompressWriter);
	ArchiveInfo = stuffit5_Writer_archiveInfo(CompressWriter);
	ArchiveFormat = stuffit5_Format_sit5; // please VC++

	// set chosen compression format
	if (strcmp("SIT", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_sit5;
	}
	if (strcmp("ZIP", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_zip;
	}
	if (strcmp("Z", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_compress;
	}
	if (strcmp("HQX", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_hqx;
	}
	if (strcmp("B64", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_bin;
	}
	if (strcmp("PF", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_pf;
	}
	if (strcmp("UU", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_uu;
	}
	if (strcmp("UUE", CompressFormat) == 0)
	{
		ArchiveFormat = stuffit5_Format_uu;
	}
	stuffit5_ArchiveInfo_setFormat(ArchiveFormat, ArchiveInfo);

	/* get compression directives */

	fptr = fopen(ActiveDirective, "r");
	fgets(ArchiveFile, MAX_PATH, fptr);
	ArchiveFile[strlen(ArchiveFile) - 1] = '\0';
	if (strstr(_strlwr(ArchiveFile), _strlwr(CompressFormat)) == NULL)
	{
		strcat(ArchiveFile, ".");
		strcat(ArchiveFile, _strlwr((CompressFormat)));
	}
	strcpy(TargetArchive, ArchiveFile);
	stuffit5_ArchiveInfo_setName(ArchiveFile, ArchiveInfo);
	ItemCount = 0;
	char* Temp;
	RecurseFiles = (const char**)malloc(MAX_PATH * MAX_PATH);
	fgets(Buffer, MAX_PATH, fptr);
	Buffer[strlen(Buffer) - 1] = '\0';
	while (strcmp(Buffer, "$") != 0)
	{
		DeWildCard(Buffer);
		Temp = (char*)malloc(strlen(Buffer) + 1);
		strcpy(Temp, Buffer);
		RecurseFiles[ItemCount] = Temp;
		ItemCount++;
		fgets(Buffer, MAX_PATH, fptr);
		Buffer[strlen(Buffer) - 1] = '\0';
	}
	fgets(Buffer, MAX_PATH, fptr);
	Buffer[strlen(Buffer) - 1] = '\0';
	while (strcmp(Buffer, "$") != 0)
	{
		DeWildCard(Buffer);
		Temp = (char*)malloc(strlen(Buffer) + 1);
		strcpy(Temp, Buffer);
		RecurseFiles[ItemCount] = Temp;
		ItemCount++;
		fgets(Buffer, MAX_PATH, fptr);
		Buffer[strlen(Buffer) - 1] = '\0';
	}
	RecurseFiles[ItemCount] = engineNameListEnd;
	fclose(fptr);

	/* get compression profile directives */
	fptr = fopen(ActiveProfile, "r");
	fgets(Buffer, MAX_PATH, fptr);
	Buffer[strlen(Buffer) - 1] = '\0';
	stuffit5_Writer_setPassword(Buffer, CompressWriter);
	if (strcmp("SIT", CompressFormat) == 0)
	{
		fgets(Buffer, MAX_PATH, fptr);
		Buffer[strlen(Buffer) - 1] = '\0';
		switch (Buffer[0])
		{
		case 'A': 
			stuffit5_Writer_setCompressionLevel(stuffit5_StuffIt5CompressionLevel_arsenic, CompressWriter);
			break;
		case 'D': 
			stuffit5_Writer_setCompressionLevel(stuffit5_StuffIt5CompressionLevel_deluxe, CompressWriter);
			break;
		case 'N': 
			stuffit5_Writer_setCompressionLevel(stuffit5_StuffIt5CompressionLevel_none, CompressWriter);
			break;
		}
		fgets(Buffer, MAX_PATH, fptr);
	}
	if (strcmp("ZIP", CompressFormat) == 0)
	{
		fgets(Buffer, MAX_PATH, fptr);
		fgets(Buffer, MAX_PATH, fptr);
		Buffer[strlen(Buffer) - 1] = '\0';
		switch (Buffer[0])
		{
		case '9': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_nine, CompressWriter);
			break;
		case '8': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_eight, CompressWriter);
			break;
		case '7': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_seven, CompressWriter);
			break;
		case '6': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_six, CompressWriter);
			break;
		case '5': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_five, CompressWriter);
			break;
		case '4': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_four, CompressWriter);
			break;
		case '3': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_three, CompressWriter);
			break;
		case '2': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_two, CompressWriter);
			break;
		case '1': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_one, CompressWriter);
			break;
		case '0': 
			stuffit5_Writer_setCompressionLevel(stuffit5_ZipCompressionLevel_none, CompressWriter);
			break;
		}
		stuffit5_Writer_setCompressionLevel(stuffit5_StuffIt5CompressionLevel_arsenic, CompressWriter);
	}
	fclose(fptr);

	/* adjust ui */
	SendDlgItemMessage(CompressDialogHandle, 101, PBM_SETRANGE, 0, MAKELONG(0, ItemCount));
	ItemPosition = 0;
	
	/* do extraction */
	if (stuffit5_Writer_create(RecurseFiles, CompressWriter) == false)
	{
		MessageBox(CompressDialogHandle, stuffit5_Error_description(stuffit5_Writer_getError(CompressWriter)),
			"Fatal Error!", 0);
	}
	stuffit5_Writer_delete(CompressWriter);
	free((void*)RecurseFiles);
	
	/* finish! */
	SendMessage(CompressDialogHandle, WM_CLOSE, 0, 0);
	
	return 0;
}

int CALLBACK ExtractProc(HWND hwndDlg,
						 UINT uMsg,    
						 WPARAM wParam,
						 LPARAM lParam)
{
	int Result = 0;

	switch (uMsg)
	{
	case WM_INITDIALOG:
		ExtractDialogHandle = hwndDlg;
		Animate_OpenEx(GetDlgItem(hwndDlg, 104), Shell32DLL, MAKEINTRESOURCE(161));
		CreateThread(NULL, 0, &ExtractThreadProc, NULL, 0, &ExtractThreadID);
		Result = 1;
		break;
	case WM_COMMAND:
		if (LOWORD(wParam) == 102 && HIWORD(wParam) == BN_CLICKED)
		{
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		break;
	case WM_CLOSE:
		// clean up stupid created folders, incredible SDK this Aladdin's!
		std::list<std::string>::iterator i;
		std::string buf;
		char temp[MAX_PATH];
		bool StillExists = true;
		while (StillExists)
		{
			StillExists = false;
			for (i = PostExtractList.begin(); i != PostExtractList.end(); i++)
			{
				buf = *i;
				strcpy(temp, buf.c_str());
				RemoveDirectory(temp);
				if (PathIsDirectory(temp))
				{
					StillExists = true;
				}
			}
		}
		EndDialog(hwndDlg, 0);
		break;
	}
	return Result;
}

int CALLBACK CompressProc(HWND hwndDlg,
						  UINT uMsg,
						  WPARAM wParam,
						  LPARAM lParam)
{
	int Result = 0;

	switch (uMsg)
	{
	case WM_INITDIALOG:
		CompressDialogHandle = hwndDlg;
		Animate_OpenEx(GetDlgItem(hwndDlg, 104), Shell32DLL, MAKEINTRESOURCE(161));
		CreateThread(NULL, 0, &CompressThreadProc, NULL, 0, &CompressThreadID);
		Result = 1;
		break;
	case WM_COMMAND:
		if (LOWORD(wParam) == 102 && HIWORD(wParam) == BN_CLICKED)
		{
			SendMessage(hwndDlg, WM_CLOSE, 0, 0);
		}
		break;
	case WM_CLOSE:
		EndDialog(hwndDlg, 0);
		break;
	}
	return Result;
}

/* Codex Plug-In Technology Compliant Exports */
extern "C" {

__declspec(dllexport) int WINAPI GetArchiveInfo(
												const char* archive, 
												bool silent,
												char** names, 
												char** pass, 
												char** datetimes, 
												char** sizes, 
												char** compsizes)
{
	// clear string lists
	itemCount = 0;
	Names.erase(0, Names.length());
	Pass.erase(0, Pass.length());
	DateTimes.erase(0, DateTimes.length());
	Sizes.erase(0, Sizes.length());
	CompSizes.erase(0, CompSizes.length());
    // custom reader that returns only file information while scanning
	un::auto_ptr<app::unstuff::Reader> reader(0);
	reader.reset(new app::unstuff::MyReader);
	reader->open(archive);
	reader->scan();
	// delete last "empty" items
	if (Names.length() != 0) 
	{
		Names.erase(Names.length() -1, 1);
		if (Pass.length() != 0)
		{
			Pass.erase(Pass.length() -1, 1);
		}
		DateTimes.erase(DateTimes.length() -1, 1);
		Sizes.erase(Sizes.length() -1, 1);
		CompSizes.erase(CompSizes.length() -1, 1);
	}
	// return properly formatted lists
	*names = (char*)malloc(Names.length());
	strcpy(*names, Names.c_str());
	FixUpPath(*names);
	*pass = (char*)malloc(Pass.length());
	strcpy(*pass, Pass.c_str());
	FixUpPath(*pass);
	*datetimes = (char*)malloc(DateTimes.length());
	strcpy(*datetimes, DateTimes.c_str());
	*sizes = (char*)malloc(Sizes.length());
	strcpy(*sizes, Sizes.c_str());
	*compsizes = (char*)malloc(CompSizes.length());
	strcpy(*compsizes, CompSizes.c_str());
	reader->close();
	return itemCount;
}

__declspec(dllexport) int WINAPI GetArchiveSizeEx(
												const char* archive, 
												bool silent,
												int& names, 
												int& pass, 
												int& datetimes, 
												int& sizes, 
												int& compsizes)
{
	// clear string lists
	itemCount = 0;
	Names.erase(0, Names.length());
	Pass.erase(0, Pass.length());
	DateTimes.erase(0, DateTimes.length());
	Sizes.erase(0, Sizes.length());
	CompSizes.erase(0, CompSizes.length());
    // custom reader that returns only file information while scanning
	un::auto_ptr<app::unstuff::Reader> reader(0);
	reader.reset(new app::unstuff::MyReader);
	reader->open(archive);
	reader->scan();
	// delete last "empty" items
	if (Names.length() != 0) 
	{
		Names.erase(Names.length() -1, 1);
		if (Pass.length() != 0)
		{
			Pass.erase(Pass.length() -1, 1);
		}
		DateTimes.erase(DateTimes.length() -1, 1);
		Sizes.erase(Sizes.length() -1, 1);
		CompSizes.erase(CompSizes.length() -1, 1);
	}
	// return properly formatted lists
	names = Names.length() +1;
	pass = Pass.length() +1;
	datetimes = DateTimes.length() +1;
	sizes = Sizes.length() +1;
	compsizes = CompSizes.length() +1;
	reader->close();
	return itemCount;
}

__declspec(dllexport) void WINAPI GetArchiveInfoEx(
												char* names, 
												char* pass, 
												char* datetimes, 
												char* sizes, 
												char* compsizes)
{
	// return properly formatted lists
	strcpy(names, Names.c_str());
	FixUpPath(names);
	strcpy(pass, Pass.c_str());
	FixUpPath(pass);
	strcpy(datetimes, DateTimes.c_str());
	strcpy(sizes, Sizes.c_str());
	strcpy(compsizes, CompSizes.c_str());
}

__declspec(dllexport) void WINAPI GetArchiveError(
												 char** error)
{
	*error = NULL;
}

__declspec(dllexport) int WINAPI GetArchiveErrorEx(
												 char* error)
{
	error = NULL;
	return 0;
}

__declspec(dllexport) void WINAPI ShowPlugInAbout()
{
	DialogBox((HINSTANCE__*)PlugInModule, MAKEINTRESOURCE(105), 0, &AboutProc);
}

__declspec(dllexport) void WINAPI CodexStandardFunction(
														const char* function,
														const char* param1,
														const char* param2)
{
	if (strcmp(function, "decodesetup") == 0)
	{
		strcpy(ActiveProfile, param1);
		DialogBox((HINSTANCE__*)PlugInModule, MAKEINTRESOURCE(101), 0, &ExtractSettingsProc);
	}
	else
	if (strcmp(function, "encodesetup") == 0)
	{
		strcpy(ActiveProfile, param1);
		DialogBox((HINSTANCE__*)PlugInModule, MAKEINTRESOURCE(103), 0, &CompressSettingsProc);
	}
	else
	if (strcmp(function, "decode") == 0)
	{
		Shell32DLL = GetModuleHandle("shell32.dll");
        if (Shell32DLL == NULL)
		{
			Shell32DLL = LoadLibrary("shell32.dll");
		}

		strcpy(ActiveDirective, param1);
		strcpy(ActiveProfile, param2);
		DialogBox((HINSTANCE__*)PlugInModule, MAKEINTRESOURCE(102), 0, &ExtractProc);
	}
	else
	if (strspn("encode", function) == 6)
	{
		Shell32DLL = GetModuleHandle("shell32.dll");
        if (Shell32DLL == NULL)
		{
			Shell32DLL = LoadLibrary("shell32.dll");
		}

		strcpy(ActiveDirective, param1);
		strcpy(ActiveProfile, param2);

		const char* temp = function;
		temp += 6;
		strcpy(CompressFormat, temp);
		
		DialogBox((HINSTANCE__*)PlugInModule, MAKEINTRESOURCE(104), 0, &CompressProc);
	}
}

__declspec(dllexport) void WINAPI CodexRegisterPlugIn(
													  int Window,
													  int Instance,
													  const char* CommandLine,
													  int Show)
{
	// make sure we have admin priviledges
	if (!IsRegistryWritable())
	{
		MessageBox((HWND__*)Window, "Plug-in registration failed!\n\nMimarSinan Extended Archives Plug-In\nRegistry not writable",
			"MimarSinan Codex", MB_OK | MB_ICONSTOP);
		return;
	}
	
	// master plugin key
	HKEY Key;
	RegCreateKeyEx(HKEY_LOCAL_MACHINE,
		"Software\\MimarSinan\\Codex\\2.0\\Plug-Ins\\Extended Archives",
		0,
		NULL,
		0,
		KEY_WRITE,
		NULL,
		&Key,
		NULL);
	RegCloseKey(Key);
	
	// extractable formats
	for (int i = 0; i < 20; i++)
	{
		char TempStr[MAX_PATH];
		strcpy(TempStr, "Software\\MimarSinan\\Codex\\2.0\\Plug-Ins\\Extended Archives\\*.");
		strcat(TempStr, formats[i]);
		RegCreateKeyEx(HKEY_LOCAL_MACHINE,
			TempStr,
			0,
			NULL,
			0,
			KEY_WRITE,
			NULL,
			&Key,
			NULL);
		RegSetValueEx(Key, "Folder", 0, REG_SZ, (BYTE*) ModuleFolder, strlen(ModuleFolder) +1);
		RegSetValueEx(Key, "DLL", 0, REG_SZ, (BYTE*) ModuleFile, strlen(ModuleFile) +1);
		RegCloseKey(Key);

		strcat(TempStr, "\\Verbs");
		RegCreateKeyEx(HKEY_LOCAL_MACHINE,
			TempStr,
			0,
			NULL,
			0,
			KEY_WRITE,
			NULL,
			&Key,
			NULL);
		RegSetValueEx(Key, "info", 0, REG_SZ, (BYTE*) "info", 6);
		RegSetValueEx(Key, "decode", 0, REG_SZ, (BYTE*) "decode", 7);
		RegSetValueEx(Key, "decodesetup", 0, REG_SZ, (BYTE*) "decodesetup", 12);
		RegCloseKey(Key);
	}

	// compressible formats
	for (i = 0; i < 8; i++)
	{
		char TempStr[MAX_PATH];
		strcpy(TempStr, "Software\\MimarSinan\\Codex\\2.0\\Plug-Ins\\Extended Archives\\*.");
		strcat(TempStr, encodeformats[i]);
		strcat(TempStr, "\\Verbs");
		RegCreateKeyEx(HKEY_LOCAL_MACHINE,
			TempStr,
			0,
			NULL,
			0,
			KEY_WRITE,
			NULL,
			&Key,
			NULL);

		char EncTempStr[MAX_PATH];
		strcpy(EncTempStr, "encode");
		strcat(EncTempStr, encodeformats[i]);

		char EncSetupTempStr[MAX_PATH];
		strcpy(EncSetupTempStr, "encodesetup");
		//strcat(EncSetupTempStr, encodeformats[i]);

		RegSetValueEx(Key, "encode", 0, REG_SZ, (BYTE*) EncTempStr, strlen(EncTempStr) +1);
		RegSetValueEx(Key, "encodesetup", 0, REG_SZ, (BYTE*) EncSetupTempStr, strlen(EncSetupTempStr) +1);

		
		RegCloseKey(Key);
	}

	// bind plugin to supported formats
	for (i = 0; i < 20; i++)
	{
		char TempWildCard[MAX_PATH];
		strcpy(TempWildCard, "*.");
		strcat(TempWildCard, formats[i]);
		pBindPlugIns("Extended Archives", TempWildCard);
	}

	// show success
	if (strcmp("install", CommandLine) != 0)
	{
		MessageBox((HWND__*)Window, "Plug-in registration succeeded!\nMimarSinan Extended Archives Plug-In",
			"MimarSinan Codex", MB_OK + MB_ICONINFORMATION);
	}
}

__declspec(dllexport) void WINAPI CodexUnRegisterPlugIn(
														int Window,
														int Instance,
														const char* CommandLine,
														int Show)
{
	// make sure we have admin priviledges
	if (!IsRegistryWritable())
	{
		MessageBox((HWND__*)Window, "Plug-in unregistration failed!\n\nMimarSinan Extended Plug-In\nRegistry not writable",
			"MimarSinan Codex", MB_OK | MB_ICONSTOP);
		return;
	}

	// all formats
	for (int i = 0; i < 20; i++)
	{
		char TempStr[MAX_PATH];
		strcpy(TempStr, "Software\\MimarSinan\\Codex\\2.0\\Plug-Ins\\Extended Archives\\*.");
		strcat(TempStr, formats[i]);
		strcat(TempStr, "\\Verbs");

		RegDeleteKey(HKEY_LOCAL_MACHINE, TempStr);
		ExtractFilePath(TempStr);
		RegDeleteKey(HKEY_LOCAL_MACHINE, TempStr);
	}

	RegDeleteKey(HKEY_LOCAL_MACHINE, "Software\\MimarSinan\\Codex\\2.0\\Plug-Ins\\Extended Archives");

	// unbind plugin from supported formats
	for (i = 0; i < 20; i++)
	{
		char TempWildCard[MAX_PATH];
		strcpy(TempWildCard, "*.");
		strcat(TempWildCard, formats[i]);
		pUnBindPlugIns("Extended Archives", TempWildCard);
	}

	// show success
	if (strcmp("uninstall", CommandLine) != 0)
	{
		MessageBox((HWND__*)Window, "Plug-in unregistration succeeded!\nMimarSinan Extended Archives Plug-In",
			"MimarSinan Codex", MB_OK + MB_ICONINFORMATION);
	}
}

}
