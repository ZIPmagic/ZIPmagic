// $Id: ProgressFilesMoveDispatcher.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressFilesMoveDispatcher_h_included
#define stuffit5_event_ProgressFilesMoveDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ProgressFilesMoveListener.h"
#include "un/stdint.h"

/** This class generates event notifications for <code>ProgressFilesMoveEvent</code>.
It maintains a list of <code>ProgressFilesMoveListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

namespace stuffit5 {
    namespace event {
        class ProgressFilesMoveDispatcher {
        public:
            /** Register an <code>ProgressFilesMoveListener</code> to be periodically notified.
            @param l an <code>ProgressFilesMoveListener</code> to be added to the notification list
            */
            void addProgressFilesMoveListener(stuffit5::event::ProgressFilesMoveListener* l) {
                progressFilesMoveListeners.push_back(l);
            }

            /** Remove an <code>ProgressFilesMoveListener</code> from the list of listeners.
            @param l an <code>ProgressFilesMoveListener</code> to be removed from the notification list
            */
            void removeProgressFilesMoveListener(stuffit5::event::ProgressFilesMoveListener* l) {
                progressFilesMoveListeners.remove(l);
            }

            /** Send an <code>ProgressFilesMoveEvent</code> to all registered listeners.
            @param e an <code>ProgressFilesMoveEvent</code> to be dispatched
            */
            bool fireProgressFilesMoveEvent(uint32_t files) {
                bool result = true;
                std::list<stuffit5::event::ProgressFilesMoveListener*> al = progressFilesMoveListeners;
                for (std::list<stuffit5::event::ProgressFilesMoveListener*>::iterator i = al.begin(); i != al.end(); i++)
                    result = result && (*i)->progressFilesMoveEvent(files);
                return result;
            }

        protected:
            /** A list of registered <code>ProgressFilesMoveListener</code>s. */
            std::list<stuffit5::event::ProgressFilesMoveListener*> progressFilesMoveListeners;
        };
    }
}

#endif

