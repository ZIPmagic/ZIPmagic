// $Id: ArchiveInfo.h,v 1.10.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1996-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_ArchiveInfo_h_included
#define stuffit5_ArchiveInfo_h_included

#include "un/config.h"
#include "un/stdint.h"

#if compiler_msvc
    #pragma pack(push, 8)
#endif

#if defined __cplusplus

#include <string>
#include "stuffit5/Format.h"
#include "un/opt_property.h"
#include "un/property.h"
#include "un/gcc/wstring.h"

/** Archive information.

<p>Each <code>stuffit5::Reader</code> and <code>stuffit5::Writer</code> has one
instance of this class that stores information about the archive being read or written.

<p>This class allows access to archive <i>properties</i> through accessor and mutator
functions. Some of the properties are optional.

<p>In a reader, archive properties are available after archive classification or
archive scan, until the archive is closed.

@author serge@aladdinsys.com
@version $Revision: 1.10.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    class ArchiveInfo {
    public:
        /** Default constructor. */
        ArchiveInfo();

        /** Path name of the archive.

        <p><b>In a reader:</b> The accessor returns the path name of the archive
        that is open in the reader. The mutator assigns the new path name of the
        archive to be decoded. The path name may be absolute or relative; it is
        the final path name of the archive to be created.

        <p>This function can control the name of the next archive segment to be
        processed, in multi-segment formats (such as StuffItSegment). It has
        effect only during the decoding phase and only when used inside the
        <code>ArchiveNext</code> event callback.

        <p><b>In a writer:</b> The accessor returns the path name of the archive
        that is open in the writer. The mutator assigns the new archive name as
        long as the archive is not yet open. The last chance to rename or
        relocate it is during the <code>ArchiveCreateBegin</code> event
        callback.
        */
        un::property<std::string> name;

        /** Current archive position.

        <p><b>In a reader:</b> The accessor returns the offset from the
        beginning of the input file, at which the reader is processing the
        archive. Initially, when the reader is created, it is 0. This is the
        position at which classification, scan, and decoding begin.

        <p>After each archive is decoded, archive position is updated to point
        to the first byte past the end of the processed archive. This allows
        reading to continue from the same input file if it contains concatenated
        archives.

        <p>If only <code>decode()</code> calls are used to process the archive,
        archive position is used internally, and there is no need to get or set
        its value. Repeated calls to <code>decode()</code> process one archive
        at a time until the end of file is reached.

        <p>This property is most useful during the classification phase. If
        classification is done with a separate call to <code>classify()</code>,
        more control can be achieved over the classification process by setting
        the archive position (and classifier span) properties.

        <p><b>In a writer:</b> Unused.
        */
        un::property<uint32_t> position;

        /** Format of the archive that is open in the reader or writer.

        <p><b>In a reader:</b> Assigned as soon as archive classification is
        complete. If <code>classify()</code> is called explicitly, the format is
        available at the time it issues the <code>ArchiveInfo</code> event
        callback, or at the time it returns if no event callback is made. If
        <code>classify()</code> is called internally, the format is available
        between the time of the <code>ArchiveDecodeBegin</code> event and the
        time of the <code>ArchiveDecodeEnd</code> event.

        <p><b>In a writer:</b> The accessor returns the format of the archive
        that is going to be or is being created by the writer. Always defined.
        If an archive is open in the writer at the time of the call, the return
        value is its format; otherwise, it is the format of the next archive to
        be created.

        <p>The mutator assigns the new archive format to be created by the
        writer. The format applies to the next archive to be created. <p>If
        archive format is not assigned, the default format is StuffIt. The
        writer will create StuffIt archives unless instructed otherwise.

        <p>This function can assign the archive format as long as the archive is
        not open yet. The last chance to change the format is during the
        <code>ArchiveCreateBegin</code> event callback.

        <p>This member function effectively changes the format of the new
        archive. It cannot change the format of an already open archive and
        therefore has no effect once the archive is created.
        */
        un::property<stuffit5::Format::type> format;

        /** <b>In a reader:</b> Number of items in the archive. The total number
        of files (and in case of StuffIt and StuffIt5 formats, the total number
        of files <i>and</i> folders). In a reader, available from the time of
        the archive scan completion to the time the archive is closed.

        <p><b>In a writer:</b> Unused.
        */
        un::property<uint32_t> items;

        /** <b>In a reader:</b> Name of the single item at the root level of the
        archive, or an empty string if there is more than one such item.
        Available from the time of the archive scan completion to the time the
        archive is closed.

        <p><b>In a writer:</b> Unused.
        */
        un::property<std::string> rootName;

        /** <b>In a reader:</b> Total compressed size of all items in the
        archive, excluding headers. Equal to the size of the archive; may be
        slightly less than the size of the input file when it contains a single
        archive, and may be significantly less than the size of the input file
        if it contains multiple concatenated archives.

        <p>Available from the time of the archive scan completion to the time
        the archive is closed. If the size has not been determined, equals to
        the unsigned equivalent of <code>-1</code>, or <code>0xffffffff</code>.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> compressedSize;

        /** <b>In a reader:</b> Total uncompressed size of all items in the
        archive. Equals to the sum of sizes of all files that will be created in
        the decoding phase.

        <p>Available from the time of the archive scan completion to the time
        the archive is closed. If the size has not been determined, equals to
        the unsigned equivalent of <code>-1</code>, or <code>0xffffffff</code>.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> uncompressedSize;

        /** <b>In a reader:</b> Segment ID. Available only for StuffItSegment
        archives. Segmented archives consist of multiple parts. Each part
        carries an ID that is a number randomly generated for each archive and
        is the same for all segments of the archive.

        <p>This property may be used to establish that an archive segment
        belongs to the correct set of segments.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> segmentID;

        /** <b>In a reader:</b> Archive sequence number. Available only for
        StuffItSegment archives. Each segment carries a sequence number that
        determines the segment's position in the sequence of segments that
        constitutes the segmented archive.

        <p>This property may be used to establish that an archive segment is the
        next segment in a sequence of segments.

        <p><b>In a writer:</b> Unused.
        */
        un::opt_property<uint32_t> segmentNumber;

        /** <b>In a reader:</b> Indicates that the archive is encrypted, i.e.,
        contains one or more encrypted items. Some archive formats require all
        items to be encrypted, some allow items to be selectively encrypted. In
        either case, if this function returns <code>true</code>, a password or a
        key will be required to completely expand the archive.

        <p>If there is only one password (or key) per archive, this function may
        be used to establish that there is a need to ask the user for a password
        as soon as archive information is available, before processing of
        individual items begins.

        <p><b>In a writer:</b> Unused.
        */
        un::property<bool> isEncrypted;

        /** Resets all properties, marks all optional properties as unavailable. */
        void reset();
    };
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/bool.h"
#include "stuffit5/common.h"

/** C interface to <code>stuffit5::ArchiveInfo::name()</code>. */
extern_c exported const char* stuffit5_ArchiveInfo_getName(stuffit5_ArchiveInfo archive);
/** C interface to <code>stuffit5::ArchiveInfo::name()</code>. */
extern_c exported void stuffit5_ArchiveInfo_setName(const char* archiveName, stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::position()</code>. */
extern_c exported uint32_t stuffit5_ArchiveInfo_getPosition(stuffit5_ArchiveInfo archive);
/** C interface to <code>stuffit5::ArchiveInfo::position()</code>. */
extern_c exported void stuffit5_ArchiveInfo_setPosition(uint32_t position, stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::format()</code>. */
extern_c exported stuffit5_Format_type stuffit5_ArchiveInfo_getFormat(stuffit5_ArchiveInfo archive);
/** C interface to <code>stuffit5::ArchiveInfo::format()</code>. */
extern_c exported void stuffit5_ArchiveInfo_setFormat(stuffit5_Format_type format, stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::items()</code>. */
extern_c exported uint32_t stuffit5_ArchiveInfo_getItems(stuffit5_ArchiveInfo archive);
/** C interface to <code>stuffit5::ArchiveInfo::rootName()</code>. */
extern_c exported const char* stuffit5_ArchiveInfo_getRootName(stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::compressedSize()</code>. */
extern_c exported bool stuffit5_ArchiveInfo_hasCompressedSize(stuffit5_ArchiveInfo file);
/** C interface to <code>stuffit5::ArchiveInfo::compressedSize()</code>. */
extern_c exported uint32_t stuffit5_ArchiveInfo_getCompressedSize(stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::uncompressedSize()</code>. */
extern_c exported bool stuffit5_ArchiveInfo_hasUncompressedSize(stuffit5_ArchiveInfo file);
/** C interface to <code>stuffit5::ArchiveInfo::uncompressedSize()</code>. */
extern_c exported uint32_t stuffit5_ArchiveInfo_getUncompressedSize(stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::segmentID()</code>. */
extern_c exported bool stuffit5_ArchiveInfo_hasSegmentID(stuffit5_ArchiveInfo archive);
/** C interface to <code>stuffit5::ArchiveInfo::segmentID()</code>. */
extern_c exported uint32_t stuffit5_ArchiveInfo_getSegmentID(stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::segmentNumber()</code>. */
extern_c exported bool stuffit5_ArchiveInfo_hasSegmentNumber(stuffit5_ArchiveInfo archive);
/** C interface to <code>stuffit5::ArchiveInfo::segmentNumber()</code>. */
extern_c exported uint32_t stuffit5_ArchiveInfo_getSegmentNumber(stuffit5_ArchiveInfo archive);

/** C interface to <code>stuffit5::ArchiveInfo::isEncrypted()</code>. */
extern_c exported bool stuffit5_ArchiveInfo_isEncrypted(stuffit5_ArchiveInfo archive);

#endif // __cplusplus

#if compiler_msvc
    #pragma pack(pop)
#endif

#endif

