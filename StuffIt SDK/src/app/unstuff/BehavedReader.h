// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: BehavedReader.h,v 1.4 2001/03/09 09:52:03 serge Exp $

#if !defined app_unstuff_BehavedReader_h_included
#define app_unstuff_BehavedReader_h_included

#include <iostream>
#include "app/unstuff/Reader.h"

/** This subclass of <code>stuffit5::Reader</code> overrides every event callback
available, and prints information required by the <i>unstuff</i> application.

@author serge@aladdinsys.com
@version $Revision: 1.4 $, $Date: 2001/03/09 09:52:03 $
*/

namespace app {
    namespace unstuff {
        class BehavedReader : public app::unstuff::Reader {
        public:
            /** Default constructor. */
            typedef app::unstuff::Reader super;

            /** Default constructor. */
            BehavedReader() : app::unstuff::Reader() {
            }

            /** Destructor. */
            ~BehavedReader() {
            }

        protected:
            bool archiveDecodeBeginEvent() {
                std::cout << "Expanding " << archiveInfo().name() << std::endl;
                return super::archiveDecodeBeginEvent();
            }

            void archiveDecodeEndEvent() {
                std::cout << "done" << std::endl;
                super::archiveDecodeEndEvent();
            }

            bool errorEvent(stuffit5::Error::type error) {
                std::cout << "Error: " << stuffit5::Error::description(error) << std::endl;
                return super::errorEvent(error);
            }

            bool fileDecodeBeginEvent(uint32_t position) {
                std::cout << fileInfo().name() << " " << std::flush;
                return super::fileDecodeBeginEvent(position);
            }

            void fileDecodeEndEvent() {
                std::cout << std::endl;
                super::fileDecodeEndEvent();
            }

            bool fileDeleteEvent() {
                std::cout << "Warning: " << fileInfo().name() << " is incomplete or damaged" << std::endl;
                return super::fileDeleteEvent();
            }

            bool folderDecodeBeginEvent(uint32_t position) {
                return super::folderDecodeBeginEvent(position);
            }

            void progressScanBeginEvent() {
                std::cout << "Scanning " << archiveInfo().name() << std::endl;
                super::progressScanBeginEvent();
            }

            bool progressSizeMoveEvent(uint32_t position) {
                std::cout << "." << std::flush;
                return super::progressSizeMoveEvent(position);
            }
        };
    }
}

#endif // app_unstuff_BehavedReader_h_included

