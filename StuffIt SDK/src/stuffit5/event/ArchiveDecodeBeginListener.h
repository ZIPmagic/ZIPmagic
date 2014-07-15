// $Id: ArchiveDecodeBeginListener.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveDecodeBeginListener_h_included
#define stuffit5_event_ArchiveDecodeBeginListener_h_included

/** Event handler for the beginning of archive decoding.

<p>This event callback is invoked immediately before the decoding phase begins.

<p>This is last chance to abort processing of the archive before decoding
begins, by returning <code>false</code>.

<p>This is also a good time to change the destination folder property of the
reader, in order to control the location where the files are created in the
process of decoding the archive.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveDecodeBeginListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            virtual ~ArchiveDecodeBeginListener() {
            }

            /** Beginning of archive decoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of archive decoding.

            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool archiveDecodeBeginEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ArchiveDecodeBeginListener_archiveDecodeBeginEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_ArchiveDecodeBeginListener stuffit5_Reader_addArchiveDecodeBeginListener(stuffit5_event_ArchiveDecodeBeginListener_archiveDecodeBeginEvent archiveDecodeBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeArchiveDecodeBeginListener(stuffit5_event_ArchiveDecodeBeginListener archiveDecodeBeginListener, stuffit5_Reader reader);

#endif

#endif

