// $Id: Listener.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_Listener_h_included
#define stuffit5_event_Listener_h_included

#include "un/property.h"

/** Event handler base class.

<p>This class is a base class of engine event handlers that process event
callbacks through their virtual member functions.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

namespace stuffit5 {
    namespace event {
        class Listener {
        public:
            /** Destructor. */
            virtual ~Listener() {
            }

            /** <code>true</code> if the listener is not "owned" by anybody and must be
            deleted when removed from the list of listeners. */
            un::property<bool> orphan;
        };
    }
}

#endif // stuffit5_event_Listener_h_included

