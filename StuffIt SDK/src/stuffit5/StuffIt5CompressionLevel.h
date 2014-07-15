// $Id: StuffIt5CompressionLevel.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_StuffIt5CompressionLevel_h_included
#define stuffit5_StuffIt5CompressionLevel_h_included

#if defined __cplusplus

#include "stuffit5/CompressionLevel.h"

/** StuffIt5 format compression level.

<p>Describes compression level (method) options of the StuffIt5 format.

<p>StuffIt5 writer has three compression levels: no compression, Deluxe
compression (as in StuffIt Deluxe 3.0-4.0, the application), and Arsenic
compression (used in StuffIt Deluxe 5.0).

<p>Choose no compression to simply copy the files into the archive. Choose
Deluxe compression level to compress the data, creating compressed archives.
Choose Arsenic compression level to compress the data more efficiently (and more
slowly), creating the smallest archvies.

<p>StuffIt Engine's default compression level for StuffIt5 format is Arsenic
compression.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace StuffIt5CompressionLevel {
        /** Minimum StuffIt5 compression level. No compression. Provides the
        lowest compression ratio and the fastest archive creation. */
        const stuffit5::CompressionLevel::type minimum = 0;

        /** StuffIt5 no-compression level. No compression, files are copied into the archive. */
        static stuffit5::CompressionLevel::type none = 0;

        /** StuffIt5 Deluxe 3.0-4.0 compression level. StuffIt Deluxe compression. */
        static stuffit5::CompressionLevel::type deluxe = 13;

        /** StuffIt5 Deluxe 5.0 compression level. Maximum compression. */
        static stuffit5::CompressionLevel::type arsenic = 15;

        /** Maximum compression level. Arsenic compression is used. */
        static stuffit5::CompressionLevel::type maximum = 15;
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::StuffIt5CompressionLevel::minimum</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffIt5CompressionLevel_minimum = 0;
/** C equivalent of <code>stuffit5::StuffIt5CompressionLevel::none</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffIt5CompressionLevel_none = 0;
/** C equivalent of <code>stuffit5::StuffIt5CompressionLevel::deluxe</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffIt5CompressionLevel_deluxe = 13;
/** C equivalent of <code>stuffit5::StuffIt5CompressionLevel::arsenic</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffIt5CompressionLevel_arsenic = 15;
/** C equivalent of <code>stuffit5::StuffIt5CompressionLevel::maximum</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffIt5CompressionLevel_maximum = 15;

#endif // __cplusplus

#endif

