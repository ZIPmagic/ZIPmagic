// $Id: ProgressSizeMoveForwarder.h,v 1.1.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_forwarder_ProgressSizeMoveForwarder_h_included
#define stuffit5_event_forwarder_ProgressSizeMoveForwarder_h_included

/** Forwarding event listener. Forwards engine events from virtual member functions
to C-style callback functions.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

#include "stuffit5/event/ProgressSizeMoveListener.h"

namespace stuffit5 {
    namespace event {
        class ProgressSizeMoveForwarder : public stuffit5::event::ProgressSizeMoveListener {
        public:
            ProgressSizeMoveForwarder(stuffit5_event_ProgressSizeMoveListener_progressSizeMoveEvent progressSizeMoveEvent, stuffit5_Reader reader) :
                ProgressSizeMoveListener(),
                reader(reader),
                callback(progressSizeMoveEvent) {
                orphan(true);
            }

            virtual bool progressSizeMoveEvent(uint32_t position) {
                return (*callback)(position, reader);
            }

        private:
            const stuffit5_Reader reader;
            const stuffit5_event_ProgressSizeMoveListener_progressSizeMoveEvent callback;
        };
    }
}

#endif

