// $Id: FolderInfo.h,v 1.10.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_FolderInfo_h_included
#define stuffit5_FolderInfo_h_included

#include "un/config.h"

#if compiler_msvc
    #pragma pack(push, 8)
#endif

#if defined __cplusplus

#include <string>
#include "un/opt_property.h"
#include "un/property.h"
#include "un/gcc/wstring.h"

/** Folder information.

<p>Each <code>stuffit5::Reader</code> and <code>stuffit5::Writer</code> has one
instance of this class that stores information about each folder being read or written.

<p>This class allows access to folder <i>properties</i> through accessor and mutator
functions. Some of the properties are optional.

<p>Folder properties are available during archive decoding and creation. They are
available at the time of <code>FolderInfo</code>, <code>FolderDecodeBegin</code> and
<code>FolderEncodeBegin</code> event callbacks.

@author serge@aladdinsys.com
@version $Revision: 1.10.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    class FolderInfo {
    public:
        /** Default constructor. */
        FolderInfo();

        /** Current <i>absolute</i> path name of the folder being processed.

        <p><b>In a reader:</b> The accessor returns (during scan and decoding
        phases) the absolute path name of the output folder being scanned or
        decoded by the reader, at the time of the call. Undefined when no
        archive scanning or decoding is taking place.

        <p>The mutator assigns the path name of the folder that is being decoded
        by the reader; it sets the final path name of the folder. The path name
        may be absolute or relative to the current directory. This can be used
        to control the name of each output folder. It has effect only during the
        decoding phase and only if it used before the output folder is created.
        For example, it can be used in the <code>FolderDecodeBegin</code> event
        callback to rename output folders, or to redirect them to a location
        different from the destination folder the reader has been assigned.

        <p><b>In a writer:</b> The accessor returns, during the archive creation
        phase, the path name of the input folder being added to the archive by
        the writer. Undefined when no archive creation is taking place.

        <p>The mutator assigns the new path name of the folder that is being
        added to the archive by the writer. The path name may be absolute or
        relative. If the input folder is not open yet, the last chance to change
        its name or location (i.e., replace the "proposed" folder and add a
        different file) is during the <code>FolderEncodeBegin</code> event
        callback.
        */
        un::property<std::string> name;

        /** Current Unicode <i>folder</i> name (not the <i>path</i> name) of the
        folder being processed.

        <p><b>In a reader:</b> The accessor returns (during the scan and the
        decoding phases) the Unicode name of the output folder being scanned or
        decoded by the reader, at the time of the call. Undefined when no
        archive scanning or decoding is taking place. Unicode folder names are
        available only in StuffIt5 archives that store Unicode names.

        <p>The mutator assigns the name of the output folder. It has effect only
        during the decoding phase and only if it used before the output folder is
        open. For example, it can be used in the <code>FolderDecodeBegin</code>
        event callback to rename output folders, or to redirect them to a location
        different from the destination folder the reader has been assigned.

        <p><b>In a writer:</b> The mutator assigns the Unicode folder name. The
        name is not a complete path name, but just the folder name to be stored in
        the archive. The name can be changed during the
        <code>FolderEncodeBegin</code> event callback.

        <p>The complete path name is available through the <code>name()</code>
        property, and contains the UTF8-encoded folder name from the archive; the
        folder name part may be replaced (through the <code>name</code> mutator by
        a name acceptable to the target system and based on the Unicode folder
        name.
        */
        un::opt_property<std::wstring> unicodeName;

        /** Resets all properties, marks all optional properties as unavailable. */
        void reset();
    };
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/bool.h"
#include "stuffit5/common.h"

/** C interface to <code>stuffit5::FolderInfo::name()</code>. */
extern_c exported const char* stuffit5_FolderInfo_getName(stuffit5_FolderInfo folder);
/** C interface to <code>stuffit5::FolderInfo::name()</code>. */
extern_c exported void stuffit5_FolderInfo_setName(const char* name, stuffit5_FolderInfo folder);

/** C interface to <code>stuffit5::FolderInfo::unicodeName()</code>. */
extern_c exported bool stuffit5_FolderInfo_hasUnicodeName(stuffit5_FolderInfo folder);
/** C interface to <code>stuffit5::FolderInfo::unicodeName()</code>. */
extern_c exported const wchar_t* stuffit5_FolderInfo_getUnicodeName(stuffit5_FolderInfo folder);
/** C interface to <code>stuffit5::FolderInfo::unicodeName()</code>. */
extern_c exported void stuffit5_FolderInfo_setUnicodeName(const wchar_t* unicodeName, stuffit5_FolderInfo folder);

#endif // __cplusplus

#if compiler_msvc
    #pragma pack(pop)
#endif

#endif

