// $Id: TextConversion.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_TextConversion_h_included
#define stuffit5_TextConversion_h_included

#if defined __cplusplus

/** Text conversion option.

<p>Describes text file conversions.

<p>StuffIt readers can apply text conversion to files that are being decompressed
or decoded. A <code>stuffit5::TextConversion</code> determines when to
apply text conversion.

<p>Of the formats supported by the engine, only StuffIt and StuffIt5 are capable
of applying text conversion.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace TextConversion {
        /** Underlying type. */
        typedef int type;

        /** No files are converted. No text conversion is applied to output files created by
        engine readers during decompression or decoding. End-of-lines are unchanged. */
        const stuffit5::TextConversion::type off = 0;

        /** All files are converted. Text conversion is applied to all output files created by
        engine readers during decompression or decoding. End-of-lines are changed
        according to a <code>stuffit5::TextType</code>. */
        const stuffit5::TextConversion::type on = 1;

        /** Text files are converted. Text conversion is applied to output files that are
        created by engine readers during decompression or decoding and are <i>known
        to contain text</i>. End-of-lines are changed according to a
        <code>stuffit5::TextType</code>.

        <p>Files that are <i>known to contain text</i> are defined as follows: either
        the format being decompressed or decoded by the reader contains an indication or
        flag that a file is a text file, or a file is a Macintosh file that has
        Macintosh file type of <code>"TEXT"</code> as its attribute stored in the
        archive. */
        const stuffit5::TextConversion::type automatic = 2;
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::TextConversion::off</code>. */
const stuffit5_TextConversion_type stuffit5_TextConversion_off = 0;
/** C equivalent of <code>stuffit5::TextConversion::on</code>. */
const stuffit5_TextConversion_type stuffit5_TextConversion_on = 1;
/** C equivalent of <code>stuffit5::TextConversion::automatic</code>. */
const stuffit5_TextConversion_type stuffit5_TextConversion_automatic = 2;

#endif // __cplusplus

#endif

