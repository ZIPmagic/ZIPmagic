// $Id: FileInfo.h,v 1.12.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1996-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_FileInfo_h_included
#define stuffit5_FileInfo_h_included

#include "un/config.h"
#include "un/stdint.h"

#if compiler_msvc
    #pragma pack(push, 8)
#endif

#if defined __cplusplus

#include <string>
#include "format/data/OSType.h"
#include "un/opt_property.h"
#include "un/property.h"
#include "un/gcc/wstring.h"

/** File information.

<p>Each <code>stuffit5::Reader</code> and <code>stuffit5::Writer</code> has one
instance of this class that stores information about each file being read or written.

<p>This class allows access to file <i>properties</i> through accessor and mutator
functions. Some of the properties are optional.

<p>File properties are available during archive decoding and creation. They are
available at the time of <code>FileInfo</code>, <code>FileDecodeBegin</code> and
<code>FileEncodeBegin</code> event callbacks.

@author serge@aladdinsys.com
@version $Revision: 1.12.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    class FileInfo {
    public:
        /** Default constructor. */
        FileInfo();

        /** Current <i>absolute</i> path name of the file being processed.

        <p><b>In a reader:</b> The accessor returns (during scan and decoding
        phases) the absolute path name of the output file being scanned or
        decoded by the reader, at the time of the call. Undefined when no
        archive scanning or decoding is taking place.

        <p>The mutator assigns the path name of the file that is being decoded
        by the reader; it sets the final path name of the file. The path name
        may be absolute or relative to the current directory. This can be used
        to control the name of each output file. It has effect only during the
        decoding phase and only if it used before the output file is open. For
        example, it can be used in the <code>FileDecodeBegin</code> event
        callback to rename output files, or to redirect them to a location
        different from the destination folder the reader has been assigned.

        <p><b>In a writer:</b> The accessor returns, during the archive creation
        phase, the path name of the input file being added to the archive by the
        writer. Undefined when no archive creation is taking place.

        <p>The mutator assigns the new path name of the file that is being added
        to the archive by the writer. The path name may be absolute or relative.
        If the input file is not open yet, the last chance to change its name or
        location (i.e., replace the "proposed" file and add a different file) is
        during the <code>FileEncodeBegin</code> event callback.
        */
        un::property<std::string> name;

        /** Current Unicode <i>file</i> name (not the <i>path</i> name) of the
        file being processed.

        <p><b>In a reader:</b> The accessor returns (during the scan and the
        decoding phases) the Unicode name of the output file being scanned or
        decoded by the reader, at the time of the call. Undefined when no
        archive scanning or decoding is taking place. Unicode file names are
        available only in StuffIt5 archives that store Unicode names.

        <p>The mutator assigns the name of the output file. It has effect only
        during the decoding phase and only if it used before the output file is
        open. For example, it can be used in the <code>FileDecodeBegin</code>
        event callback to rename output files, or to redirect them to a location
        different from the destination file the reader has been assigned.

        <p><b>In a writer:</b> The mutator assigns the Unicode file name. The
        name is not a complete path name, but just the file name to be stored in
        the archive. The name can be changed during the
        <code>FileEncodeBegin</code> event callback.

        <p>The complete path name is available through the <code>name()</code>
        property, and contains the UTF8-encoded file name from the archive; the
        file name part may be replaced (through the <code>name</code> mutator by
        a name acceptable to the target system and based on the Unicode file
        name.
        */
        un::opt_property<std::wstring> unicodeName;

        /** <b>In a reader:</b> Compressed size of the file (in the archive).
        Available in most (but not all) formats.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> compressedSize;

        /** <b>In a reader:</b> Uncompressed size of the (original) file.
        Available in most (but not all) formats.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> uncompressedSize;

        /** <b>In a reader:</b> Modification date in UNIX format (32-bit integer equal
        to the number of seconds since midnight, January 1, 1970, GMT. Available in
        StuffIt and StuffIt5 readers.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> modificationTime;

        /** <b>In a reader:</b> Macintosh file type, four characters. Available
        in StuffIt, StuffItSegment, MacBinary, and BinHex formats.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<format::data::OSType> macType;

        /** <b>In a reader:</b> Macintosh file creator, four characters.
        Available in StuffIt, StuffItSegment, MacBinary, and BinHex formats.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<format::data::OSType> macCreator;

        /** <b>In a reader:</b> True if the file is encrypted, and a password or
        a key is required to expand it. If there is only one password (or key)
        per archive, the archive's password (or key) should be established by
        the time file information is available.

        <p><b>In a writer:</b> Unused.
        */
        un::property<bool> isEncrypted;

        /** <b>In a reader:</b> True if the file will be output in MacBinary
        encoded format. Indicates that reader output is a MacBinary file
        generated by the reader. Does not indicate that the original file is a
        MacBinary file.

        <p>Unlike other properties in this class, this indication is available
        only at the time of <code>FileDecodeBegin</code> event callbacks, not at
        the time of <code>FileInfo</code> event callbacks.

        <p><b>In a writer:</b> Unused.
        */
        un::property<bool> outputIsMacBinary;

        /** Resets all properties, marks all optional properties as unavailable. */
        void reset();
    };
}

#endif // __cplusplus

#if compiler_msvc
    #pragma pack(pop)
#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/bool.h"
#include "stuffit5/common.h"

/** C interface to <code>stuffit5::FileInfo::name()</code>. */
extern_c exported const char* stuffit5_FileInfo_getName(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::name()</code>. */
extern_c exported void stuffit5_FileInfo_setName(const char* name, stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::unicodeName()</code>. */
extern_c exported bool stuffit5_FileInfo_hasUnicodeName(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::unicodeName()</code>. */
extern_c exported const wchar_t* stuffit5_FileInfo_getUnicodeName(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::unicodeName()</code>. */
extern_c exported void stuffit5_FileInfo_setUnicodeName(const wchar_t* unicodeName, stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::compressedSize()</code>. */
extern_c exported bool stuffit5_FileInfo_hasCompressedSize(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::compressedSize()</code>. */
extern_c exported const uint32_t stuffit5_FileInfo_getCompressedSize(stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::uncompressedSize()</code>. */
extern_c exported bool stuffit5_FileInfo_hasUncompressedSize(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::uncompressedSize()</code>. */
extern_c exported const uint32_t stuffit5_FileInfo_getUncompressedSize(stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::macType()</code>. */
extern_c exported bool stuffit5_FileInfo_hasMacType(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::macType()</code>. */
extern_c exported const uint32_t stuffit5_FileInfo_getMacType(stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::macCreator()</code>. */
extern_c exported bool stuffit5_FileInfo_hasMacCreator(stuffit5_FileInfo file);
/** C interface to <code>stuffit5::FileInfo::macCreator()</code>. */
extern_c exported const uint32_t stuffit5_FileInfo_getMacCreator(stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::isEncrypted()</code>. */
extern_c exported bool stuffit5_FileInfo_isEncrypted(stuffit5_FileInfo file);

/** C interface to <code>stuffit5::FileInfo::outputIsMacBinary()</code>. */
extern_c exported bool stuffit5_FileInfo_outputIsMacBinary(stuffit5_FileInfo file);

#endif // __cplusplus

#endif

