// $Id: ArchiveNextDispatcher.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveNextDispatcher_h_included
#define stuffit5_event_ArchiveNextDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ArchiveNextListener.h"

/** This class generates event notifications for <code>ArchiveNextEvent</code>.
It maintains a list of <code>ArchiveNextListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

namespace stuffit5 {
    namespace event {
        class ArchiveNextDispatcher {
        public:
            /** Register an <code>ArchiveNextListener</code> to be periodically notified.
            @param l an <code>ArchiveNextListener</code> to be added to the notification list
            */
            void addArchiveNextListener(stuffit5::event::ArchiveNextListener* l) {
                archiveNextListeners.push_back(l);
            }

            /** Remove an <code>ArchiveNextListener</code> from the list of listeners.
            @param l an <code>ArchiveNextListener</code> to be removed from the notification list
            */
            void removeArchiveNextListener(stuffit5::event::ArchiveNextListener* l) {
                archiveNextListeners.remove(l);
            }

            /** Send an <code>ArchiveNextEvent</code> to all registered listeners.
            @param e an <code>ArchiveNextEvent</code> to be dispatched
            */
            bool fireArchiveNextEvent() {
                bool result = true;
                std::list<stuffit5::event::ArchiveNextListener*> al = archiveNextListeners;
                for (std::list<stuffit5::event::ArchiveNextListener*>::iterator i = al.begin(); i != al.end(); i++)
                    result = result && (*i)->archiveNextEvent();
                return result;
            }

        protected:
            /** A list of registered <code>ArchiveNextListener</code>s. */
            std::list<stuffit5::event::ArchiveNextListener*> archiveNextListeners;
        };
    }
}

#endif

