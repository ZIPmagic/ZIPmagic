// $Id: algorithm.h,v 1.1 2001/03/06 01:49:00 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_msvc_algorithm_h_included
#define un_msvc_algorithm_h_included

/** Deal with Microsoft Visual C++'s renaming of <code>std::max</code> and <code>std::min</code>
to <code>std::_cpp_max</code> and <code>std::_cpp_min</code>. When including this header
together with <code>windows.h</code>, place <code>windows.h</code> first because it defines
<code>max</code> and <code>min</code> as preprocessor macros.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2001/03/06 01:49:00 $
*/

#if compiler_msvc
    #undef min
    #undef max
    #define min _cpp_min
    #define max _cpp_max
#endif

#endif

