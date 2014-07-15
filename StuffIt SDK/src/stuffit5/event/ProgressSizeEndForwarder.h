// $Id: ProgressSizeEndForwarder.h,v 1.1.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_forwarder_ProgressSizeEndForwarder_h_included
#define stuffit5_event_forwarder_ProgressSizeEndForwarder_h_included

/** Forwarding event listener. Forwards engine events from virtual member functions
to C-style callback functions.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

#include "stuffit5/event/ProgressSizeEndListener.h"

namespace stuffit5 {
    namespace event {
        class ProgressSizeEndForwarder : public stuffit5::event::ProgressSizeEndListener {
        public:
            ProgressSizeEndForwarder(stuffit5_event_ProgressSizeEndListener_progressSizeEndEvent progressSizeEndEvent, stuffit5_Reader reader) :
                ProgressSizeEndListener(),
                reader(reader),
                callback(progressSizeEndEvent) {
                orphan(true);
            }

            virtual void progressSizeEndEvent() {
                (*callback)(reader);
            }

        private:
            const stuffit5_Reader reader;
            const stuffit5_event_ProgressSizeEndListener_progressSizeEndEvent callback;
        };
    }
}

#endif

