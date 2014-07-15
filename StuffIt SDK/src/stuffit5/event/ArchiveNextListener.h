// $Id: ArchiveNextListener.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ArchiveNextListener_h_included
#define stuffit5_event_ArchiveNextListener_h_included

/** Event handler for the next segment of a multi-segment archive.

<p>This event callback is invoked when a reader is looking for the next segment
of a multi-segment archive.

<p>Use <code>stuffit5::ArchiveInfo::name()</code>
(<code>getReaderArchiveName()</code>) and
<code>stuffit5::ArchiveInfo::name(std::string&)</code>
(<code>setReaderArchiveName()</code>) to obtain the proposed name of the next
segment the reader is going to try to process, and to change this name,
respectively.

<p>This event callback may be used to point the reader to the next archive
segment that it would not be able to find otherwise.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveNextListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ArchiveNextListener() {
            }

            /** Destructor. */
            virtual ~ArchiveNextListener() {
            }

            /** Next segment of a multi-segment archive.

            <p>This pure virtual member function is the event callback invoked to determine
            the next segment of a multi-segment archive.

            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool archiveNextEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ArchiveNextListener_archiveNextEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_ArchiveNextListener stuffit5_Reader_addArchiveNextListener(stuffit5_event_ArchiveNextListener_archiveNextEvent archiveNextEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeArchiveNextListener(stuffit5_event_ArchiveNextListener archiveNextListener, stuffit5_Reader reader);

#endif

#endif

