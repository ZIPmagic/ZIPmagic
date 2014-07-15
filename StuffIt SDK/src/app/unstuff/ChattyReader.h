// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ChattyReader.h,v 1.9 2001/03/16 21:39:17 serge Exp $

#if !defined app_unstuff_ChattyReader_h_included
#define app_unstuff_ChattyReader_h_included

#include <iostream>
#include "app/unstuff/Reader.h"
#include "un/config.h"
#if platform_win32
    #include <time.h>
#endif

/** This subclass of <code>stuffit5::Reader</code> overrides every event callback
available, and prints information about each callback, along with relevant property
values.

@author serge@aladdinsys.com
@version $Revision: 1.9 $, $Date: 2001/03/16 21:39:17 $
*/

namespace app {
    namespace unstuff {
        class ChattyReader : public app::unstuff::Reader {
        public:
            typedef app::unstuff::Reader super;

            /** Default constructor. */
            ChattyReader() : app::unstuff::Reader() {
            }

            /** Destructor. */
            ~ChattyReader() {
            }

        protected:
            void reportSize(uint32_t size) {
                if (size == static_cast<uint32_t>(-1))
                    std::cout << "unknown";
                else
                    std::cout << size;
            }

            void reportArchiveInfo() {
                if (archiveInfo().isEncrypted())
                    std::cout << "encrypted, ";

                if (archiveInfo().compressedSize.available())
                    std::cout << archiveInfo().compressedSize() << "/";
                else
                    std::cout << "-/";
                if (archiveInfo().uncompressedSize.available())
                    std::cout << archiveInfo().uncompressedSize() << ", ";
                else
                    std::cout << "-, ";

                if (archiveInfo().segmentID.available())
                    std::cout << archiveInfo().segmentID() << "/";
                else
                    std::cout << "-/";
                if (archiveInfo().segmentNumber.available())
                    std::cout << archiveInfo().segmentNumber();
                else
                    std::cout << "-";
            }

            void reportFileInfo() {
                if (fileInfo().unicodeName.available())
                    std::cout << "Unicode, ";
                if (fileInfo().isEncrypted())
                    std::cout << "encrypted, ";
                if (fileInfo().outputIsMacBinary())
                    std::cout << "MacBinary, ";

                if (fileInfo().compressedSize.available())
                    std::cout << fileInfo().compressedSize() << "/";
                else
                    std::cout << "-/";
                if (fileInfo().uncompressedSize.available())
                    std::cout << fileInfo().uncompressedSize() << ", ";
                else
                    std::cout << "-, ";

                #if platform_win32
                    if (fileInfo().modificationTime.available()) {
                        long time = fileInfo().modificationTime();
                        struct tm* tm = gmtime(&time);
                        char t[64];
                        strftime(t, 64, "%Y%m%d-%H%M%S", tm);
                        std::cout << t << ", ";
                    }
                #endif
                if (fileInfo().macType.available() && fileInfo().macCreator.available())
                    std::cout << "'" << fileInfo().macType().stringValue() << "'/'" << fileInfo().macCreator().stringValue() << "'";
                else
                    std::cout << "-/-";
            }

            void reportFolderInfo() {
                if (folderInfo().unicodeName.available())
                    std::cout << "Unicode";
            }

            bool archiveDecodeBeginEvent() {
                std::cout << "archiveDecodeBeginEvent - " << destinationFolder() << ", ";
                reportArchiveInfo();
                std::cout << ", " << (archiveInfo().rootName().empty() ? "multiple roots" : archiveInfo().rootName().c_str()) << std::endl;
                return super::archiveDecodeBeginEvent();
            }

            void archiveDecodeEndEvent() {
                std::cout << "archiveDecodeEndEvent - " << std::endl;
                super::archiveDecodeEndEvent();
            }

            bool archiveInfoEvent() {
                std::cout << "archiveInfoEvent - " << archiveInfo().name() << ", " << stuffit5::Format::name(archiveInfo().format()) << ", ";
                reportArchiveInfo();
                std::cout << ", " << (archiveInfo().rootName().empty() ? "multiple roots" : archiveInfo().rootName().c_str()) << std::endl;
                return super::archiveInfoEvent();
            }

            bool archiveNextEvent() {
                std::cout << "archiveNextEvent - " << std::endl;
                return super::archiveNextEvent();
            }

            bool errorEvent(stuffit5::Error::type error) {
                std::cout << "errorEvent - " << stuffit5::Error::name(error) << ": " << stuffit5::Error::description(error) << std::endl;
                return super::errorEvent(error);
            }

            void fileChangedNameEvent(const char* name) {
                std::cout << "fileChangedNameEvent - "<< name << std::endl;
                super::fileChangedNameEvent(name);
            }

            bool fileDecodeBeginEvent(uint32_t position) {
                std::cout << "fileDecodeBeginEvent - " << fileInfo().name() << ", " << position << ", ";
                reportFileInfo();
                std::cout << std::endl;
                return super::fileDecodeBeginEvent(position);
            }

            void fileDecodeEndEvent() {
                std::cout << "fileDecodeEndEvent - " << std::endl;
                super::fileDecodeEndEvent();
            }

            bool fileDeleteEvent() {
                std::cout << "fileDeleteEvent - " << std::endl;
                return super::fileDeleteEvent();
            }

            bool fileInfoEvent(uint32_t position) {
                std::cout << "fileInfoEvent - " << fileInfo().name() << ", " << position << ", ";
                reportFileInfo();
                std::cout << std::endl;
                return super::fileInfoEvent(position);
            }

            void fileNewNameEvent() {
                std::cout << "fileNewNameEvent - " << newFileName() << std::endl;
                super::fileNewNameEvent();
            }

            bool folderDecodeBeginEvent(uint32_t position) {
                std::cout << "folderDecodeBeginEvent - " << folderInfo().name() << ", " << position << ", ";
                reportFolderInfo();
                std::cout << std::endl;
                return super::folderDecodeBeginEvent(position);
            }

            void folderDecodeEndEvent() {
                std::cout << "folderDecodeEndEvent - " << std::endl;
                super::folderDecodeEndEvent();
            }

            bool folderInfoEvent(uint32_t position) {
                util::System::yield();
                std::cout << "folderInfoEvent - " << folderInfo().name() << ", " << position << ", ";
                reportFolderInfo();
                std::cout << std::endl;
                return super::folderInfoEvent(position);
            }

            void progressFilesBeginEvent(uint32_t size) {
                std::cout << "progressFilesBeginEvent - " << size << std::endl;
                super::progressFilesBeginEvent(size);
            }

            bool progressFilesMoveEvent(uint32_t position) {
                std::cout << "progressFilesMoveEvent - " << position << std::endl;
                return super::progressFilesMoveEvent(position);
            }

            void progressFilesEndEvent() {
                std::cout << "progressFilesEndEvent - " << std::endl;
                super::progressFilesEndEvent();
            }

            void progressScanBeginEvent() {
                std::cout << "progressScanBeginEvent - " << std::endl;
                super::progressScanBeginEvent();
            }

            bool progressScanStepEvent() {
                util::System::yield();
                std::cout << "progressScanStepEvent - " << std::endl;
                return super::progressScanStepEvent();
            }

            void progressScanEndEvent() {
                std::cout << "progressScanEndEvent - " << std::endl;
                super::progressScanEndEvent();
            }

            void progressSizeBeginEvent(uint32_t size) {
                std::cout << "progressSizeBeginEvent - ";
                reportSize(size);
                std::cout << std::endl;
                super::progressSizeBeginEvent(size);
            }

            bool progressSizeMoveEvent(uint32_t position) {
                util::System::yield();
                std::cout << "progressSizeMoveEvent - " << position << std::endl;
                return super::progressSizeMoveEvent(position);
            }

            void progressSizeEndEvent() {
                std::cout << "progressSizeEndEvent - " << std::endl;
                super::progressSizeEndEvent();
            }
        };
    }
}

#endif // app_unstuff_ChattyReader_h_included

