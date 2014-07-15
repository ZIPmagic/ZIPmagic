// $Id: Error.h,v 1.3.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_Error_h_included
#define stuffit5_Error_h_included

#include "un/config.h"

#if defined __cplusplus

/** StuffIt Engine error.

<p>This type describes error conditions for use during the <code>Error</code>
event callback.

<p>It is used as:

<ul><li>a function return type, <li>a reader or writer error property, or <li>an
event callback function argument.</ul>

<p>Errors may be recoverable or fatal. Recoverable errors result in an event
notification. Fatal errors cause the engine to return with one of there values.

<p>The absence of errors is indicated by <code>stuffit5::Error::none</code>, which is a
zero.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace Error {
        typedef int type;

        /** No error. Indicates normal completion of an operation. */
        const stuffit5::Error::type none = 0;

        /** The first (lowest) error code. May be useful for table-driven error handling. */
        const stuffit5::Error::type first = 1;

        /** Operation aborted by the caller: <code>false</code> was returned from an event callback. */
        const stuffit5::Error::type aborted = 1;

        /** Out of memory. A memory allocation has failed inside the engine. */
        const stuffit5::Error::type outOfMemory = 2;

        /** Unsupported archive format. Returned when a file that is not one of the
        supported formats (or not an archive ot encoded file at all) is passed for
        scanning or decoding.*/
        const stuffit5::Error::type unsupportedFormat = 3;

        /** Unsupported compression or encoding method.

        <p>Returned when an archive being processed contains a file compressed or
        encoded with a method that the engine does not support, as part of the format
        that is otherwise supported. Examples include segmented and encrypted variations
        of some formats (such as gzip), and abandoned, rarely used and proprietary
        compression methods such as "tokenized" (method 7) of the Zip format or "fast
        Huffman" (method 6) of StuffIt. This can also be caused by an unsupported or
        nonstandard format variation; not an uncommon occurrence.
        */
        const stuffit5::Error::type unsupportedMethod = 4;

        /** Bad archive format. Returned when a format has been recognized and the
        engine determines that the file is damaged or otherwise does not match the
        expected format. */
        const stuffit5::Error::type badFormat = 5;

        /** Bad file data. Most commonly returned when a CRC or a checksum of a
        decompressed or decoded file does not match the value stored in the archive. In
        some cases, returned when compressed data being read is invalid. */
        const stuffit5::Error::type badData = 6;

        /** Bad input or input argument(s).

        <p>Indicates that the number of files passed to an encoder is not in the range
        required by the encoder.

        <p>Used by MacBinary encoder that requires from one to three input files, and by
        PrivateFile encoder that requires one input file. */
        const stuffit5::Error::type badArgument = 7;

        /** Bad password. Returned when a password passed to a decoder does not match
        the password digest (transformed password) stored in the archive that is being
        decoded. */
        const stuffit5::Error::type badPassword = 8;

        /** Input error. Returned when the engine cannot open or read an input file. */
        const stuffit5::Error::type inputError = 9;

        /** Output error. Returned when the engine cannot open or write to an output file. */
        const stuffit5::Error::type outputError = 10;

        /** The last (highest) error code. May be useful for table-driven error handling. */
        const stuffit5::Error::type last = 10;

        /** Error name. A short name of the error.
        @param error the error code
        @return the name string
        */
        exported const char* name(stuffit5::Error::type error);

        /** Error description. A longer description of the error.
        @param error the error code
        @return the description string
        */
        exported const char* description(stuffit5::Error::type error);

        extern const char* noName;

        /** Names storage. */
        extern const char* names[stuffit5::Error::last + 1];

        extern const char* noDescription;

        /** Descriptions storage. */
        extern const char* descriptions[stuffit5::Error::last + 1];
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::Error::none</code>. */
static const stuffit5_Error_type stuffit5_Error_none = 0;
/** C equivalent of <code>stuffit5::Error::first</code>. */
static const stuffit5_Error_type stuffit5_Error_first = 1;
/** C equivalent of <code>stuffit5::Error::aborted</code>. */
static const stuffit5_Error_type stuffit5_Error_aborted = 1;
/** C equivalent of <code>stuffit5::Error::outOfMemory</code>. */
static const stuffit5_Error_type stuffit5_Error_outOfMemory = 2;
/** C equivalent of <code>stuffit5::Error::unsupportedFormat</code>. */
static const stuffit5_Error_type stuffit5_Error_unsupportedFormat = 3;
/** C equivalent of <code>stuffit5::Error::unsupportedMethod</code>. */
static const stuffit5_Error_type stuffit5_Error_unsupportedMethod = 4;
/** C equivalent of <code>stuffit5::Error::badFormat</code>. */
static const stuffit5_Error_type stuffit5_Error_badFormat = 5;
/** C equivalent of <code>stuffit5::Error::badData</code>. */
static const stuffit5_Error_type stuffit5_Error_badData = 6;
/** C equivalent of <code>stuffit5::Error::badArgument</code>. */
static const stuffit5_Error_type stuffit5_Error_badArgument = 7;
/** C equivalent of <code>stuffit5::Error::badPassword</code>. */
static const stuffit5_Error_type stuffit5_Error_badPassword = 8;
/** C equivalent of <code>stuffit5::Error::inputError</code>. */
static const stuffit5_Error_type stuffit5_Error_inputError = 9;
/** C equivalent of <code>stuffit5::Error::outputError</code>. */
static const stuffit5_Error_type stuffit5_Error_outputError = 10;
/** C equivalent of <code>stuffit5::Error::last</code>. */
static const stuffit5_Error_type stuffit5_Error_last = 10;

/** C interface to <code>stuffit5::Error::name()</code>. */
extern_c exported const char* stuffit5_Error_name(stuffit5_Error_type error);
/** C interface to <code>stuffit5::Error::description()</code>. */
extern_c exported const char* stuffit5_Error_description(stuffit5_Error_type error);

#endif // __cplusplus

#endif

