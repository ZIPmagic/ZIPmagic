// $Id: ArchiveSizeListener.h,v 1.3.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveSizeListener_h_included
#define stuffit5_event_ArchiveSizeListener_h_included

/** Event handler for archive size.

<p>This event callback is invoked when a writer needs to determine the maximum
size of the next archive segment of a multi-segment archive.

<p>Use <code>stuffit5::Writer::archiveSize()</code> or
<code>getWriterArchiveSize)()</code> and <code>setWriterArchiveSize)()</code> to
obtain the proposed size of the next segment the writer is going to try to
create, and to change this size, respectively.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:35 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveSizeListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ArchiveSizeListener() {
            }

            /** Destructor. */
            virtual ~ArchiveSizeListener() {
            }

            /** Archive size.

            <p>This pure virtual member function is the event callback invoked to determine
            the size of the next archive segment.
            */
            virtual void archiveSizeEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ArchiveSizeListener_archiveSizeEvent)(stuffit5_Writer writer);

extern_c exported stuffit5_event_ArchiveSizeListener stuffit5_Writer_addArchiveSizeListener(stuffit5_event_ArchiveSizeListener_archiveSizeEvent archiveSizeEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeArchiveSizeListener(stuffit5_event_ArchiveSizeListener archiveSizeListener, stuffit5_Writer writer);

#endif

#endif

