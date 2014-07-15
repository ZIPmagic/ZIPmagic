// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ThreadedReader.h,v 1.4 2001/03/09 09:52:03 serge Exp $

#if !defined app_stuff_ThreadedReader_h_included
#define app_stuff_ThreadedReader_h_included

#include <string>
#include <windows.h>
#include "app/unstuff/ChattyReader.h"
#include "un/property.h"

/** This subclass of <code>stuffit5::Reader</code> runs in a thread of its own,
overrides every event callback available, and prints information about each callback,
along with relevant property values.

@author serge@aladdinsys.com
@version $Revision: 1.4 $, $Date: 2001/03/09 09:52:03 $
*/

namespace app {
    namespace unstuff {
        class ThreadedReader : public app::unstuff::ChattyReader {
        public:
            /** Default constructor. */
            ThreadedReader() : app::unstuff::ChattyReader() {
                InitializeCriticalSection(&ThreadedReader::coutLock);
            }

            /** Destructor. */
            ~ThreadedReader() {
            }

            static unsigned long WINAPI start(void* p);

            void process();

            un::property<int> id;
            un::property<std::string> name;

        protected:
            static CRITICAL_SECTION coutLock;

            void acquireCout(){
                EnterCriticalSection(&ThreadedReader::coutLock);
            }

            void releaseCout() {
                LeaveCriticalSection(&ThreadedReader::coutLock);
            }

            bool archiveDecodeBeginEvent();

            void archiveDecodeEndEvent();

            bool archiveInfoEvent();

            bool archiveNextEvent();

            bool errorEvent(stuffit5::Error::type error);

            void fileChangedNameEvent(const char* name);

            bool fileDecodeBeginEvent(uint32_t position);

            void fileDecodeEndEvent();

            bool fileDeleteEvent();

            bool fileInfoEvent(uint32_t position);

            void fileNewNameEvent();

            bool folderDecodeBeginEvent(uint32_t position);

            void folderDecodeEndEvent();

            bool folderInfoEvent(uint32_t position);

            void progressFilesBeginEvent(uint32_t size);

            void progressFilesEndEvent();

            bool progressFilesMoveEvent(uint32_t position);

            void progressScanBeginEvent();

            void progressScanEndEvent();

            bool progressScanStepEvent();

            void progressSizeBeginEvent(uint32_t size);

            void progressSizeEndEvent();

            bool progressSizeMoveEvent(uint32_t position);
        };
    }
}

#endif // app_stuff_ThreadedReader_h_included

