// $Id: ProgressScanStepListener.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressScanStepListener_h_included
#define stuffit5_event_ProgressScanStepListener_h_included

/** Event handler for the progress of archive scan.

<p>This event callback is invoked to indicate the progress of the scan
phase when no information is available yet on the size of the archive,
or the number of files contained in it.

<p>If the scan phase takes more than a fraction of a second to complete,
this event should be used to drive the progress display to inform the
user that processing is underway. Once the scan phase is complete, other
progress events will provide size and movement information for a
progress bar.

<p>At this phase, there is no way to predict how long the scan phase
will take, so the progress is driven by this <i>periodic</i> event without
any indication of how complete the scan is at the time of this event.

<p>In most archive formats, this event corresponds to a new item being
found in the archive. In most encoded formats, this event corresponds to
a block of the encoded file being 'digested'.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressScanStepListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ProgressScanStepListener() {
            }

            /** Destructor. */
            virtual ~ProgressScanStepListener() {
            }

            /** Progress of archive scan.

            <p>This pure virtual member function is the event callback invoked to indicate the
            progress of archive scan.
            */
            virtual bool progressScanStepEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ProgressScanStepListener_progressScanStepEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressScanStepListener stuffit5_Reader_addProgressScanStepListener(stuffit5_event_ProgressScanStepListener_progressScanStepEvent progressScanStepEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressScanStepListener(stuffit5_event_ProgressScanStepListener progressScanStepListener, stuffit5_Reader reader);

#endif

#endif

