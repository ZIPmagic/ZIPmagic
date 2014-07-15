// $Id: ArchiveInfoDispatcher.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveInfoDispatcher_h_included
#define stuffit5_event_ArchiveInfoDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ArchiveInfoListener.h"

/** This class generates event notifications for <code>ArchiveInfoEvent</code>.
It maintains a list of <code>ArchiveInfoListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

namespace stuffit5 {
    namespace event {
        class ArchiveInfoDispatcher {
        public:
            /** Register an <code>ArchiveInfoListener</code> to be periodically notified.
            @param l an <code>ArchiveInfoListener</code> to be added to the notification list
            */
            void addArchiveInfoListener(stuffit5::event::ArchiveInfoListener* l) {
                archiveInfoListeners.push_back(l);
            }

            /** Remove an <code>ArchiveInfoListener</code> from the list of listeners.
            @param l an <code>ArchiveInfoListener</code> to be removed from the notification list
            */
            void removeArchiveInfoListener(stuffit5::event::ArchiveInfoListener* l) {
                archiveInfoListeners.remove(l);
            }

            /** Send an <code>ArchiveInfoEvent</code> to all registered listeners.
            @param e an <code>ArchiveInfoEvent</code> to be dispatched
            */
            bool fireArchiveInfoEvent() {
                bool result = true;
                std::list<stuffit5::event::ArchiveInfoListener*> al = archiveInfoListeners;
                for (std::list<stuffit5::event::ArchiveInfoListener*>::iterator i = al.begin(); i != al.end(); i++)
                    result = result && (*i)->archiveInfoEvent();
                return result;
            }

        protected:
            /** A list of registered <code>ArchiveInfoListener</code>s. */
            std::list<stuffit5::event::ArchiveInfoListener*> archiveInfoListeners;
        };
    }
}

#endif

