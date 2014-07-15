// $Id: config.h,v 1.7.2.1 2001/07/05 23:35:27 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_config_h_included
#define un_config_h_included

#include <assert.h>

/* Preprocessor symbols for platform, compiler, debug build, exports, etc.,
endianness tests, compile- and runtime asserts, trace macros.

@author serge@aladdinsys.com
@version $Revision: 1.7.2.1 $, $Date: 2001/07/05 23:35:27 $
*/

// Platform and compiler

#undef platform_win32
#undef platform_cygwin
#undef platform_unix
#undef platform_macintosh
#undef platform_solaris

#undef compiler_msvc
#undef compiler_gcc
#undef compiler_mw

// UNIX/Linux/Solaris/Cygwin and gcc
#if defined __GNUC__
    #define compiler_gcc 1
    #if defined linux
        #define platform_unix 1
        #define platform_linux 1
    #elif defined sun
        #define platform_unix 1
        #define platform_solaris 1
    #else
        #define platform_cygwin 1
    #endif
#endif

// Windows and Visual C++
#if defined _MSC_VER && defined WIN32
    #define platform_win32 1
    #define compiler_msvc 1
#endif

// Windows and CodeWarrior
#if defined __MWERKS__ && defined __INTEL__
    #define platform_win32 1
    #define compiler_mw 1
#endif

// MacOS and CodeWarrior
#if defined __MWERKS__ && defined macintosh
    #define platform_macintosh 1
    #define compiler_mw 1
#endif

#if (platform_win32 + platform_cygwin + platform_unix + platform_macintosh) != 1
    #error More than one or no platform defined in un/config.h
#endif

#if platform_unix
    #if (platform_linux + platform_solaris) != 1
        #error More than one or no variation of unix_platform defined in un/config.h
    #endif
#endif

#if (compiler_msvc + compiler_gcc + compiler_mw) != 1
    #error More than one or no compiler defined in un/config.h
#endif

// Debug build

#if defined DEBUG || defined _DEBUG
    #define debug_build 1
#else
    #define debug_build 0
#endif

// Shared library symbol exports in Visual C++ and CodeWarrior

#if compiler_msvc && defined _USRDLL
    #define exported __declspec(dllexport)
#else
    #define exported
#endif

#if compiler_mw
    #define export_on export on
    #define export_off export off
#else
    #define export_on
    #define export_off
#endif

// extern "C" in C++, nothing in C
#if defined __cplusplus
    #define extern_c extern "C"
#else
    #define extern_c
#endif

// Compile- (ct_) and run-time (rt_) assertions. Compile-time assertions understand
// const variables, enums, sizeof(), etc. Violations of compile-time assertions result
// in compilation errors. require and ensure approximate Eiffel pre- and postconditions.

#if defined __cplusplus
    #define ct_assert(condition) { enum { assert = 0 / (int)(condition) }; }
    #define ct_require ct_assert
    #define ct_ensure ct_assert
#endif

#define rt_assert assert
#define rt_require assert
#define rt_ensure assert

#endif

