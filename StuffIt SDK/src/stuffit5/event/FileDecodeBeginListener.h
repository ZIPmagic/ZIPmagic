// $Id: FileDecodeBeginListener.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileDecodeBeginListener_h_included
#define stuffit5_event_FileDecodeBeginListener_h_included

#include "un/stdint.h"

/** Event handler for the beginning of file decoding.

<p>This event callback is invoked immediately before decoding of each file
begins.

<p>As with any operation that creates files and folders with predefined (in this
case, described in the archive) names, there is a possibility that a file or
folder with the same name already exists. In this situation, name conflict
resolution must take place. Some possible ways to resolve the collision are:
delete (overwrite) the existing file, skip the output file, skip if the output
file is older than the existing file, skip this and all subsequent files that
generate name collisions, or rename the output file. This is far from being the
exhaustive list of all possibilities, and shows why event callbacks are
important for providing the ultimate flexibilty in this decision that can only
be achieved at runtime (as opposed to predetermining how all name conflicts are
to be resolved before decoding begins). This event handler is the place to put
custom name conflict resolution code.

<p>This callback is also the place where file names can be converted to fit the
requirements of the target filesystem. Archives coming from different operating
systems and filesystems may contain file names that are too long for the target
filesystem, or contain illegal characters, or in some other respect violate the
restrictions of the target filesystem, and would result in an error if they were
used to create output files.

<p>This event callback has control over the output file name, but the reader will
further modify the name if needed to resolve a name conflict or fit the target
filesystem name requirements. If the reader needs to modify the file name after
this event, it will invoke the <code>FileChangedNameEvent</code>.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileDecodeBeginListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            virtual ~FileDecodeBeginListener() {
            }

            /** Beginning of file decoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of file decoding.

            @param position position of the file in the archive
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool fileDecodeBeginEvent(uint32_t position) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FileDecodeBeginListener_fileDecodeBeginEvent)(uint32_t position, stuffit5_Reader reader);

extern_c exported stuffit5_event_FileDecodeBeginListener stuffit5_Reader_addFileDecodeBeginListener(stuffit5_event_FileDecodeBeginListener_fileDecodeBeginEvent fileDecodeBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFileDecodeBeginListener(stuffit5_event_FileDecodeBeginListener fileDecodeBeginListener, stuffit5_Reader reader);

#endif

#endif

