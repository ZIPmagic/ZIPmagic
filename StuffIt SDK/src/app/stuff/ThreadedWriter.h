// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ThreadedWriter.h,v 1.5 2001/03/09 09:52:03 serge Exp $

#if !defined app_stuff_ThreadedWriter_h_included
#define app_stuff_ThreadedWriter_h_included

#include <string>
#include <windows.h>
#include "app/stuff/Writer.h"
#include "un/property.h"

/** This subclass of <code>stuffit5::Writer</code> runs in a thread of its own,
overrides every event callback available, and prints information about each callback,
along with relevant property values.

@author serge@aladdinsys.com
@version $Revision: 1.5 $, $Date: 2001/03/09 09:52:03 $
*/

namespace app {
    namespace stuff {
        class ThreadedWriter : public app::stuff::Writer {
        public:
            /** Default constructor. */
            ThreadedWriter() : app::stuff::Writer() {
                InitializeCriticalSection(&ThreadedWriter::coutLock);
            }

            /** Destructor. */
            ~ThreadedWriter() {
            }

            static unsigned long WINAPI start(void* p);

            void process();

            un::property<int> id;
            un::property<std::string> name;
            un::property<std::string> formatName;

        protected:
            static CRITICAL_SECTION coutLock;

            void acquireCout(){
                EnterCriticalSection(&ThreadedWriter::coutLock);
            }

            void releaseCout() {
                LeaveCriticalSection(&ThreadedWriter::coutLock);
            }

            void archiveChangedNameEvent(const char* name);

            bool archiveCreateBeginEvent();

            void archiveCreateEndEvent();

            void archiveSizeEvent();

            bool errorEvent(stuffit5::Error::type error);

            bool fileDeleteEvent();

            bool fileEncodeBeginEvent();

            void fileEncodeEndEvent();

            bool fileScanStepEvent();

            bool folderEncodeBeginEvent();

            void folderEncodeEndEvent();

            bool folderScanStepEvent();

            void progressFilesBeginEvent(uint32_t size);

            void progressFilesEndEvent();

            bool progressFilesMoveEvent(uint32_t position);

            void progressSizeBeginEvent(uint32_t size);

            void progressSizeEndEvent();

            bool progressSizeMoveEvent(uint32_t position);
        };
    }
}

#endif // app_stuff_ThreadedWriter_h_included

