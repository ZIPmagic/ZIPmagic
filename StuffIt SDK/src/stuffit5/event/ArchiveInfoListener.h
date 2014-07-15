// $Id: ArchiveInfoListener.h,v 1.3.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveInfoListener_h_included
#define stuffit5_event_ArchiveInfoListener_h_included

/** Event handler for archive information.

<p>This event callback is invoked during the scan of the archive. It provides
additional information about the archive which may be used to decide how (or
whether) the archive should be scanned and/or decoded later.

<p>For example, if the total uncompressed size of all files the archive contains
is greater than the space available on the destination volume, this event may be
used to warn the user that the destination volume can't hold that much data.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveInfoListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ArchiveInfoListener() {
            }

            /** Destructor. */
            virtual ~ArchiveInfoListener() {
            }

            /** Archive information.

            <p>This pure virtual member function is the event callback invoked to indicate
            availability of archive information.

            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool archiveInfoEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ArchiveInfoListener_archiveInfoEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_ArchiveInfoListener stuffit5_Reader_addArchiveInfoListener(stuffit5_event_ArchiveInfoListener_archiveInfoEvent archiveInfoEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeArchiveInfoListener(stuffit5_event_ArchiveInfoListener archiveInfoListener, stuffit5_Reader reader);

#endif

#endif

