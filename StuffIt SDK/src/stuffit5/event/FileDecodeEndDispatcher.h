// $Id: FileDecodeEndDispatcher.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileDecodeEndDispatcher_h_included
#define stuffit5_event_FileDecodeEndDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/FileDecodeEndListener.h"

/** This class generates event notifications for <code>FileDecodeEndEvent</code>.
It maintains a list of <code>FileDecodeEndListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

namespace stuffit5 {
    namespace event {
        class FileDecodeEndDispatcher {
        public:
            /** Register an <code>FileDecodeEndListener</code> to be periodically notified.
            @param l an <code>FileDecodeEndListener</code> to be added to the notification list
            */
            void addFileDecodeEndListener(stuffit5::event::FileDecodeEndListener* l) {
                fileDecodeEndListeners.push_back(l);
            }

            /** Remove an <code>FileDecodeEndListener</code> from the list of listeners.
            @param l an <code>FileDecodeEndListener</code> to be removed from the notification list
            */
            void removeFileDecodeEndListener(stuffit5::event::FileDecodeEndListener* l) {
                fileDecodeEndListeners.remove(l);
            }

            /** Send an <code>FileDecodeEndEvent</code> to all registered listeners.
            @param e an <code>FileDecodeEndEvent</code> to be dispatched
            */
            void fireFileDecodeEndEvent() {
                std::list<stuffit5::event::FileDecodeEndListener*> al = fileDecodeEndListeners;
                for (std::list<stuffit5::event::FileDecodeEndListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->fileDecodeEndEvent();
            }

        protected:
            /** A list of registered <code>FileDecodeEndListener</code>s. */
            std::list<stuffit5::event::FileDecodeEndListener*> fileDecodeEndListeners;
        };
    }
}

#endif

