// $Id: ProgressFilesBeginListener.h,v 1.3.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ProgressFilesBeginListener_h_included
#define stuffit5_event_ProgressFilesBeginListener_h_included

#include "un/stdint.h"

/** Event handler for the beginning of file count in archive decoding or
creation.

<p>This event callback is invoked at the beginning of the decoding phase (in
readers) and at the beginning of archive creation (in writers).

<p>It carries the <code>size</code> argument that determines the number of
items (files and/or folders) to be decoded or placed into the archive.

<p>This event callback is similar to the <code>ProgressSizeBeginEvent</code>,
but begins a sequence of progress updates dealing with item counting in the
archive being decoded or created, instead of their sizes.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:37 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ProgressFilesBeginListener : public stuffit5::event::Listener {
        public:
            /** Default constructor. */
            ProgressFilesBeginListener() {
            }

            /** Destructor. */
            virtual ~ProgressFilesBeginListener() {
            }

            /** Beginning of file count in archive decoding or creation.

            <p>This pure virtual member function is the event callback invoked to indicate the
            beginning of file count in archive decoding or creation.

            @param size number of items contained in the archive being decoded
            */
            virtual void progressFilesBeginEvent(uint32_t size) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ProgressFilesBeginListener_progressFilesBeginEvent)(uint32_t size, stuffit5_Reader reader);
//typedef bool (*stuffit5_event_ProgressFilesBeginListener_progressFilesBeginEvent)(uint32_t size, stuffit5_Writer writer);

extern_c exported stuffit5_event_ProgressFilesBeginListener stuffit5_Reader_addProgressFilesBeginListener(stuffit5_event_ProgressFilesBeginListener_progressFilesBeginEvent progressFilesBeginEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeProgressFilesBeginListener(stuffit5_event_ProgressFilesBeginListener progressFilesBeginListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ProgressFilesBeginListener stuffit5_Writer_addProgressFilesBeginListener(stuffit5_event_ProgressFilesBeginListener_progressFilesBeginEvent progressFilesBeginEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeProgressFilesBeginListener(stuffit5_event_ProgressFilesBeginListener progressFilesBeginListener, stuffit5_Writer writer);

#endif

#endif

