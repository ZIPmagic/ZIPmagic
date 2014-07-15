// $Id: FileScanStepListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileScanStepListener_h_included
#define stuffit5_event_FileScanStepListener_h_included

/** Event handler for file scan progress.

<p>This event callback is invoked for every file that the writer finds during
the scan phase of archive creation.

<p>The names reported in this event are saved in the writer for further
processing. Creation of the archive does not begin until all files and folders
that need to be added to the archive have been found.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileScanStepListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FileScanStepListener() {
            }

            /** Destructor. */
            virtual ~FileScanStepListener() {
            }

            /** File scan progress.

            <p>This pure virtual member function is the event callback invoked to indicate
            the progress of the scan phase of archive creation.

            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool fileScanStepEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FileScanStepListener_fileScanStepEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_FileScanStepListener stuffit5_Reader_addFileScanStepListener(stuffit5_event_FileScanStepListener_fileScanStepEvent fileScanStepEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFileScanStepListener(stuffit5_event_FileScanStepListener fileScanStepListener, stuffit5_Reader reader);

#endif

#endif

