// $Id: WriterEventDispatcher.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_WriterEventDispatcher_h_included
#define stuffit5_event_WriterEventDispatcher_h_included

#include "stuffit5/event/ArchiveChangedNameDispatcher.h"
#include "stuffit5/event/ArchiveCreateBeginDispatcher.h"
#include "stuffit5/event/ArchiveCreateEndDispatcher.h"
#include "stuffit5/event/ArchiveSizeDispatcher.h"
#include "stuffit5/event/ErrorDispatcher.h"
#include "stuffit5/event/FileDeleteDispatcher.h"
#include "stuffit5/event/FileEncodeBeginDispatcher.h"
#include "stuffit5/event/FileEncodeEndDispatcher.h"
#include "stuffit5/event/FileScanStepDispatcher.h"
#include "stuffit5/event/FolderEncodeBeginDispatcher.h"
#include "stuffit5/event/FolderEncodeEndDispatcher.h"
#include "stuffit5/event/FolderScanStepDispatcher.h"
#include "stuffit5/event/ProgressFilesBeginDispatcher.h"
#include "stuffit5/event/ProgressFilesEndDispatcher.h"
#include "stuffit5/event/ProgressFilesMoveDispatcher.h"
#include "stuffit5/event/ProgressSizeBeginDispatcher.h"
#include "stuffit5/event/ProgressSizeEndDispatcher.h"
#include "stuffit5/event/ProgressSizeMoveDispatcher.h"

/** Writer event dispatcher: combines multiple writer event dispatcher interfaces.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

namespace stuffit5 {
    namespace event {
        class WriterEventDispatcher :
            public stuffit5::event::ArchiveChangedNameDispatcher,
            public stuffit5::event::ArchiveCreateBeginDispatcher,
            public stuffit5::event::ArchiveCreateEndDispatcher,
            public stuffit5::event::ArchiveSizeDispatcher,
            public stuffit5::event::ErrorDispatcher,
            public stuffit5::event::FileDeleteDispatcher,
            public stuffit5::event::FileEncodeBeginDispatcher,
            public stuffit5::event::FileEncodeEndDispatcher,
            public stuffit5::event::FileScanStepDispatcher,
            public stuffit5::event::FolderEncodeBeginDispatcher,
            public stuffit5::event::FolderEncodeEndDispatcher,
            public stuffit5::event::FolderScanStepDispatcher,
            public stuffit5::event::ProgressFilesBeginDispatcher,
            public stuffit5::event::ProgressFilesEndDispatcher,
            public stuffit5::event::ProgressFilesMoveDispatcher,
            public stuffit5::event::ProgressSizeBeginDispatcher,
            public stuffit5::event::ProgressSizeEndDispatcher,
            public stuffit5::event::ProgressSizeMoveDispatcher {
        };
    }
}

#endif

