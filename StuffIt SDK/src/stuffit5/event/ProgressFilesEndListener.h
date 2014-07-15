// $Id: ProgressFilesEndListener.h,v 1.3.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressFilesEndListener_h_included
#define stuffit5_event_ProgressFilesEndListener_h_included

/** Event handler for the end of file count in archive decoding or creation.

<p>This event callback is invoked at the end of the decoding phase (in readers)
and at the beginning of archive creation (in writers).  It is similar to
<code>ProgressSizeEndEvent</code>, but it completes counting the number of items
processed, instead of their sizes.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:37 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressFilesEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ProgressFilesEndListener() {
            }

            /** Destructor. */
            virtual ~ProgressFilesEndListener() {
            }

            /** End of file count in archive decoding or creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of file count in archive decoding or creation.
            */
            virtual void progressFilesEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_ProgressFilesEndListener_progressFilesEndEvent)(stuffit5_Reader reader);
//typedef void (*stuffit5_event_ProgressFilesEndListener_progressFilesEndEvent)(stuffit5_Writer writer);

extern_c exported stuffit5_event_ProgressFilesEndListener stuffit5_Reader_addProgressFilesEndListener(stuffit5_event_ProgressFilesEndListener_progressFilesEndEvent progressFilesEndEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressFilesEndListener(stuffit5_event_ProgressFilesEndListener progressFilesEndListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressFilesEndListener stuffit5_Writer_addProgressFilesEndListener(stuffit5_event_ProgressFilesEndListener_progressFilesEndEvent progressFilesEndEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeProgressFilesEndListener(stuffit5_event_ProgressFilesEndListener progressFilesEndListener, stuffit5_Writer writer);

#endif

#endif

