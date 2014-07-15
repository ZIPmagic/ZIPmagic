// $Id: ProgressScanBeginDispatcher.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressScanBeginDispatcher_h_included
#define stuffit5_event_ProgressScanBeginDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ProgressScanBeginListener.h"

/** This class generates event notifications for <code>ProgressScanBeginEvent</code>.
It maintains a list of <code>ProgressScanBeginListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

namespace stuffit5 {
    namespace event {
        class ProgressScanBeginDispatcher {
        public:
            /** Register an <code>ProgressScanBeginListener</code> to be periodically notified.
            @param l an <code>ProgressScanBeginListener</code> to be added to the notification list
            */
            void addProgressScanBeginListener(stuffit5::event::ProgressScanBeginListener* l) {
                progressScanBeginListeners.push_back(l);
            }

            /** Remove an <code>ProgressScanBeginListener</code> from the list of listeners.
            @param l an <code>ProgressScanBeginListener</code> to be removed from the notification list
            */
            void removeProgressScanBeginListener(stuffit5::event::ProgressScanBeginListener* l) {
                progressScanBeginListeners.remove(l);
            }

            /** Send an <code>ProgressScanBeginEvent</code> to all registered listeners.
            @param e an <code>ProgressScanBeginEvent</code> to be dispatched
            */
            void fireProgressScanBeginEvent() {
                std::list<stuffit5::event::ProgressScanBeginListener*> al = progressScanBeginListeners;
                for (std::list<stuffit5::event::ProgressScanBeginListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->progressScanBeginEvent();
            }

        protected:
            /** A list of registered <code>ProgressScanBeginListener</code>s. */
            std::list<stuffit5::event::ProgressScanBeginListener*> progressScanBeginListeners;
        };
    }
}

#endif

