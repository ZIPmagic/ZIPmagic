// $Id: FolderDecodeEndListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FolderDecodeEndListener_h_included
#define stuffit5_event_FolderDecodeEndListener_h_included

/** Event handler for the end of folder decoding.

<p>This event callback is invoked to indicate the end of decoding of each folder.

<p>At the time of this event, the output folder generated in the decoding
operation from the archive is completed.

<p>This event callback is similar in function to <code>FileDecodeEnd</code>
but applies to folders instead of files.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FolderDecodeEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FolderDecodeEndListener() {
            }

            /** Destructor. */
            virtual ~FolderDecodeEndListener() {
            }

            /** End of folder decoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of folder decoding.
            */
            virtual void folderDecodeEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_FolderDecodeEndListener_folderDecodeEndEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_FolderDecodeEndListener stuffit5_Reader_addFolderDecodeEndListener(stuffit5_event_FolderDecodeEndListener_folderDecodeEndEvent folderDecodeEndEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFolderDecodeEndListener(stuffit5_event_FolderDecodeEndListener folderDecodeEndListener, stuffit5_Reader reader);

#endif

#endif

