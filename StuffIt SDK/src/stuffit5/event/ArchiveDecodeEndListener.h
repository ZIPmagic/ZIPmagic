// $Id: ArchiveDecodeEndListener.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveDecodeEndListener_h_included
#define stuffit5_event_ArchiveDecodeEndListener_h_included

/** Event handler for the end of archive decoding.

<p>This event callback is invoked to indicate completion of the decoding phase.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveDecodeEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ArchiveDecodeEndListener() {
            }

            /** Destructor. */
            virtual ~ArchiveDecodeEndListener() {
            }

            /** End of archive decoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of archive decoding.
            */
            virtual void archiveDecodeEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ArchiveDecodeEndListener_archiveDecodeEndEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_ArchiveDecodeEndListener stuffit5_Reader_addArchiveDecodeEndListener(stuffit5_event_ArchiveDecodeEndListener_archiveDecodeEndEvent archiveDecodeEndEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeArchiveDecodeEndListener(stuffit5_event_ArchiveDecodeEndListener archiveDecodeEndListener, stuffit5_Reader reader);

#endif

#endif

