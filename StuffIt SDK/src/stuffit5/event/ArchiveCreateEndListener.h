// $Id: ArchiveCreateEndListener.h,v 1.3.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveCreateEndListener_h_included
#define stuffit5_event_ArchiveCreateEndListener_h_included

/** Event handler for the end of archive creation.

<p>This event callback is invoked to indicate completion of archive creation.

<p>At the time of this event, the newly created archive is closed.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:35 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveCreateEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ArchiveCreateEndListener() {
            }

            /** Destructor. */
            virtual ~ArchiveCreateEndListener() {
            }

            /** End of archive creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of archive creation.
            */
            virtual void archiveCreateEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ArchiveCreateEndListener_archiveCreateEndEvent)(stuffit5_Writer writer);

extern_c exported stuffit5_event_ArchiveCreateEndListener stuffit5_Writer_addArchiveCreateEndListener(stuffit5_event_ArchiveCreateEndListener_archiveCreateEndEvent archiveCreateEndEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeArchiveCreateEndListener(stuffit5_event_ArchiveCreateEndListener archiveCreateEndListener, stuffit5_Writer writer);

#endif

#endif

