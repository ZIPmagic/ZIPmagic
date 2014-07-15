// $Id: ProgressSizeEndListener.h,v 1.3.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressSizeEndListener_h_included
#define stuffit5_event_ProgressSizeEndListener_h_included

/** Event handler for the end of archive decoding or creation.

<p>This event callback is invoked at the end of the decoding phase (in readers)
and at the end of archive creation (in writers).

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:37 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressSizeEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ProgressSizeEndListener() {
            }

            /** Destructor. */
            virtual ~ProgressSizeEndListener() {
            }

            /** End of archive decoding or creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of archive decoding or creation.
            */
            virtual void progressSizeEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ProgressSizeEndListener_progressSizeEndEvent)(stuffit5_Reader reader);
//typedef void (*stuffit5_event_ProgressSizeEndListener_progressSizeEndEvent)(stuffit5_Writer writer);

extern_c exported stuffit5_event_ProgressSizeEndListener stuffit5_Reader_addProgressSizeEndListener(stuffit5_event_ProgressSizeEndListener_progressSizeEndEvent progressSizeEndEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressSizeEndListener(stuffit5_event_ProgressSizeEndListener progressSizeEndListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressSizeEndListener stuffit5_Writer_addProgressSizeEndListener(stuffit5_event_ProgressSizeEndListener_progressSizeEndEvent progressSizeEndEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeProgressSizeEndListener(stuffit5_event_ProgressSizeEndListener progressSizeEndListener, stuffit5_Writer writer);

#endif

#endif

