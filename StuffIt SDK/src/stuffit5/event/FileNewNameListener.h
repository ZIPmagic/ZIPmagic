// $Id: FileNewNameListener.h,v 1.2.2.1 2001/07/05 23:32:36 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileNewNameListener_h_included
#define stuffit5_event_FileNewNameListener_h_included

/** Event handler for an unnamed file.

<p>This event callback is invoked when the reader reads an archive and
encounters a file that does not have a name. This situation may happen in
several formats, such as Btoa, Mime, and Gzip.

<p>Use <code>stuffit5::Reader::newFileName</code> to access the proposed name
of the file the reader is going to try to create, and to assign the new name.
The name is a file name (and not a path name).

<p>The proposed name is generic and is not related to the name of the archive
being read.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:36 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileNewNameListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FileNewNameListener() {
            }

            /** Destructor. */
            virtual ~FileNewNameListener() {
            }

            /** An unnamed file.

            <p>This pure virtual member function is the event callback invoked to handle
            an unnamed file.
            */
            virtual void fileNewNameEvent() = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef void (*stuffit5_event_FileNewNameListener_fileNewNameEvent)(stuffit5_Reader reader);

extern_c exported stuffit5_event_FileNewNameListener stuffit5_Reader_addFileNewNameListener(stuffit5_event_FileNewNameListener_fileNewNameEvent fileNewNameEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFileNewNameListener(stuffit5_event_FileNewNameListener fileNewNameListener, stuffit5_Reader reader);

#endif

#endif

