// $Id: ArchiveDecodeEndDispatcher.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveDecodeEndDispatcher_h_included
#define stuffit5_event_ArchiveDecodeEndDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ArchiveDecodeEndListener.h"

/** This class generates event notifications for <code>ArchiveDecodeEndEvent</code>.
It maintains a list of <code>ArchiveDecodeEndListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

namespace stuffit5 {
    namespace event {
        class ArchiveDecodeEndDispatcher {
        public:
            /** Register an <code>ArchiveDecodeEndListener</code> to be periodically notified.
            @param l an <code>ArchiveDecodeEndListener</code> to be added to the notification list
            */
            void addArchiveDecodeEndListener(stuffit5::event::ArchiveDecodeEndListener* l) {
                archiveDecodeEndListeners.push_back(l);
            }

            /** Remove an <code>ArchiveDecodeEndListener</code> from the list of listeners.
            @param l an <code>ArchiveDecodeEndListener</code> to be removed from the notification list
            */
            void removeArchiveDecodeEndListener(stuffit5::event::ArchiveDecodeEndListener* l) {
                archiveDecodeEndListeners.remove(l);
            }

            /** Send an <code>ArchiveDecodeEndEvent</code> to all registered listeners.
            @param e an <code>ArchiveDecodeEndEvent</code> to be dispatched
            */
            void fireArchiveDecodeEndEvent() {
                std::list<stuffit5::event::ArchiveDecodeEndListener*> al = archiveDecodeEndListeners;
                for (std::list<stuffit5::event::ArchiveDecodeEndListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->archiveDecodeEndEvent();
            }

        protected:
            /** A list of registered <code>ArchiveDecodeEndListener</code>s. */
            std::list<stuffit5::event::ArchiveDecodeEndListener*> archiveDecodeEndListeners;
        };
    }
}

#endif

