// $Id: FileChangedNameListener.h,v 1.2.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_FileChangedNameListener_h_included
#define stuffit5_event_FileChangedNameListener_h_included

/** Event handler for file name change.

<p>This event callback is invoked when the reader is forced to change the name
of an output file in order to avoid a name conflict, or to make the name comply
with the target platform file name restrictions.

<p>This event happens only when an output file name is not a legal name on the
target platform, or a file with the same name already exists at the same
location, and either one or both of these were not corrected in the customized
callback for the <code>FileChangedNameEvent</code>.

<p><code>fileName</code> is the path name corresponding to the new file name
assigned to the output file to be created.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:35 $
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class FileChangedNameListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            FileChangedNameListener() {
            }

            /** Destructor. */
            virtual ~FileChangedNameListener() {
            }

            /** File name change.

            <p>This pure virtual member function is the event callback invoked to indicate a
            file name change.

            @param name the new file name
            */
            virtual void fileChangedNameEvent(const char* name) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_FileChangedNameListener_fileChangedNameEvent)(const char* name, stuffit5_Reader reader);

extern_c exported stuffit5_event_FileChangedNameListener stuffit5_Reader_addFileChangedNameListener(stuffit5_event_FileChangedNameListener_fileChangedNameEvent fileChangedNameEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeFileChangedNameListener(stuffit5_event_FileChangedNameListener fileChangedNameListener, stuffit5_Reader reader);

#endif

#endif

