// $Id: stdint.h,v 1.7.2.1 2001/07/06 04:26:54 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_stdint_h_included
#define un_stdint_h_included

#include <limits.h>
#include "un/config.h"

/* Fixed-size integer types.

<p>These types are defined via <code>typedef</code>s to standard C integer types
or compiler-dependent types.

@author serge@aladdinsys.com
@version $Revision: 1.7.2.1 $, $Date: 2001/07/06 04:26:54 $
*/

#if compiler_msvc || compiler_gcc
    #if compiler_gcc
        // skip interfering typedefs in sys/types.h
        #define __int8_t_defined
    #endif

    #if platform_solaris
         typedef char int8_t; // 8-bit signed integer type
    #else
         typedef signed char int8_t; // 8-bit signed integer type
    #endif

    typedef unsigned char uint8_t; // 8-bit unsigned integer type
    typedef signed short int16_t; // 16-bit signed integer type
    typedef unsigned short uint16_t; // 16-bit unsigned integer type
    typedef signed int int32_t; // 32-bit signed integer type
    typedef unsigned int uint32_t; // 32-bit unsigned integer type

    #if compiler_msvc
        typedef signed __int64 int64_t; // 64-bit signed integer type
        typedef unsigned __int64 uint64_t; // 64-bit unsigned integer type
    #else
        typedef signed long long int64_t;
        typedef unsigned long long uint64_t;
    #endif

    typedef int64_t intmax_t; // the largest signed integer type
    typedef uint64_t uintmax_t; // the largest unsigned integer type

    #if platform_solaris
        typedef signed int intptr_t; // signed integer type capable of holding any pointer
        typedef unsigned int uintptr_t; // unsigned integer type capable of holding any pointer
    #else
        typedef signed long intptr_t;
        typedef unsigned long uintptr_t;
    #endif

    typedef signed int intfast_t; // the most efficient signed integer type, at least 16 bits long
    typedef unsigned int uintfast_t; // the most efficient unsigned integer type, at least 16 bits long

    typedef unsigned char uchar_t; // unsigned character type
#elif compiler_mw
    #include <stdint.h>

    typedef signed int intfast_t;
    typedef unsigned int uintfast_t;

    typedef unsigned char uchar_t;
#else
    #error Unknown compiler
#endif

#if defined __cplusplus || !compiler_mw
    #define INT8_MIN (-128)
    #define INT16_MIN (-32767-1)
    #define INT32_MIN (-2147483647-1)

    #define INT8_MAX (127)
    #define INT16_MAX (32767)
    #define INT32_MAX (2147483647)

    #define UINT8_MAX (255U)
    #define UINT16_MAX (65535U)
    #define UINT32_MAX (4294967295U)

    #if !platform_solaris
//        #define INT64_MIN (-9223372036854775807LL-1)
//        #define INT64_MAX (9223372036854775807LL)
//        #define UINT64_MAX (18446744073709551615ULL)
//    #else
        #define INT64_MIN (-9223372036854775807-1)
        #define INT64_MAX (9223372036854775807)
        #define UINT64_MAX (18446744073709551615U)
    #endif

    #define INTMAX_MIN INT64_MIN
    #define INTMAX_MAX INT64_MAX
    #define UINTMAX_MAX UINT64_MAX
#endif

#define INTFAST_MIN INT32_MIN
#define INTFAST_MAX INT32_MAX
#define UINTFAST_MAX UINT32_MAX

#if defined __cplusplus
    #include <cstddef>
    #if compiler_msvc || compiler_gcc
        // bring ptrdiff_t, size_t into the std:: namespace
        namespace std {
            typedef ::ptrdiff_t ptrdiff_t;
            typedef ::size_t size_t;
        }
    #elif compiler_mw
        // bring std::ptrdiff_t, std::size_t into the global namespace
        using std::ptrdiff_t;
        using std::size_t;
    #endif
#else
    #include <stddef.h>
#endif

#endif

