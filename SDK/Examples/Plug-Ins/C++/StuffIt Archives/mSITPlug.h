/* ========================================================================== 
   Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      
   This source code provided for demonstrative use only. All rights reserved. 
   ========================================================================== */

extern "C" { 

	__declspec(dllexport) int WINAPI 
		GetArchiveInfo(
		const char* archive, 
		bool silent,
		char** names, 
		char** pass, 
		char** datetimes, 
		char** sizes, 
		char** compsizes); 

	__declspec(dllexport) void WINAPI 
		GetArchiveError(char** error);

	__declspec(dllexport) void WINAPI
		ShowPlugInAbout();

	__declspec(dllexport) void WINAPI
		CodexStandardFunction(
		const char* function,
		const char* param1,
		const char* param2);

	__declspec(dllexport) void WINAPI
		CodexRegisterPlugIn(
		int Window,
		int Instance,
		const char* CommandLine,
		int Show);

	__declspec(dllexport) void WINAPI
		CodexUnRegisterPlugIn(
		int Window,
		int Instance,
		const char* CommandLine,
		int Show);
	
	__declspec(dllimport) void WINAPI
		BindPlugIn(
		char* lpName,
		char* lpArchive);

}