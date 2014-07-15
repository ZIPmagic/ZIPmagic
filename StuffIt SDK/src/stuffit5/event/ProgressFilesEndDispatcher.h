// $Id: ProgressFilesEndDispatcher.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressFilesEndDispatcher_h_included
#define stuffit5_event_ProgressFilesEndDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ProgressFilesEndListener.h"

/** This class generates event notifications for <code>ProgressFilesEndEvent</code>.
It maintains a list of <code>ProgressFilesEndListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

namespace stuffit5 {
    namespace event {
        class ProgressFilesEndDispatcher {
        public:
            /** Register an <code>ProgressFilesEndListener</code> to be periodically notified.
            @param l an <code>ProgressFilesEndListener</code> to be added to the notification list
            */
            void addProgressFilesEndListener(stuffit5::event::ProgressFilesEndListener* l) {
                progressFilesEndListeners.push_back(l);
            }

            /** Remove an <code>ProgressFilesEndListener</code> from the list of listeners.
            @param l an <code>ProgressFilesEndListener</code> to be removed from the notification list
            */
            void removeProgressFilesEndListener(stuffit5::event::ProgressFilesEndListener* l) {
                progressFilesEndListeners.remove(l);
            }

            /** Send an <code>ProgressFilesEndEvent</code> to all registered listeners.
            @param e an <code>ProgressFilesEndEvent</code> to be dispatched
            */
            void fireProgressFilesEndEvent() {
                std::list<stuffit5::event::ProgressFilesEndListener*> al = progressFilesEndListeners;
                for (std::list<stuffit5::event::ProgressFilesEndListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->progressFilesEndEvent();
            }

        protected:
            /** A list of registered <code>ProgressFilesEndListener</code>s. */
            std::list<stuffit5::event::ProgressFilesEndListener*> progressFilesEndListeners;
        };
    }
}

#endif

