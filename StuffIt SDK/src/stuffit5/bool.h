// $Id: bool.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_bool_h_included
#define stuffit5_bool_h_included

#include "un/config.h"

/* A preprocessor incantation for <code>bool</code>-challenged C compilers.

<p><code>bool</code> cannot be a <code>typedef int</code> because Visual C++
represents intrinsic <code>bool</code> as one byte; having anything larger than
a byte makes <code>bool</code> return values meaningless because the compiler
does not clear the upper bytes of the register when it returns a
<code>bool</code>.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

#if !defined __cplusplus

#undef bool
#undef false
#undef true

#if compiler_msvc
    #pragma warning(disable: 4237) // "nonstandard extension used : keyword is reserved for future use"
#endif

typedef unsigned char bool;
static const bool false = 0;
static const bool true = 1;

#endif // __cplusplus

#endif

