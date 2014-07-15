// $Id: FolderDecodeBeginListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FolderDecodeBeginListener_h_included
#define stuffit5_event_FolderDecodeBeginListener_h_included

/** Event handler for the beginning of folder decoding.

<p>This event callback is invoked immediately before decoding of each folder
begins.

<p>This event callback is similar in function to <code>FileDecodeBegin</code>
but applies to folders instead of files.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FolderDecodeBeginListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            virtual ~FolderDecodeBeginListener() {
            }

            /** Beginning of folder decoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of folder decoding.

            @param position position of the folder in the archive
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool folderDecodeBeginEvent(uint32_t position) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FolderDecodeBeginListener_folderDecodeBeginEvent)(uint32_t position, stuffit5_Reader reader);

extern_c exported stuffit5_event_FolderDecodeBeginListener stuffit5_Reader_addFolderDecodeBeginListener(stuffit5_event_FolderDecodeBeginListener_folderDecodeBeginEvent folderDecodeBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFolderDecodeBeginListener(stuffit5_event_FolderDecodeBeginListener folderDecodeBeginListener, stuffit5_Reader reader);

#endif

#endif

