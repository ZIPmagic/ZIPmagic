// $Id: common.h,v 1.2.2.2 2001/07/05 23:32:34 serge Exp $
//
// Copyright (c)2000-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: common.h,v 1.2.2.2 2001/07/05 23:32:34 serge Exp $

#if !defined stuffit5_common_h_included
#define stuffit5_common_h_included

/** C equivalent of <code>stuffit5::Reader</code>. */
typedef void* stuffit5_Reader;
/** C equivalent of <code>stuffit5::Writer</code>. */
typedef void* stuffit5_Writer;
/** C equivalent of <code>stuffit5::Archive</code>. */
typedef void* stuffit5_Archive;

/** C equivalent of <code>stuffit5::ArchiveInfo</code>. */
typedef void* stuffit5_ArchiveInfo;
/** C equivalent of <code>stuffit5::FileInfo</code>. */
typedef void* stuffit5_FileInfo;
/** C equivalent of <code>stuffit5::FolderInfo</code>. */
typedef void* stuffit5_FolderInfo;

/** C equivalent of <code>stuffit5::Error::type</code>. */
typedef int stuffit5_Error_type;
/** C equivalent of <code>stuffit5::Format::type</code>. */
typedef int stuffit5_Format_type;

/** C equivalent of <code>stuffit5::CompressionLevel::type</code>. */
typedef int stuffit5_CompressionLevel_type;
/** C equivalent of <code>stuffit5::MacBinaryOutput::type</code>. */
typedef int stuffit5_MacBinaryOutput_type;
/** C equivalent of <code>stuffit5::TextConversion::type</code>. */
typedef int stuffit5_TextConversion_type;
/** C equivalent of <code>stuffit5::TextType::type</code>. */
typedef int stuffit5_TextType_type;

/** C equivalent of <code>stuffit5::event::ArchiveChangedNameListener</code>. */
typedef void* stuffit5_event_ArchiveChangedNameListener;
/** C equivalent of <code>stuffit5::event::ArchiveCreateBeginListener</code>. */
typedef void* stuffit5_event_ArchiveCreateBeginListener;
/** C equivalent of <code>stuffit5::event::ArchiveCreateEndListener</code>. */
typedef void* stuffit5_event_ArchiveCreateEndListener;
/** C equivalent of <code>stuffit5::event::ArchiveDecodeBeginListener</code>. */
typedef void* stuffit5_event_ArchiveDecodeBeginListener;
/** C equivalent of <code>stuffit5::event::ArchiveDecodeEndListener</code>. */
typedef void* stuffit5_event_ArchiveDecodeEndListener;
/** C equivalent of <code>stuffit5::event::ArchiveInfoListener</code>. */
typedef void* stuffit5_event_ArchiveInfoListener;
/** C equivalent of <code>stuffit5::event::ArchiveNextListener</code>. */
typedef void* stuffit5_event_ArchiveNextListener;
/** C equivalent of <code>stuffit5::event::ArchiveSizeListener</code>. */
typedef void* stuffit5_event_ArchiveSizeListener;
/** C equivalent of <code>stuffit5::event::ErrorListener</code>. */
typedef void* stuffit5_event_ErrorListener;
/** C equivalent of <code>stuffit5::event::FileChangedNameListener</code>. */
typedef void* stuffit5_event_FileChangedNameListener;
/** C equivalent of <code>stuffit5::event::FileDecodeBeginListener</code>. */
typedef void* stuffit5_event_FileDecodeBeginListener;
/** C equivalent of <code>stuffit5::event::FileDecodeEndListener</code>. */
typedef void* stuffit5_event_FileDecodeEndListener;
/** C equivalent of <code>stuffit5::event::FileDeleteListener</code>. */
typedef void* stuffit5_event_FileDeleteListener;
/** C equivalent of <code>stuffit5::event::FileEncodeBeginListener</code>. */
typedef void* stuffit5_event_FileEncodeBeginListener;
/** C equivalent of <code>stuffit5::event::FileEncodeEndListener</code>. */
typedef void* stuffit5_event_FileEncodeEndListener;
/** C equivalent of <code>stuffit5::event::FileInfoListener</code>. */
typedef void* stuffit5_event_FileInfoListener;
/** C equivalent of <code>stuffit5::event::FileNewNameListener</code>. */
typedef void* stuffit5_event_FileNewNameListener;
/** C equivalent of <code>stuffit5::event::FileScanStepListener</code>. */
typedef void* stuffit5_event_FileScanStepListener;
/** C equivalent of <code>stuffit5::event::FolderDecodeBeginListener</code>. */
typedef void* stuffit5_event_FolderDecodeBeginListener;
/** C equivalent of <code>stuffit5::event::FolderDecodeEndListener</code>. */
typedef void* stuffit5_event_FolderDecodeEndListener;
/** C equivalent of <code>stuffit5::event::FolderEncodeBeginListener</code>. */
typedef void* stuffit5_event_FolderEncodeBeginListener;
/** C equivalent of <code>stuffit5::event::FolderEncodeEndListener</code>. */
typedef void* stuffit5_event_FolderEncodeEndListener;
/** C equivalent of <code>stuffit5::event::FolderInfoListener</code>. */
typedef void* stuffit5_event_FolderInfoListener;
/** C equivalent of <code>stuffit5::event::FolderScanStepListener</code>. */
typedef void* stuffit5_event_FolderScanStepListener;
/** C equivalent of <code>stuffit5::event::ProgressFilesBeginListener</code>. */
typedef void* stuffit5_event_ProgressFilesBeginListener;
/** C equivalent of <code>stuffit5::event::ProgressFilesEndListener</code>. */
typedef void* stuffit5_event_ProgressFilesEndListener;
/** C equivalent of <code>stuffit5::event::ProgressFilesMoveListener</code>. */
typedef void* stuffit5_event_ProgressFilesMoveListener;
/** C equivalent of <code>stuffit5::event::ProgressScanBeginListener</code>. */
typedef void* stuffit5_event_ProgressScanBeginListener;
/** C equivalent of <code>stuffit5::event::ProgressScanEndListener</code>. */
typedef void* stuffit5_event_ProgressScanEndListener;
/** C equivalent of <code>stuffit5::event::ProgressScanStepListener</code>. */
typedef void* stuffit5_event_ProgressScanStepListener;
/** C equivalent of <code>stuffit5::event::ProgressSizeBeginListener</code>. */
typedef void* stuffit5_event_ProgressSizeBeginListener;
/** C equivalent of <code>stuffit5::event::ProgressSizeEndListener</code>. */
typedef void* stuffit5_event_ProgressSizeEndListener;
/** C equivalent of <code>stuffit5::event::ProgressSizeMoveListener</code>. */
typedef void* stuffit5_event_ProgressSizeMoveListener;

#endif

