// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: BehavedWriter.h,v 1.4.2.1 2001/07/05 23:27:20 serge Exp $

#if !defined app_stuff_BehavedWriter_h_included
#define app_stuff_BehavedWriter_h_included

#include <iostream>
#include "app/stuff/Writer.h"

/** This subclass of <code>stuffit5::Writer</code> overrides every event callback
available, and prints information required by the <i>stuff</i> application.

@author serge@aladdinsys.com
@version $Revision: 1.4.2.1 $, $Date: 2001/07/05 23:27:20 $
*/

namespace app {
    namespace stuff {
        class BehavedWriter : public app::stuff::Writer {
        public:
            typedef app::stuff::Writer super;

            /** Default constructor. */
            BehavedWriter() : app::stuff::Writer() {
            }

            /** Destructor. */
            ~BehavedWriter() {
            }

        protected:
            bool archiveCreateBeginEvent() {
                std::cout << "Creating " << archiveInfo().name() << std::endl;
                return super::archiveCreateBeginEvent();
            }

            void archiveCreateEndEvent() {
                std::cout << "done" << std::endl;
                super::archiveCreateEndEvent();
            }

            bool errorEvent(stuffit5::Error::type error) {
                std::cout << "Error: " << stuffit5::Error::description(error) << std::endl;
                return super::errorEvent(error);
            }

            bool fileDeleteEvent() {
                std::cout << "Warning: " << archiveInfo().name() << " is incomplete or damaged" << std::endl;
                return super::fileDeleteEvent();
            }

            bool fileEncodeBeginEvent() {
                std::cout << fileInfo().name() << " " << std::flush;
                return super::fileEncodeBeginEvent();
            }

            void fileEncodeEndEvent() {
                std::cout << std::endl;
                super::fileEncodeEndEvent();
            }

            bool fileScanStepEvent() {
                return super::fileScanStepEvent();
            }

            bool folderEncodeBeginEvent() {
                std::cout << folderInfo().name() << " " << std::endl;
                return super::folderEncodeBeginEvent();
            }

            void folderEncodeEndEvent() {
                super::folderEncodeEndEvent();
            }

            bool folderScanStepEvent() {
                return super::folderScanStepEvent();
            }

            bool progressSizeMoveEvent(uint32_t position) {
                std::cout << "." << std::flush;
                return super::progressSizeMoveEvent(position);
            }
        };
    }
}

#endif // app_stuff_BehavedWriter_h_included

