// $Id: MacBinaryOutput.h,v 1.2.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_MacBinaryOutput_h_included
#define stuffit5_MacBinaryOutput_h_included

#if defined __cplusplus

/** MacBinary output option.

<p>Macintosh filesystem defines a file as a combination of two forks, a data
fork and a resource fork. This presents a difficulty when such files are
transmitted into a non-Macintosh filesystem. A generally accepted way of storing
Macintosh files in other operating systems is to use MacBinary encoding. A
MacBinary file consists of a header followed by the data fork and the resource
fork, all stored sequentially in one file.

<p>StuffIt, BinHex, and StuffItSegment readers can output files in MacBinary
format.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace MacBinaryOutput {
        /** Underlying type. */
        typedef int type;

        /** No files are output in MacBinary format. Readers output only the contents
        of the data fork of each file. */
        const stuffit5::MacBinaryOutput::type off = 0;

        /** All files are output in MacBinary format. Readers output the contents of
        both the data fork and the resource fork of each file. Every output file is in
        MacBinary format, even if it contains only the data fork. */
        const stuffit5::MacBinaryOutput::type on = 1;

        /** Two-fork files are output in MacBinary format. Readers create output
        files in MacBinary format when both the data fork and the resource fork
        are present.*/
        const stuffit5::MacBinaryOutput::type automatic = 2;
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::MacBinaryOutput::off</code>. */
const stuffit5_MacBinaryOutput_type stuffit5_MacBinaryOutput_off = 0;
/** C equivalent of <code>stuffit5::MacBinaryOutput::on</code>. */
const stuffit5_MacBinaryOutput_type stuffit5_MacBinaryOutput_on = 1;
/** C equivalent of <code>stuffit5::MacBinaryOutput::automatic</code>. */
const stuffit5_MacBinaryOutput_type stuffit5_MacBinaryOutput_automatic = 2;

#endif // __cplusplus

#endif

