// $Id: ProgressFilesMoveListener.h,v 1.3.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressFilesMoveListener_h_included
#define stuffit5_event_ProgressFilesMoveListener_h_included

#include "un/stdint.h"

/** Event handler for the progress of file count in archive decoding or
creation.

<p>This event callback is invoked to update the state of the decoding phase (in
readers) and at the beginning of archive creation (in writers), when an item is
completely decoded or encoded. It communicates the fact that <code>size</code>
items have been processed.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:37 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressFilesMoveListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ProgressFilesMoveListener() {
            }

            /** Destructor. */
            virtual ~ProgressFilesMoveListener() {
            }

            /** Progress of file count in archive decoding or creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            progress of of file count in archive decoding or creation.

            @param position the number of items decoded
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool progressFilesMoveEvent(uint32_t position) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ProgressFilesMoveListener_progressFilesMoveEvent)(uint32_t position, stuffit5_Reader reader);
//typedef bool (*stuffit5_event_ProgressFilesMoveListener_progressFilesMoveEvent)(uint32_t position, stuffit5_Writer writer);

extern_c exported stuffit5_event_ProgressFilesMoveListener stuffit5_Reader_addProgressFilesMoveListener(stuffit5_event_ProgressFilesMoveListener_progressFilesMoveEvent progressFilesMoveEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressFilesMoveListener(stuffit5_event_ProgressFilesMoveListener progressFilesMoveListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressFilesMoveListener stuffit5_Writer_addProgressFilesMoveListener(stuffit5_event_ProgressFilesMoveListener_progressFilesMoveEvent progressFilesMoveEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeProgressFilesMoveListener(stuffit5_event_ProgressFilesMoveListener progressFilesMoveListener, stuffit5_Writer writer);

#endif

#endif

