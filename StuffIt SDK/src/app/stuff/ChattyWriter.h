// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ChattyWriter.h,v 1.2 2001/03/09 09:52:03 serge Exp $

#if !defined app_stuff_ChattyWriter_h_included
#define app_stuff_ChattyWriter_h_included

#include <iostream>
#include "app/stuff/Writer.h"

/** This subclass of <code>stuffit5::Writer</code> overrides every event callback
available, and prints information about each callback, along with relevant property
values.

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/09 09:52:03 $
*/

namespace app {
    namespace stuff {
        class ChattyWriter : public app::stuff::Writer {
        public:
            typedef app::stuff::Writer super;

            /** Default constructor. */
            ChattyWriter() : app::stuff::Writer() {
            }

            /** Destructor. */
            ~ChattyWriter() {
            }

        protected:
            void reportSize(uint32_t size) {
                if (size == static_cast<uint32_t>(-1))
                    std::cout << "unknown";
                else
                    std::cout << size;
            }

            void archiveChangedNameEvent(const char* name) {
                std::cout << "archiveChangedNameEvent - " << name << std::endl;
                super::archiveChangedNameEvent(name);
            }

            bool archiveCreateBeginEvent() {
                std::cout << "archiveCreateBeginEvent - " << archiveInfo().name() << std::endl;
                return super::archiveCreateBeginEvent();
            }

            void archiveCreateEndEvent() {
                std::cout << "archiveCreateEndEvent - " << std::endl;
                super::archiveCreateEndEvent();
            }

            void archiveSizeEvent() {
                std::cout << "archiveSizeEvent - " << std::endl;
                super::archiveSizeEvent();
            }

            bool errorEvent(stuffit5::Error::type error) {
                std::cout << "errorEvent - " << stuffit5::Error::name(error) << ": " << stuffit5::Error::description(error) << std::endl;
                return super::errorEvent(error);
            }

            bool fileDeleteEvent() {
                std::cout << "fileDeleteEvent - " << std::endl;
                return super::fileDeleteEvent();
            }

            bool fileEncodeBeginEvent() {
                std::cout << "fileEncodeBeginEvent - " << fileInfo().name() << std::endl;
                return super::fileEncodeBeginEvent();
            }

            void fileEncodeEndEvent() {
                std::cout << "fileEncodeEndEvent - " << std::endl;
                super::fileEncodeEndEvent();
            }

            bool fileScanStepEvent() {
                std::cout << "fileScanStepEvent - " << fileInfo().name() << std::endl;
                return super::fileScanStepEvent();
            }

            bool folderEncodeBeginEvent() {
                std::cout << "folderEncodeBeginEvent - " << folderInfo().name() << std::endl;
                return super::folderEncodeBeginEvent();
            }

            void folderEncodeEndEvent() {
                std::cout << "folderEncodeEndEvent - " << std::endl;
                super::folderEncodeEndEvent();
            }

            bool folderScanStepEvent() {
                std::cout << "folderScanStepEvent - " << folderInfo().name() << std::endl;
                return super::folderScanStepEvent();
            }

            void progressFilesBeginEvent(uint32_t size) {
                std::cout << "progressFilesBeginEvent - " << size << std::endl;
                super::progressFilesBeginEvent(size);
            }

            void progressFilesEndEvent() {
                std::cout << "progressFilesEndEvent - " << std::endl;
                super::progressFilesEndEvent();
            }

            bool progressFilesMoveEvent(uint32_t position) {
                std::cout << "progressFilesMoveEvent - " << position << std::endl;
                return super::progressFilesMoveEvent(position);
            }

            void progressSizeBeginEvent(uint32_t size) {
                std::cout << "progressSizeBeginEvent - ";
                reportSize(size);
                std::cout << std::endl;
                super::progressSizeBeginEvent(size);
            }

            void progressSizeEndEvent() {
                std::cout << "progressSizeEndEvent - " << std::endl;
                super::progressSizeEndEvent();
            }

            bool progressSizeMoveEvent(uint32_t position) {
                std::cout << "progressSizeMoveEvent - " << position << std::endl;
                return super::progressSizeMoveEvent(position);
            }
        };
    }
}

#endif // app_stuff_ChattyWriter_h_included

