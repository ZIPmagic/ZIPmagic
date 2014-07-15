// $Id: FileEncodeEndListener.h,v 1.3.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileEncodeEndListener_h_included
#define stuffit5_event_FileEncodeEndListener_h_included

/** Event handler for the end of file encoding.

<p>This event callback is invoked immediately after each file has been added to
the archive.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:36 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileEncodeEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FileEncodeEndListener() {
            }

            /** Destructor. */
            virtual ~FileEncodeEndListener() {
            }

            /** End of file encoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of file encoding.
            */
            virtual void fileEncodeEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_FileEncodeEndListener_fileEncodeEndEvent)(stuffit5_Writer writer);

extern_c exported stuffit5_event_FileEncodeEndListener stuffit5_Writer_addFileEncodeEndListener(stuffit5_event_FileEncodeEndListener_fileEncodeEndEvent fileEncodeEndEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeFileEncodeEndListener(stuffit5_event_FileEncodeEndListener fileEncodeEndListener, stuffit5_Writer writer);

#endif

#endif

