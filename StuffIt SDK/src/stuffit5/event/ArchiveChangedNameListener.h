// $Id: ArchiveChangedNameListener.h,v 1.3.2.2 2001/07/05 23:32:34 serge Exp $
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
// $Id: ArchiveChangedNameListener.h,v 1.3.2.2 2001/07/05 23:32:34 serge Exp $

#if !defined stuffit5_event_ArchiveChangedNameListener_h_included
#define stuffit5_event_ArchiveChangedNameListener_h_included

/** Event handler for archive name change.

<p>This event callback is invoked when the writer is forced to change the name
of the archive in order to avoid a name conflict, or to make the name comply
with the target platform file name restrictions.

<p>This event happens only when the archive name is not a legal name on the
target platform, or a file with the same name already exists at the same
location, and either one or both of these were not corrected in the customized
callback for the <code>ArchiveCreateBeginEvent</code>.

<p><code>name</code> is the path name corresponding to the new name
assigned to the archive to be created.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.2 $, $Date: 2001/07/05 23:32:34 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ArchiveChangedNameListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            ~ArchiveChangedNameListener() {
            }

            /** Archive name change.

            <p>This pure virtual member function is the event callback invoked to indicate an
            archive name change.

            @param name the new archive name
            */
            virtual void archiveChangedNameEvent(const char* name) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ArchiveChangedNameListener_archiveChangedNameEvent)(const char* name, stuffit5_Writer writer);

extern_c exported stuffit5_event_ArchiveChangedNameListener stuffit5_Writer_addArchiveChangedNameListener(stuffit5_event_ArchiveChangedNameListener_archiveChangedNameEvent archiveChangedNameEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeArchiveChangedNameListener(stuffit5_event_ArchiveChangedNameListener archiveChangedNameListener, stuffit5_Writer writer);

#endif

#endif

