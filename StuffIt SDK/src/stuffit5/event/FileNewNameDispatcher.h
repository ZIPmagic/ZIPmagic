// $Id: FileNewNameDispatcher.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileNewNameDispatcher_h_included
#define stuffit5_event_FileNewNameDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/FileNewNameListener.h"

/** This class generates event notifications for <code>FileNewNameEvent</code>.
It maintains a list of <code>FileNewNameListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

namespace stuffit5 {
    namespace event {
        class FileNewNameDispatcher {
        public:
            /** Register an <code>FileNewNameListener</code> to be periodically notified.
            @param l an <code>FileNewNameListener</code> to be added to the notification list
            */
            void addFileNewNameListener(stuffit5::event::FileNewNameListener* l) {
                fileNewNameListeners.push_back(l);
            }

            /** Remove an <code>FileNewNameListener</code> from the list of listeners.
            @param l an <code>FileNewNameListener</code> to be removed from the notification list
            */
            void removeFileNewNameListener(stuffit5::event::FileNewNameListener* l) {
                fileNewNameListeners.remove(l);
            }

            /** Send an <code>FileNewNameEvent</code> to all registered listeners.
            @param e an <code>FileNewNameEvent</code> to be dispatched
            */
            void fireFileNewNameEvent() {
                std::list<stuffit5::event::FileNewNameListener*> al = fileNewNameListeners;
                for (std::list<stuffit5::event::FileNewNameListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->fileNewNameEvent();
            }

        protected:
            /** A list of registered <code>FileNewNameListener</code>s. */
            std::list<stuffit5::event::FileNewNameListener*> fileNewNameListeners;
        };
    }
}

#endif

