// $Id: ProgressScanBeginListener.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressScanBeginListener_h_included
#define stuffit5_event_ProgressScanBeginListener_h_included

/** Event handler for the beginning of archive scan.

<p>This event callback is invoked to indicate the beginning of the scan phase
that precedes every decoding operation.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressScanBeginListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ProgressScanBeginListener() {
            }

            /** Destructor. */
            virtual ~ProgressScanBeginListener() {
            }

            /** Beginning of archive scan.

            <p>This pure virtual member function is the event callback invoked
            to indicate the beginning of archive scan.
            */
            virtual void progressScanBeginEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ProgressScanBeginListener_progressScanBeginEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressScanBeginListener stuffit5_Reader_addProgressScanBeginListener(stuffit5_event_ProgressScanBeginListener_progressScanBeginEvent progressScanBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressScanBeginListener(stuffit5_event_ProgressScanBeginListener progressScanBeginListener, stuffit5_Reader reader);

#endif

#endif

