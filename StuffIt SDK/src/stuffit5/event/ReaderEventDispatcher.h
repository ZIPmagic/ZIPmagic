// $Id: ReaderEventDispatcher.h,v 1.2.2.1 2001/07/05 23:32:37 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ReaderEventDispatcher_h_included
#define stuffit5_event_ReaderEventDispatcher_h_included

#include "stuffit5/event/ArchiveDecodeBeginDispatcher.h"
#include "stuffit5/event/ArchiveDecodeEndDispatcher.h"
#include "stuffit5/event/ArchiveInfoDispatcher.h"
#include "stuffit5/event/ArchiveNextDispatcher.h"
#include "stuffit5/event/ErrorDispatcher.h"
#include "stuffit5/event/FileChangedNameDispatcher.h"
#include "stuffit5/event/FileDecodeBeginDispatcher.h"
#include "stuffit5/event/FileDecodeEndDispatcher.h"
#include "stuffit5/event/FileDeleteDispatcher.h"
#include "stuffit5/event/FileInfoDispatcher.h"
#include "stuffit5/event/FileNewNameDispatcher.h"
#include "stuffit5/event/FolderDecodeBeginDispatcher.h"
#include "stuffit5/event/FolderDecodeEndDispatcher.h"
#include "stuffit5/event/FolderInfoDispatcher.h"
#include "stuffit5/event/ProgressFilesBeginDispatcher.h"
#include "stuffit5/event/ProgressFilesEndDispatcher.h"
#include "stuffit5/event/ProgressFilesMoveDispatcher.h"
#include "stuffit5/event/ProgressScanBeginDispatcher.h"
#include "stuffit5/event/ProgressScanEndDispatcher.h"
#include "stuffit5/event/ProgressScanStepDispatcher.h"
#include "stuffit5/event/ProgressSizeBeginDispatcher.h"
#include "stuffit5/event/ProgressSizeEndDispatcher.h"
#include "stuffit5/event/ProgressSizeMoveDispatcher.h"

/** Reader event dispatcher: combines multiple reader event dispatcher interfaces.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:37 $
*/

namespace stuffit5 {
    namespace event {
        class ReaderEventDispatcher :
            public stuffit5::event::ArchiveDecodeBeginDispatcher,
            public stuffit5::event::ArchiveDecodeEndDispatcher,
            public stuffit5::event::ArchiveInfoDispatcher,
            public stuffit5::event::ArchiveNextDispatcher,
            public stuffit5::event::ErrorDispatcher,
            public stuffit5::event::FileChangedNameDispatcher,
            public stuffit5::event::FileDecodeBeginDispatcher,
            public stuffit5::event::FileDecodeEndDispatcher,
            public stuffit5::event::FileDeleteDispatcher,
            public stuffit5::event::FileInfoDispatcher,
            public stuffit5::event::FileNewNameDispatcher,
            public stuffit5::event::FolderDecodeBeginDispatcher,
            public stuffit5::event::FolderDecodeEndDispatcher,
            public stuffit5::event::FolderInfoDispatcher,
            public stuffit5::event::ProgressFilesBeginDispatcher,
            public stuffit5::event::ProgressFilesEndDispatcher,
            public stuffit5::event::ProgressFilesMoveDispatcher,
            public stuffit5::event::ProgressScanBeginDispatcher,
            public stuffit5::event::ProgressScanEndDispatcher,
            public stuffit5::event::ProgressScanStepDispatcher,
            public stuffit5::event::ProgressSizeBeginDispatcher,
            public stuffit5::event::ProgressSizeEndDispatcher,
            public stuffit5::event::ProgressSizeMoveDispatcher {
        };
    }
}

#endif

