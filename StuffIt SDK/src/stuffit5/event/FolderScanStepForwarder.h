// $Id: FolderScanStepForwarder.h,v 1.1.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_forwarder_FolderScanStepForwarder_h_included
#define stuffit5_event_forwarder_FolderScanStepForwarder_h_included

/** Forwarding event listener. Forwards engine events from virtual member functions
to C-style callback functions.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

#include "stuffit5/event/FolderScanStepListener.h"

namespace stuffit5 {
    namespace event {
        class FolderScanStepForwarder : public stuffit5::event::FolderScanStepListener {
        public:
            FolderScanStepForwarder(stuffit5_event_FolderScanStepListener_folderScanStepEvent folderScanStepEvent, stuffit5_Reader reader) :
                FolderScanStepListener(),
                reader(reader),
                callback(folderScanStepEvent) {
                orphan(true);
            }

            virtual bool folderScanStepEvent() {
                return (*callback)(reader);
            }

        private:
            const stuffit5_Reader reader;
            const stuffit5_event_FolderScanStepListener_folderScanStepEvent callback;
        };
    }
}

#endif

