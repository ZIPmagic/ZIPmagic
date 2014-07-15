// $Id: common.h,v 1.11 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_common_h_included
#define stream_common_h_included

#include "un/stdint.h"

/* This header contains type and constant defintions for classes of the
<code>stream</code> name*space.

@author serge@aladdinsys.com
@version $Revision: 1.11 $, $Date: 2001/03/14 21:15:16 $
*/

namespace stream {
    /** Stream size type for read, write, and position operations. */
    typedef uint64_t size;

    /** Unknown size indicator used by some <code>stream::</code> classes. */
    const stream::size unknown_size = static_cast<stream::size>(-1);

    /** End of stream indicator used by some <code>stream::</code> classes. */
    const size_t end = static_cast<size_t>(-1);

    /** End of file character used by <code>stream::</code> classes. */
    const int eof = -1;
}

#endif

