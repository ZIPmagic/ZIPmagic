// $Id: ArchiveCreateBeginListener.h,v 1.3.2.2 2001/07/05 23:32:34 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ArchiveCreateBeginListener.h,v 1.3.2.2 2001/07/05 23:32:34 serge Exp $

#if !defined stuffit5_event_ArchiveCreateBeginListener_h_included
#define stuffit5_event_ArchiveCreateBeginListener_h_included

/** Event handler for the beginning of archive creation.

<p>This event callback is invoked immediately before archive creation begins.

<p>This is last chance to abort creation of the new archive before encoding
begins, by returning <code>false</code>.

<p>This is also the last time when the path name of the archive (the location
and the name of the archive) can be changed by using
<code>stuffit5::ArchiveInfo::name(std::string&)</code> or
<code>setWriterArchiveName()</code>.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.2 $, $Date: 2001/07/05 23:32:34 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveCreateBeginListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ArchiveCreateBeginListener() {
            }

            /** Destructor. */
            ~ArchiveCreateBeginListener() {
            }

            /** Beginning of archive creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of archive creation.

            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool archiveCreateBeginEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ArchiveCreateBeginListener_archiveCreateBeginEvent)(stuffit5_Writer writer);

extern_c exported stuffit5_event_ArchiveCreateBeginListener stuffit5_Writer_addArchiveCreateBeginListener(stuffit5_event_ArchiveCreateBeginListener_archiveCreateBeginEvent archiveCreateBeginEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeArchiveCreateBeginListener(stuffit5_event_ArchiveCreateBeginListener archiveCreateBeginListener, stuffit5_Writer writer);

#endif

#endif

