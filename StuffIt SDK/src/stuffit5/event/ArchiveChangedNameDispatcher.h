// $Id: ArchiveChangedNameDispatcher.h,v 1.2.2.1 2001/07/05 23:32:34 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveChangedNameDispatcher_h_included
#define stuffit5_event_ArchiveChangedNameDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ArchiveChangedNameListener.h"
#include "un/property.h"

/** This class generates event notifications for <code>ArchiveChangedNameEvent</code>.
It maintains a list of <code>ArchiveChangedNameListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:34 $
*/

namespace stuffit5 {
    namespace event {
        class ArchiveChangedNameDispatcher {
        public:
            /** Default constructor. */
            ArchiveChangedNameDispatcher() {
            }

            /** Register an <code>ArchiveChangedNameListener</code> to be periodically notified.
            @param l an <code>ArchiveChangedNameListener</code> to be added to the notification list
            */
            void addArchiveChangedNameListener(stuffit5::event::ArchiveChangedNameListener* l) {
                archiveChangedNameListeners.push_back(l);
            }

            /** Remove an <code>ArchiveChangedNameListener</code> from the list of listeners.
            @param l an <code>ArchiveChangedNameListener</code> to be removed from the notification list
            */
            void removeArchiveChangedNameListener(stuffit5::event::ArchiveChangedNameListener* l) {
                archiveChangedNameListeners.remove(l);
            }

            /** Send an <code>ArchiveChangedNameEvent</code> to all registered listeners.
            @param e an <code>ArchiveChangedNameEvent</code> to be dispatched
            */
            void fireArchiveChangedNameEvent(const char* name) {
                std::list<stuffit5::event::ArchiveChangedNameListener*> al = archiveChangedNameListeners;
                for (std::list<stuffit5::event::ArchiveChangedNameListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->archiveChangedNameEvent(name);
            }

        protected:
            /** A list of registered <code>ArchiveChangedNameListener</code>s. */
            std::list<stuffit5::event::ArchiveChangedNameListener*> archiveChangedNameListeners;
        };
    }
}

#endif

