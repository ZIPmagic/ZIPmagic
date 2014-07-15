// $Id: ProgressSizeMoveListener.h,v 1.3.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressSizeMoveListener_h_included
#define stuffit5_event_ProgressSizeMoveListener_h_included

#include "un/stdint.h"

/** Event handler for the progress of archive decoding or creation.

<p>This event callback is invoked to update the state of the decoding phase (in
readers) and at the beginning of archive creation (in writers) and is normally
used to position the progress bar indicator for the ongoing archive decoding or
creation operation.

<p>The last event callback of this type is at or close to 100% of the scale
defined in the <code>ProgressSizeBeginEvent</code>. However, because of possible
minor discrepancies in file sizes that cannot be exactly accounted for before
decoding is complete it is possible that <code>size</code> exceeds or never
reaches 100% of the scale.

<p>Conditions that may cause the final progress state to deviate from 100% are,
for example, size differences caused by text conversion, or extraneous
information between parts of uuencoded files.

<p>This event callback may be invoked even when a file inside an archive is
being skipped during decoding.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:37 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressSizeMoveListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            virtual ~ProgressSizeMoveListener() {
            }

            /** Progress of archive decoding or creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            progress of archive decoding or creation.

            @param position the position of the progress bar
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool progressSizeMoveEvent(uint32_t position) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ProgressSizeMoveListener_progressSizeMoveEvent)(uint32_t position, stuffit5_Reader reader);
//typedef bool (*stuffit5_event_ProgressSizeMoveListener_progressSizeMoveEvent)(uint32_t position, stuffit5_Writer writer);

extern_c exported stuffit5_event_ProgressSizeMoveListener stuffit5_Reader_addProgressSizeMoveListener(stuffit5_event_ProgressSizeMoveListener_progressSizeMoveEvent progressSizeMoveEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressSizeMoveListener(stuffit5_event_ProgressSizeMoveListener progressSizeMoveListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressSizeMoveListener stuffit5_Writer_addProgressSizeMoveListener(stuffit5_event_ProgressSizeMoveListener_progressSizeMoveEvent progressSizeMoveEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeProgressSizeMoveListener(stuffit5_event_ProgressSizeMoveListener progressSizeMoveListener, stuffit5_Writer writer);

#endif

#endif

