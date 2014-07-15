// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Writer.h,v 1.5.2.1 2001/07/05 23:27:20 serge Exp $

#if !defined app_stuff_Writer_h_included
#define app_stuff_Writer_h_included

#include "un/opt_property.h"
#include "un/property.h"
#include "stuffit5/Writer.h"
#include "stuffit5/event/ArchiveChangedNameListener.h"
#include "stuffit5/event/ArchiveCreateBeginListener.h"
#include "stuffit5/event/ArchiveCreateEndListener.h"
#include "stuffit5/event/ArchiveSizeListener.h"
#include "stuffit5/event/ErrorListener.h"
#include "stuffit5/event/FileDeleteListener.h"
#include "stuffit5/event/FileEncodeBeginListener.h"
#include "stuffit5/event/FileEncodeEndListener.h"
#include "stuffit5/event/FileScanStepListener.h"
#include "stuffit5/event/FolderEncodeBeginListener.h"
#include "stuffit5/event/FolderEncodeEndListener.h"
#include "stuffit5/event/FolderScanStepListener.h"
#include "stuffit5/event/ProgressFilesBeginListener.h"
#include "stuffit5/event/ProgressFilesEndListener.h"
#include "stuffit5/event/ProgressFilesMoveListener.h"
#include "stuffit5/event/ProgressSizeBeginListener.h"
#include "stuffit5/event/ProgressSizeEndListener.h"
#include "stuffit5/event/ProgressSizeMoveListener.h"
#include "util/System.h"

/** This subclass of <code>stuffit5::Writer</code> overrides every event callback
available. This demonstrates how to subclass and customize StuffIt Engine writers
and may be useful for understanding the sequence in which event callbacks happen
during archive creation (encoding), and their potential uses.

@author serge@aladdinsys.com
@version $Revision: 1.5.2.1 $, $Date: 2001/07/05 23:27:20 $
*/

namespace app {
    namespace stuff {
        class Writer :
            public stuffit5::Writer,
            public stuffit5::event::ArchiveChangedNameListener,
            public stuffit5::event::ArchiveCreateBeginListener,
            public stuffit5::event::ArchiveCreateEndListener,
            public stuffit5::event::ArchiveSizeListener,
            public stuffit5::event::ErrorListener,
            public stuffit5::event::FileDeleteListener,
            public stuffit5::event::FileEncodeBeginListener,
            public stuffit5::event::FileEncodeEndListener,
            public stuffit5::event::FileScanStepListener,
            public stuffit5::event::FolderEncodeBeginListener,
            public stuffit5::event::FolderEncodeEndListener,
            public stuffit5::event::FolderScanStepListener,
            public stuffit5::event::ProgressFilesBeginListener,
            public stuffit5::event::ProgressFilesEndListener,
            public stuffit5::event::ProgressFilesMoveListener,
            public stuffit5::event::ProgressSizeBeginListener,
            public stuffit5::event::ProgressSizeEndListener,
            public stuffit5::event::ProgressSizeMoveListener {
        public:
            /** Default constructor. */
            Writer() :
                abortOnError(false) {
                addArchiveChangedNameListener(this);
                addArchiveCreateBeginListener(this);
                addArchiveCreateEndListener(this);
                addArchiveSizeListener(this);
                addErrorListener(this);
                addFileDeleteListener(this);
                addFileEncodeBeginListener(this);
                addFileEncodeEndListener(this);
                addFileScanStepListener(this);
                addFolderEncodeBeginListener(this);
                addFolderEncodeEndListener(this);
                addFolderScanStepListener(this);
                addProgressFilesBeginListener(this);
                addProgressFilesMoveListener(this);
                addProgressFilesEndListener(this);
                addProgressSizeBeginListener(this);
                addProgressSizeMoveListener(this);
                addProgressSizeEndListener(this);
            }

            /** Destructor. */
            virtual ~Writer() {
            }

            un::property<bool> abortOnError;

            un::property<std::string> macCreator;
            un::property<std::string> macType;

        protected:
            virtual void acquireCout(){
            }

            virtual void releaseCout() {
            }

            virtual void archiveChangedNameEvent(const char* /*name*/) {
            }

            virtual bool archiveCreateBeginEvent() {
                return true;
            }

            virtual void archiveCreateEndEvent() {
            }

            virtual void archiveSizeEvent() {
            }

            virtual bool errorEvent(stuffit5::Error::type /*error*/) {
                return !abortOnError();
            }

            virtual bool fileDeleteEvent() {
                return false;
            }

            virtual bool fileEncodeBeginEvent() {
                if (!macType().empty())
                    fileInfo().macType().stringValue(macType());
                if (!macCreator().empty())
                    fileInfo().macCreator().stringValue(macCreator());
                return true;
            }

            virtual void fileEncodeEndEvent() {
            }

            virtual bool fileScanStepEvent() {
                util::System::yield();
                return true;
            }

            virtual bool folderEncodeBeginEvent() {
                return true;
            }

            virtual void folderEncodeEndEvent() {
            }

            virtual bool folderScanStepEvent() {
                util::System::yield();
                return true;
            }

            virtual void progressFilesBeginEvent(uint32_t /*size*/) {
            }

            virtual void progressFilesEndEvent() {
            }

            virtual bool progressFilesMoveEvent(uint32_t /*position*/) {
                return true;
            }

            virtual void progressSizeBeginEvent(uint32_t /*size*/) {
            }

            virtual void progressSizeEndEvent() {
            }

            virtual bool progressSizeMoveEvent(uint32_t /*position*/) {
                util::System::yield();
                return true;
            }
        };
    }
}

#endif // app_stuff_Writer_h_included

