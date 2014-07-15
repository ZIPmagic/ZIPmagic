// $Id: FolderEncodeBeginListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FolderEncodeBeginListener_h_included
#define stuffit5_event_FolderEncodeBeginListener_h_included

/** Event handler for the beginning of folder encoding.

<p>This event callback is invoked immediately before each folder is added to the
archive.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FolderEncodeBeginListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FolderEncodeBeginListener() {
            }

            /** Destructor. */
            virtual ~FolderEncodeBeginListener() {
            }

            /** Beginning of folder encoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of folder encoding.

            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool folderEncodeBeginEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FolderEncodeBeginListener_folderEncodeBeginEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_FolderEncodeBeginListener stuffit5_Reader_addFolderEncodeBeginListener(stuffit5_event_FolderEncodeBeginListener_folderEncodeBeginEvent folderEncodeBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFolderEncodeBeginListener(stuffit5_event_FolderEncodeBeginListener folderEncodeBeginListener, stuffit5_Reader reader);

#endif

#endif

