// $Id: ProgressSizeBeginListener.h,v 1.3.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressSizeBeginListener_h_included
#define stuffit5_event_ProgressSizeBeginListener_h_included

#include "un/stdint.h"

/** Event handler for the beginning of archive decoding or creation.

<p>This event callback is invoked at the beginning of the decoding phase
(in readers) and at the beginning of archive creation (in writers).

<p>It carries the <code>size</code> argument that determines the logical size
(scale) of the progress bar. All further progress events that provide progress
information use this scale.

<p><code>size</code> does not necessarily represent the actual compressed or
uncompressed size of the files being processed.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:37 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressSizeBeginListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            virtual ~ProgressSizeBeginListener() {
            }

            /** Beginning of archive decoding or creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of archive decoding or creation.

            @param size the size (scale) of the progress bar
            */
            virtual void progressSizeBeginEvent(uint32_t size) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ProgressSizeBeginListener_progressSizeBeginEvent)(uint32_t size, stuffit5_Reader reader);
//typedef void (*stuffit5_event_ProgressSizeBeginListener_progressSizeBeginEvent)(uint32_t size, stuffit5_Writer writer);

extern_c exported stuffit5_event_ProgressSizeBeginListener stuffit5_Reader_addProgressSizeBeginListener(stuffit5_event_ProgressSizeBeginListener_progressSizeBeginEvent progressSizeBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressSizeBeginListener(stuffit5_event_ProgressSizeBeginListener progressSizeBeginListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressSizeBeginListener stuffit5_Writer_addProgressSizeBeginListener(stuffit5_event_ProgressSizeBeginListener_progressSizeBeginEvent progressSizeBeginEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeProgressSizeBeginListener(stuffit5_event_ProgressSizeBeginListener progressSizeBeginListener, stuffit5_Writer writer);

#endif

#endif

