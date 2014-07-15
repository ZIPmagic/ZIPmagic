// $Id: FolderInfoListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FolderInfoListener_h_included
#define stuffit5_event_FolderInfoListener_h_included

/** Event handler for folder information.

<p>This event callback is invoked during the scan of the archive. It provides
additional information about each folder contained in the archive.

<p><code>position</code> is the position of the folder inside the archive. It is
unique for each folder and each <code>FolderInfoEvent</code> and may be used as
a folder ID.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FolderInfoListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FolderInfoListener() {
            }

            /** Destructor. */
            virtual ~FolderInfoListener() {
            }

            /** Folder information.

            <p>This pure virtual member function is the event callback invoked to indicate
            availability of folder information.

            @param position position of the folder in the archive
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool folderInfoEvent(uint32_t position) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FolderInfoListener_folderInfoEvent)(uint32_t position, stuffit5_Reader reader);

extern_c exported stuffit5_event_FolderInfoListener stuffit5_Reader_addFolderInfoListener(stuffit5_event_FolderInfoListener_folderInfoEvent folderInfoEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFolderInfoListener(stuffit5_event_FolderInfoListener folderInfoListener, stuffit5_Reader reader);

#endif

#endif

