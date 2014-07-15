// $Id: ErrorForwarder.h,v 1.1.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ErrorForwarder_h_included
#define stuffit5_event_ErrorForwarder_h_included

/** Forwarding event listener. Forwards engine events from virtual member functions
to C-style callback functions.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#include "stuffit5/event/ErrorListener.h"

namespace stuffit5 {
    namespace event {
        class ErrorForwarder : public stuffit5::event::ErrorListener {
        public:
            ErrorForwarder(stuffit5_event_ErrorListener_errorEvent errorEvent, stuffit5_Reader reader) :
                ErrorListener(),
                reader(reader),
                callback(errorEvent) {
                orphan(true);
            }

            virtual bool errorEvent(stuffit5::Error::type error) {
                return (*callback)(error, reader);
            }

        private:
            const stuffit5_Reader reader;
            const stuffit5_event_ErrorListener_errorEvent callback;
        };
    }
}

#endif

