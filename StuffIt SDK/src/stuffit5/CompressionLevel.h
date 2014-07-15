// $Id: CompressionLevel.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_CompressionLevel_h_included
#define stuffit5_CompressionLevel_h_included

#if defined __cplusplus

/** Compression level (method).

<p>Several writers can use different compression methods for files being added
to the archives they create. Subclasses of
<code>stuffit5::CompressionLevel</code> determine what compression levels
(methods) are used.

<p>This class has format-specific subclasses for each format that provides a
choice of compression levels (StuffIt, StuffIt5 and Zip).

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace CompressionLevel {
        /** Underlying type. */
        typedef int type;

        /** Compression level is automatically selected. Either the default level
        is used or the selection is done automatically for each individual file. */
        const stuffit5::CompressionLevel::type automatic = -1;
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::CompressionLevel::automatic</code>. */
const stuffit5_CompressionLevel_type stuffit5_CompressionLevel_automatic = -1;

#endif // __cplusplus

#endif

