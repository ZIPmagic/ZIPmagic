// $Id: StuffItCompressionLevel.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_StuffItCompressionLevel_h_included
#define stuffit5_StuffItCompressionLevel_h_included

#if defined __cplusplus

#include "stuffit5/CompressionLevel.h"

/** StuffIt format compression level.

<p>Describes compression level (method) options of the StuffIt format.

<p>StuffIt writer has two compression levels: no compression and Deluxe
compression (as in StuffIt Deluxe, the application).

<p>Choose no compression to simply copy the files into the archive. Choose
Deluxe compression level to compress the data, creating smaller archives.

<p>StuffIt Engine's default compression level for StuffIt format is Deluxe
compression.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace StuffItCompressionLevel {
        /** Minimum StuffIt compression level. No compression. Provides the
        lowest compression ratio and the fastest archive creation. */
        const stuffit5::CompressionLevel::type minimum = 0;

        /** StuffIt no-compression level. No compression, files are copied into the archive. */
        const stuffit5::CompressionLevel::type none = 0;

        /** StuffIt Deluxe compression level. Maximum compression. */
        const stuffit5::CompressionLevel::type deluxe = 13;

        /** Maximum compression level. Deluxe compression is used. */
        const stuffit5::CompressionLevel::type maximum = 13;
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::StuffItCompressionLevel::minimum</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffItCompressionLevel_minimum = 0;
/** C equivalent of <code>stuffit5::StuffItCompressionLevel::none</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffItCompressionLevel_none = 0;
/** C equivalent of <code>stuffit5::StuffItCompressionLevel::deluxe</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffItCompressionLevel_deluxe = 13;
/** C equivalent of <code>stuffit5::StuffItCompressionLevel::maximum</code>. */
const stuffit5_CompressionLevel_type stuffit5_StuffItCompressionLevel_maximum = 13;

#endif // __cplusplus

#endif

