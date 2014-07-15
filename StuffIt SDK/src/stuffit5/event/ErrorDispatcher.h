// $Id: ErrorDispatcher.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ErrorDispatcher_h_included
#define stuffit5_event_ErrorDispatcher_h_included

#include "un/warnings.h"
#include <list>
#include "stuffit5/event/ErrorListener.h"

/** This class generates event notifications for <code>ErrorEvent</code>.
It maintains a list of <code>ErrorListener</code>s.

<p>The implementation of this class makes a copy of the listener list when
firing events. This allows listeners to be safely added and removed during
event handling but it may lead to performance problems in environments
where events are used frequently.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

namespace stuffit5 {
    namespace event {
        class ErrorDispatcher {
        public:
            /** Register an <code>ErrorListener</code> to be periodically notified.
            @param l an <code>ErrorListener</code> to be added to the notification list
            */
            void addErrorListener(stuffit5::event::ErrorListener* l) {
                errorListeners.push_back(l);
            }

            /** Remove an <code>ErrorListener</code> from the list of listeners.
            @param l an <code>ErrorListener</code> to be removed from the notification list
            */
            void removeErrorListener(stuffit5::event::ErrorListener* l) {
                errorListeners.remove(l);
                if (l->orphan())
                    delete l;
            }

            /** Send an <code>ErrorEvent</code> to all registered listeners.
            @param e an <code>ErrorEvent</code> to be dispatched
            */
            bool fireErrorEvent(stuffit5::Error::type error) {
                bool result = true;
                std::list<stuffit5::event::ErrorListener*> al = errorListeners;
                for (std::list<stuffit5::event::ErrorListener*>::iterator i = al.begin(); i != al.end(); i++)
                    result = result && (*i)->errorEvent(error);
                return result;
            }

        protected:
            /** A list of registered <code>ErrorListener</code>s. */
            std::list<stuffit5::event::ErrorListener*> errorListeners;
        };
    }
}

#endif

