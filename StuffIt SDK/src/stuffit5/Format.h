// $Id: Format.h,v 1.4.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_Format_h_included
#define stuffit5_Format_h_included

#include "un/config.h"

#if defined __cplusplus

/** StuffIt Engine format.

<p>This type describes archive and encoded formats for use with the
StuffIt Engine.

@author serge@aladdinsys.com
@version $Revision: 1.4.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace Format {
        /** Underlying type. */
        typedef int type;

        /** Unknown, unrecognized format. Returned by the classifier when it is unable
        to detect any archive or encoded data within the file. */
        const stuffit5::Format::type unknown = 0;

        /** An empty file. Returned by the classifier when there is no data available to
        analyze in order to determine file format. */
        const stuffit5::Format::type empty = 1;

        /** End of file. Indicates that the end of file has been reached. Returned by
        the classifier. */
        const stuffit5::Format::type eof = 2;

        /** First (lowest) format code. The value equal to the first (lowest) format
        code. May be useful for building tables indexed by values of type
        <code>stuffit5_Format_type</code>. */
        const stuffit5::Format::type first = 3;

        /** StuffIt archive format. The Macintosh standard. Used in multiple Aladdin
        Systems products of the StuffIt family. */
        const stuffit5::Format::type sit = 3;

        /** Compact Pro archive format. A Macintosh format. Still in use. */
        const stuffit5::Format::type cpt = 4;

        /** Zip archive format. Originally developed by PKWARE. Now widely used by
        multiple applications. The most common Windows format. */
        const stuffit5::Format::type zip = 5;

        /** Arc archive format. Was used in mid- to late-eighties. The first DOS based
        archiver that was in widespread use. Relatively few Arc archives can be found
        now. */
        const stuffit5::Format::type arc = 6;

        /** Arj archive format. Shareware by Robert Jung. Used mostly in DOS and
        Windows. */
        const stuffit5::Format::type arj = 7;

        /** Lha archive format. Originated in Japan. Used in DOS and Windows. The most
        common archive format on Amiga. */
        const stuffit5::Format::type lha = 8;

        /** Ha archive format. DOS. Rarely used. */
        const stuffit5::Format::type ha = 9;

        /** Rar archive format. DOS and Windows. Originated in Russia. */
        const stuffit5::Format::type rar = 10;

        /** gzip compressed file format. The standard Unix GNU compressor based on one
        of Zip's compression methods. Contains one file per archive. Supported on a
        variety of platforms. */
        const stuffit5::Format::type gz = 11;

        /** Unix compress file format. <code>compress</code> is a Unix utility still in
        use but almost completely replaced by gzip. One file per archive. */
        const stuffit5::Format::type compress = 12;

        /** SCO Unix compress file format. Incompatible with the regular Unix compress. */
        const stuffit5::Format::type sco = 13;

        /** Unix pack file format. An almost forgotten Unix compressor. One of the
        predecessors of Unix compress. */
        const stuffit5::Format::type pack = 14;

        /** Unix compact file format. Another pre-Unix compress format. Hard to find. */
        const stuffit5::Format::type compact = 15;

        /** Unix freeze file format. Single-file format developed by Leo Broukhis in the
        early nineties. */
        const stuffit5::Format::type freeze = 16;

        /** Unix uuencoded file format. <code>uuencode</code> was the most common
        encoded email format before MIME. */
        const stuffit5::Format::type uu = 17;

        /** BinHex encoded file format. BinHex is the Macintosh equivalent of uuencode.
        Combines two Macintish forks into one 7-bit file. */
        const stuffit5::Format::type hqx = 18;

        /** btoa encoded file format. btoa is used almost exclusively (and rarely) in
        Unix. Similar to uuencode but more efficient: lower data expansion factor. */
        const stuffit5::Format::type btoa = 19;

        /** MIME encoded message (file) format. MIME stands for Multipurpose Internet
        Mail Extensions. A text-based 7-bit email message format with typed (and
        possibly named) sections and attachments. More flexible than any other 7-bit
        encoding. Many variations (sometimes buggy and non-compliant) despite the
        existence of an official RFC. */
        const stuffit5::Format::type mime = 20;

        /** Unix tar archive format. Unix tar: tape archive. Used as an uncompressed
        archive format that combines multiple files and folder (directory) hierarchies
        into a single file, not necessarily (rarely, in fact) for writing to a tape.
        Often combined with compression by Unix compress, gzip, and lately bzip2. */
        const stuffit5::Format::type tar = 21;

        /** MacBinary encoded file format. MacBinary is a Macintosh binary file format
        whose purpose is to combine two forks of a Macintosh file, type, creator, and
        other file information into a single binary data file. Used to store Macintosh
        files on ftp servers and in filesystems that do not support multiple forks. */
        const stuffit5::Format::type bin = 22;

        /** MacBinary file information. This corresponds to the file information section
        (header) of a MacBinary file.

        <p>This code is never returned by the classifier and does not correspond to a
        separate format. It is used to designate a part of a MacBinary file processed by
        the engine, when it may be necessary to distinguish it from other parts in an
        event callback. */
        const stuffit5::Format::type binInfo = 23;

        /** The data fork of a MacBinary file. This corresponds to the data fork section
        of a MacBinary file.

        <p>This code is never returned by the classifier and does not correspond to a
        separate format. It is used to designate a part of a MacBinary file processed by
        the engine, when it may be necessary to distinguish it from other parts in an
        event callback. */
        const stuffit5::Format::type binData = 24;

        /** The resource fork of a MacBinary file. This corresponds to the resource fork
        section of a MacBinary file.

        <p>This code is never returned by the classifier and does not correspond to a
        separate format. It is used to designate a part of a MacBinary file processed by
        the engine, when it may be necessary to distinguish it from other parts in an
        event callback. */
        const stuffit5::Format::type binRsrc = 25;

        /** The first segment of a segmented StuffIt archive format. Used in Aladdin
        Systems products. Returned by the classifier when it determines that a file is
        the <i>first</i> segment of a series of StuffIt archive segments. Expansion of a
        segmented StuffIt archive always begins with the first segment. */
        const stuffit5::Format::type sitseg = 26;

        /** Subsequent segment of a segmented StuffIt archive format. A second, third
        and subsequent segment of a segmented StuffIt archive. Returned by the
        classifier. A separate value to make the distinction between the first segment
        and the subsequent segments easier. */
        const stuffit5::Format::type sitsegN = 27;

        /** Private File archive format. Private File is an Aladdin Systems encrypted
        format used by the the Private File encryption utility. Always contains a single
        encrypted StuffIt archive. */
        const stuffit5::Format::type pf = 28;

        /** StuffIt 5.0 archive format. Used in Aladdin Systems StuffIt family products
        since late 1998. Not compatible with pre-5.0 StuffIt format. Higher compression
        ratios, slower compression. Cross-platform, Unicode-based format. */
        const stuffit5::Format::type sit5 = 29;

        /** bzip2 archive format. A block compression algortithm. A single archive
        may contain multiple compressed files, but there are no headers to indicate names
        or attributes of any contained file(s). */
        const stuffit5::Format::type bz2 = 30;

        /** Last (highest) format code. The value equal to the last (highest) format
        code. May be useful for building tables indexed by format. */
        const stuffit5::Format::type last = 30;

        /** Format name. A short name of the format. Examples: "sit", "sit5", "zip", "uu", "hqx".
        @param format the format code
        @return the name string
        */
        exported extern const char* name(stuffit5::Format::type format);

        /** Format description. A longer description of the format.
        Examples: "StuffIt", "StuffIt5", "Zip", "Uuencode", "BinHex".
        @param format the format code
        @return the description string
        */
        exported extern const char* description(stuffit5::Format::type format);

        extern const char* noName;

        /** Names storage. */
        extern const char* names[stuffit5::Format::last + 1];

        extern const char* noDescription;

        /** Descriptions storage. */
        extern const char* descriptions[stuffit5::Format::last + 1];
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/common.h"

/** C equivalent of <code>stuffit5::Format::unknown</code>. */
static const stuffit5_Format_type stuffit5_Format_unknown = 0;
/** C equivalent of <code>stuffit5::Format::empty</code>. */
static const stuffit5_Format_type stuffit5_Format_empty = 1;
/** C equivalent of <code>stuffit5::Format::eof</code>. */
static const stuffit5_Format_type stuffit5_Format_eof = 2;
/** C equivalent of <code>stuffit5::Format::first</code>. */
static const stuffit5_Format_type stuffit5_Format_first = 3;
/** C equivalent of <code>stuffit5::Format::sit</code>. */
static const stuffit5_Format_type stuffit5_Format_sit = 3;
/** C equivalent of <code>stuffit5::Format::cpt</code>. */
static const stuffit5_Format_type stuffit5_Format_cpt = 4;
/** C equivalent of <code>stuffit5::Format::zip</code>. */
static const stuffit5_Format_type stuffit5_Format_zip = 5;
/** C equivalent of <code>stuffit5::Format::arc</code>. */
static const stuffit5_Format_type stuffit5_Format_arc = 6;
/** C equivalent of <code>stuffit5::Format::arj</code>. */
static const stuffit5_Format_type stuffit5_Format_arj = 7;
/** C equivalent of <code>stuffit5::Format::lha</code>. */
static const stuffit5_Format_type stuffit5_Format_lha = 8;
/** C equivalent of <code>stuffit5::Format::ha</code>. */
static const stuffit5_Format_type stuffit5_Format_ha = 9;
/** C equivalent of <code>stuffit5::Format::rar</code>. */
static const stuffit5_Format_type stuffit5_Format_rar = 10;
/** C equivalent of <code>stuffit5::Format::gz</code>. */
static const stuffit5_Format_type stuffit5_Format_gz = 11;
/** C equivalent of <code>stuffit5::Format::compress</code>. */
static const stuffit5_Format_type stuffit5_Format_compress = 12;
/** C equivalent of <code>stuffit5::Format::sco</code>. */
static const stuffit5_Format_type stuffit5_Format_sco = 13;
/** C equivalent of <code>stuffit5::Format::pack</code>. */
static const stuffit5_Format_type stuffit5_Format_pack = 14;
/** C equivalent of <code>stuffit5::Format::compact</code>. */
static const stuffit5_Format_type stuffit5_Format_compact = 15;
/** C equivalent of <code>stuffit5::Format::freeze</code>. */
static const stuffit5_Format_type stuffit5_Format_freeze = 16;
/** C equivalent of <code>stuffit5::Format::uu</code>. */
static const stuffit5_Format_type stuffit5_Format_uu = 17;
/** C equivalent of <code>stuffit5::Format::hqx</code>. */
static const stuffit5_Format_type stuffit5_Format_hqx = 18;
/** C equivalent of <code>stuffit5::Format::btoa</code>. */
static const stuffit5_Format_type stuffit5_Format_btoa = 19;
/** C equivalent of <code>stuffit5::Format::mime</code>. */
static const stuffit5_Format_type stuffit5_Format_mime = 20;
/** C equivalent of <code>stuffit5::Format::tar</code>. */
static const stuffit5_Format_type stuffit5_Format_tar = 21;
/** C equivalent of <code>stuffit5::Format::bin</code>. */
static const stuffit5_Format_type stuffit5_Format_bin = 22;
/** C equivalent of <code>stuffit5::Format::binInfo</code>. */
static const stuffit5_Format_type stuffit5_Format_binInfo = 23;
/** C equivalent of <code>stuffit5::Format::binData</code>. */
static const stuffit5_Format_type stuffit5_Format_binData = 24;
/** C equivalent of <code>stuffit5::Format::binRsrc</code>. */
static const stuffit5_Format_type stuffit5_Format_binRsrc = 25;
/** C equivalent of <code>stuffit5::Format::sitseg</code>. */
static const stuffit5_Format_type stuffit5_Format_sitseg = 26;
/** C equivalent of <code>stuffit5::Format::sitsegN</code>. */
static const stuffit5_Format_type stuffit5_Format_sitsegN = 27;
/** C equivalent of <code>stuffit5::Format::pf</code>. */
static const stuffit5_Format_type stuffit5_Format_pf = 28;
/** C equivalent of <code>stuffit5::Format::sit5</code>. */
static const stuffit5_Format_type stuffit5_Format_sit5 = 29;
/** C equivalent of <code>stuffit5::Format::bz2</code>. */
static const stuffit5_Format_type stuffit5_Format_bz2 = 30;
/** C equivalent of <code>stuffit5::Format::last</code>. */
static const stuffit5_Format_type stuffit5_Format_last = 30;

/** C interface to <code>stuffit5::Format::name()</code>. */
extern_c exported const char* stuffit5_Format_name(stuffit5_Format_type format);
/** C interface to <code>stuffit5::Format::description()</code>. */
extern_c exported const char* stuffit5_Format_description(stuffit5_Format_type format);

#endif // __cplusplus

#endif

