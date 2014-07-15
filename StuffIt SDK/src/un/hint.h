// $Id: hint.h,v 1.1 2001/03/06 01:48:39 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_hint_h_included
#define un_hint_h_included

#include "un/config.h"

/* Trace macros.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2001/03/06 01:48:39 $
*/

#if debug_build
    #include <iostream>
#endif

#if debug_build
    #define hint(condition, stuff) { if (condition) std::cout << stuff << std::flush; }
    #define hint_line(condition, stuff) { if (condition) std::cout << stuff << std::endl; }
#else
    #define hint(condition, stuff)
    #define hint_line(condition, stuff)
#endif

/* 0 disables trace output, 1 or more enables it. Higher numbers mean more detail.
Do not uncomment the following defintion. Instead, define this symbol through
makefile or project options.
*/

//#define trace_level 1

#if debug_build && trace_level > 0
#define trace(level, stuff) { if (trace_level >= level) std::cout << stuff << std::flush; }
    #define trace_line(level, stuff) { if (trace_level >= level) std::cout << stuff << std::endl; }
#else
    #define trace(level, stuff)
    #define trace_line(level, stuff)
#endif

#endif

