// $Id: FileInfoListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileInfoListener_h_included
#define stuffit5_event_FileInfoListener_h_included

/** Event handler for file information.

<p>This event callback is invoked during the scan of the archive. It provides
additional information about each file contained in the archive.

<p>This event callback provides additional information about files which may be
used in calculations of the number of items, total sizes, etc., and to
accumulate information about the files contained in the archive, for display.

<p><code>position</code> is the position of the file inside the archive. It is
unique to each file and each <code>FileInfoEvent</code> and may be used as a
file ID.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileInfoListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FileInfoListener() {
            }

            /** Destructor. */
            virtual ~FileInfoListener() {
            }

            /** File information.

            <p>This pure virtual member function is the event callback invoked to indicate
            availability of file information.

            @param position position of the file in the archive
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool fileInfoEvent(uint32_t position) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FileInfoListener_fileInfoEvent)(uint32_t position, stuffit5_Reader reader);

extern_c exported stuffit5_event_FileInfoListener stuffit5_Reader_addFileInfoListener(stuffit5_event_FileInfoListener_fileInfoEvent fileInfoEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFileInfoListener(stuffit5_event_FileInfoListener fileInfoListener, stuffit5_Reader reader);

#endif

#endif

