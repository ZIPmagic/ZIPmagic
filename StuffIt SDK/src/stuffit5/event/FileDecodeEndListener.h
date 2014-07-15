// $Id: FileDecodeEndListener.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileDecodeEndListener_h_included
#define stuffit5_event_FileDecodeEndListener_h_included

/** Event handler for the end of file decoding.

<p>This event callback is invoked to indicate the end of decoding of each file.

<p>At the time of this event, the output file generated in the decoding
operation from the archive is closed.

<p>This is the time to apply further conversions to the file, modify its
attributes, move it, mail it, etc.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileDecodeEndListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FileDecodeEndListener() {
            }

            /** Destructor. */
            virtual ~FileDecodeEndListener() {
            }

            /** End of file decoding.

            <p>This pure virtual member function is the event callback invoked to indicate the
            end of file decoding.
            */
            virtual void fileDecodeEndEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_FileDecodeEndListener_fileDecodeEndEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_FileDecodeEndListener stuffit5_Reader_addFileDecodeEndListener(stuffit5_event_FileDecodeEndListener_fileDecodeEndEvent fileDecodeEndEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFileDecodeEndListener(stuffit5_event_FileDecodeEndListener fileDecodeEndListener, stuffit5_Reader reader);

#endif

#endif

