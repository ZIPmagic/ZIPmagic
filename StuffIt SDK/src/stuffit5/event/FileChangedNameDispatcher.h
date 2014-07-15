// $Id: FileChangedNameDispatcher.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileChangedNameDispatcher_h_included
#define stuffit5_event_FileChangedNameDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/FileChangedNameListener.h"

/** This class generates event notifications for <code>FileChangedNameEvent</code>.
It maintains a list of <code>FileChangedNameListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

namespace stuffit5 {
    namespace event {
        class FileChangedNameDispatcher {
        public:
            /** Register an <code>FileChangedNameListener</code> to be periodically notified.
            @param l an <code>FileChangedNameListener</code> to be added to the notification list
            */
            void addFileChangedNameListener(stuffit5::event::FileChangedNameListener* l) {
                fileChangedNameListeners.push_back(l);
            }

            /** Remove an <code>FileChangedNameListener</code> from the list of listeners.
            @param l an <code>FileChangedNameListener</code> to be removed from the notification list
            */
            void removeFileChangedNameListener(stuffit5::event::FileChangedNameListener* l) {
                fileChangedNameListeners.remove(l);
            }

            /** Send an <code>FileChangedNameEvent</code> to all registered listeners.
            @param e an <code>FileChangedNameEvent</code> to be dispatched
            */
            void fireFileChangedNameEvent(const char* name) {
                std::list<stuffit5::event::FileChangedNameListener*> al = fileChangedNameListeners;
                for (std::list<stuffit5::event::FileChangedNameListener*>::iterator i = al.begin(); i != al.end(); i++)
                    (*i)->fileChangedNameEvent(name);
            }

        protected:
            /** A list of registered <code>FileChangedNameListener</code>s. */
            std::list<stuffit5::event::FileChangedNameListener*> fileChangedNameListeners;
        };
    }
}

#endif

