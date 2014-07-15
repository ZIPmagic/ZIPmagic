// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Reader.h,v 1.5 2001/03/06 08:38:50 serge Exp $

#if !defined app_unstuff_Reader_h_included
#define app_unstuff_Reader_h_included

#include "un/property.h"
#include "stuffit5/Reader.h"
#include "stuffit5/event/ArchiveDecodeBeginListener.h"
#include "stuffit5/event/ArchiveDecodeEndListener.h"
#include "stuffit5/event/ArchiveInfoListener.h"
#include "stuffit5/event/ArchiveNextListener.h"
#include "stuffit5/event/ErrorListener.h"
#include "stuffit5/event/FileChangedNameListener.h"
#include "stuffit5/event/FileDecodeBeginListener.h"
#include "stuffit5/event/FileDecodeEndListener.h"
#include "stuffit5/event/FileDeleteListener.h"
#include "stuffit5/event/FileInfoListener.h"
#include "stuffit5/event/FileNewNameListener.h"
#include "stuffit5/event/FolderDecodeBeginListener.h"
#include "stuffit5/event/FolderDecodeEndListener.h"
#include "stuffit5/event/FolderInfoListener.h"
#include "stuffit5/event/ProgressFilesBeginListener.h"
#include "stuffit5/event/ProgressFilesEndListener.h"
#include "stuffit5/event/ProgressFilesMoveListener.h"
#include "stuffit5/event/ProgressScanBeginListener.h"
#include "stuffit5/event/ProgressScanEndListener.h"
#include "stuffit5/event/ProgressScanStepListener.h"
#include "stuffit5/event/ProgressSizeBeginListener.h"
#include "stuffit5/event/ProgressSizeEndListener.h"
#include "stuffit5/event/ProgressSizeMoveListener.h"
#include "util/System.h"

/** A reader that reports every event on console.

<p>This subclass of <code>stuffit5::Reader</code> overrides every single
event callback available, and prints information about each callback as it happens,
along with some <code>Reader</code> property values.

<p>This class demonstrates how to subclass and customize StuffIt Engine readers.
It may also be useful for understanding the sequence in which event callbacks happen
during archive expansion (decoding), and their potential uses.

@author serge@aladdinsys.com
@version $Revision: 1.5 $, $Date: 2001/03/06 08:38:50 $
*/

namespace app {
    namespace unstuff {
        class Reader :
            public stuffit5::Reader,
            public stuffit5::event::ArchiveDecodeBeginListener,
            public stuffit5::event::ArchiveDecodeEndListener,
            public stuffit5::event::ArchiveInfoListener,
            public stuffit5::event::ArchiveNextListener,
            public stuffit5::event::ErrorListener,
            public stuffit5::event::FileChangedNameListener,
            public stuffit5::event::FileDecodeBeginListener,
            public stuffit5::event::FileDecodeEndListener,
            public stuffit5::event::FileDeleteListener,
            public stuffit5::event::FileInfoListener,
            public stuffit5::event::FileNewNameListener,
            public stuffit5::event::FolderDecodeBeginListener,
            public stuffit5::event::FolderDecodeEndListener,
            public stuffit5::event::FolderInfoListener,
            public stuffit5::event::ProgressFilesBeginListener,
            public stuffit5::event::ProgressFilesEndListener,
            public stuffit5::event::ProgressFilesMoveListener,
            public stuffit5::event::ProgressScanBeginListener,
            public stuffit5::event::ProgressScanEndListener,
            public stuffit5::event::ProgressScanStepListener,
            public stuffit5::event::ProgressSizeBeginListener,
            public stuffit5::event::ProgressSizeEndListener,
            public stuffit5::event::ProgressSizeMoveListener {
        public:
            /** Default constructor. */
            Reader() :
                abortOnError(false) {
                addArchiveDecodeBeginListener(this);
                addArchiveDecodeEndListener(this);
                addArchiveInfoListener(this);
                addArchiveNextListener(this);
                addErrorListener(this);
                addFileChangedNameListener(this);
                addFileDecodeBeginListener(this);
                addFileDecodeEndListener(this);
                addFileDeleteListener(this);
                addFileInfoListener(this);
                addFileNewNameListener(this);
                addFolderDecodeBeginListener(this);
                addFolderDecodeEndListener(this);
                addFolderInfoListener(this);
                addProgressFilesBeginListener(this);
                addProgressFilesEndListener(this);
                addProgressFilesMoveListener(this);
                addProgressScanBeginListener(this);
                addProgressScanEndListener(this);
                addProgressScanStepListener(this);
                addProgressSizeBeginListener(this);
                addProgressSizeEndListener(this);
                addProgressSizeMoveListener(this);
            }

            /** Destructor. */
            virtual ~Reader() {
            }

            un::property<bool> abortOnError;

        protected:
            virtual bool archiveDecodeBeginEvent() {
                return true;
            }

            virtual void archiveDecodeEndEvent() {
            }

            virtual bool archiveInfoEvent() {
                return true;
            }

            virtual bool archiveNextEvent() {
                return true;
            }

            virtual bool errorEvent(stuffit5::Error::type /*error*/) {
                return !abortOnError();
            }

            virtual void fileChangedNameEvent(const char* /*name*/) {
            }

            virtual bool fileDecodeBeginEvent(uint32_t /*position*/) {
                return true;
            }

            virtual void fileDecodeEndEvent() {
            }

            virtual bool fileDeleteEvent() {
                return false;
            }

            virtual bool fileInfoEvent(uint32_t /*position*/) {
                return true;
            }

            virtual void fileNewNameEvent() {
            }

            virtual bool folderDecodeBeginEvent(uint32_t /*position*/) {
                return true;
            }

            virtual void folderDecodeEndEvent() {
            }

            virtual bool folderInfoEvent(uint32_t /*position*/) {
                util::System::yield();
                return true;
            }

            virtual void progressFilesBeginEvent(uint32_t /*size*/) {
            }

            virtual bool progressFilesMoveEvent(uint32_t /*position*/) {
                return true;
            }

            virtual void progressFilesEndEvent() {
            }

            virtual void progressScanBeginEvent() {
            }

            virtual bool progressScanStepEvent() {
                util::System::yield();
                return true;
            }

            virtual void progressScanEndEvent() {
            }

            virtual void progressSizeBeginEvent(uint32_t /*size*/) {
            }

            virtual bool progressSizeMoveEvent(uint32_t /*position*/) {
                util::System::yield();
                return true;
            }

            virtual void progressSizeEndEvent() {
            }
        };
    }
}

#endif // app_unstuff_Reader_h_included

