// $Id: ZipCompressionLevel.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_ZipCompressionLevel_h_included
#define stuffit5_ZipCompressionLevel_h_included

#if defined __cplusplus

#include "stuffit5/CompressionLevel.h"

/** Zip format compression level.

<p>Describes compression level (method) options of the Zip format.

<p>Zip writer has ten different compression levels, internally numbered from
zero (minimal compression, fastest archive creation) to nine (maximum
compression, slowest archive creation). The default compression level is usually
chosen somewhere in the middle.

<p>Choose a lower compression level to create archives faster. Choose a higher
compression level to compress the data more, creating smaller archives.

<p>Zip compression levels cover a wide range of speeds, but at levels three to
nine, compression ratio differences are not as dramatic as compression speed
differences.

<p>Compression is <i>much</i> slower at compression level nine than it is at
compression level one. However, decompression speed varies minimally from level
one to level nine.

<p>When trying to find a suitable compression level, it helps to experiment on
the target machine. A good balance of compression speed vs. compression ratio is
a subjective matter. Level nine is probably painfully slow by anybody's standard
considering the extra few tenths of a percent compression ratio it achieves, but
sometimes every bit counts, and speed doesn't matter.

<p>StuffIt Engine's deafult compression level for the Zip format is six.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace ZipCompressionLevel {
        /** Minimum Zip compression level. Minimum or no compression. Provides
        the lowest compression ratio, and usually the fastest archive creation. */
        const stuffit5::CompressionLevel::type minimum = 0;

        /** Zip compression level zero. Minimum or no compression. */
        const stuffit5::CompressionLevel::type none = 0;

        /** Zip compression level one. */
        const stuffit5::CompressionLevel::type one = 1;

        /** Zip compression level two. */
        const stuffit5::CompressionLevel::type two = 2;

        /** Zip compression level three. */
        const stuffit5::CompressionLevel::type three = 3;

        /** Zip compression level four. */
        const stuffit5::CompressionLevel::type four = 4;

        /** Zip compression level five. */
        const stuffit5::CompressionLevel::type five = 5;

        /** Zip compression level six. */
        const stuffit5::CompressionLevel::type six = 6;

        /** Zip compression level seven. */
        const stuffit5::CompressionLevel::type seven = 7;

        /** Zip compression level eight. */
        const stuffit5::CompressionLevel::type eight = 8;

        /** Zip compression level nine. Maximum compression. */
        const stuffit5::CompressionLevel::type nine = 9;

        /** Maximum compression level. The best, maximum compression. Yields the
        highest compression ratio and usually the slowest archive creation. */
        const stuffit5::CompressionLevel::type maximum = 9;
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::ZipCompressionLevel::minimum</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_minimum = 0;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::none</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_none = 0;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::one</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_one = 1;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::two</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_two = 2;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::three</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_three = 3;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::four</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_four = 4;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::five</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_five = 5;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::six</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_six = 6;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::seven</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_seven = 7;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::eight</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_eight = 8;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::nine</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_nine = 9;
/** C equivalent of <code>stuffit5::ZipCompressionLevel::maximum</code>. */
const stuffit5_CompressionLevel_type stuffit5_ZipCompressionLevel_maximum = 9;

#endif // __cplusplus

#endif

