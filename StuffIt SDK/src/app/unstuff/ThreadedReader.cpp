// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ThreadedReader.cpp,v 1.5 2001/03/06 08:38:50 serge Exp $

#include "app/unstuff/ThreadedReader.h" // own header
#include <iostream>
#include "un/exception.h"
#include "stuffit5/Error.h"
#include "stuffit5/Format.h"
#include "stuffit5/exception/BadArgument.h"
#include "util/System.h"

CRITICAL_SECTION app::unstuff::ThreadedReader::coutLock;

unsigned long WINAPI app::unstuff::ThreadedReader::start(void* p) {
    ThreadedReader* reader = (ThreadedReader*)p;

    try {
        reader->process();
        delete reader;
    }
    catch (...) {
        delete reader;
        throw;
    }

    ExitThread(0);
    return 0;
}

void app::unstuff::ThreadedReader::process() {
    try {
        open(name());
        stuffit5::Format::type format = stuffit5::Format::sit5; // something valid to begin with
        while (format >= stuffit5::Format::first) {
            decode();
            classify();
            format = archiveInfo().format();
        }
        close();
    }
    catch (un::exception& e) {
        std::cout << e.type() << " exception: " << e.reason() << std::endl;
    }
}

bool app::unstuff::ThreadedReader::errorEvent(stuffit5::Error::type error) {
    acquireCout();
    std::cout << id() << " - errorEvent - " << stuffit5::Error::name(error) << ": " << stuffit5::Error::description(error) << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::progressScanBeginEvent() {
    acquireCout();
    std::cout << id() << " - progressScanBeginEvent - " << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::progressScanStepEvent() {
    util::System::yield();
    acquireCout();
    std::cout << id() << " - progressScanStepEvent - " << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::progressScanEndEvent() {
    acquireCout();
    std::cout << id() << " - progressScanEndEvent - " << std::endl;
    releaseCout();
}

void app::unstuff::ThreadedReader::progressSizeBeginEvent(uint32_t size) {
    acquireCout();
    std::cout << id() << " - progressSizeBeginEvent - " << size << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::progressSizeMoveEvent(uint32_t position) {
    util::System::yield();
    acquireCout();
    std::cout << id() << " - progressSizeMoveEvent - " << position << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::progressSizeEndEvent() {
    acquireCout();
    std::cout << id() << " - progressSizeEndEvent - " << std::endl;
    releaseCout();
}

void app::unstuff::ThreadedReader::progressFilesBeginEvent(uint32_t size) {
    acquireCout();
    std::cout << id() << " - progressFilesBeginEvent - " << size << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::progressFilesMoveEvent(uint32_t position) {
    acquireCout();
    std::cout << id() << " - progressFilesMoveEvent - " << position << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::progressFilesEndEvent() {
    acquireCout();
    std::cout << id() << " - progressFilesEndEvent - " << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::archiveNextEvent() {
    acquireCout();
    std::cout << id() << " - archiveNextEvent - " << std::endl;
    releaseCout();
    return true;
}

bool app::unstuff::ThreadedReader::archiveInfoEvent() {
    acquireCout();
    std::cout << id() << " - archiveInfoEvent - " << archiveInfo().name() << ", " << stuffit5::Format::name(archiveInfo().format()) << ", ";
    reportArchiveInfo();
    std::cout << ", " << (archiveInfo().rootName().empty() ? "multiple roots" : archiveInfo().rootName()) << std::endl;
    releaseCout();
    return true;
}

bool app::unstuff::ThreadedReader::archiveDecodeBeginEvent() {
    acquireCout();
    std::cout << id() << " - archiveDecodeBeginEvent - " << destinationFolder() << ", ";
    reportArchiveInfo();
    std::cout << ", " << (archiveInfo().rootName().empty() ? "multiple roots" : archiveInfo().rootName()) << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::archiveDecodeEndEvent() {
    acquireCout();
    std::cout << id() << " - archiveDecodeEndEvent - " << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::fileInfoEvent(uint32_t position) {
    acquireCout();
    std::cout << id() << " - fileInfoEvent - " << fileInfo().name() << ", " << position << ", ";
    reportFileInfo();
    std::cout << std::endl;
    releaseCout();
    return true;
}

bool app::unstuff::ThreadedReader::folderInfoEvent(uint32_t position) {
    util::System::yield();
    acquireCout();
    std::cout << id() << " - folderInfoEvent - " << folderInfo().name() << ", " << position << ", ";
    reportFolderInfo();
    std::cout << std::endl;
    releaseCout();
    return true;
}

bool app::unstuff::ThreadedReader::fileDecodeBeginEvent(uint32_t position) {
    acquireCout();
    std::cout << id() << " - fileDecodeBeginEvent - " << fileInfo().name() << ", " << position << ", ";
    reportFileInfo();
    std::cout << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::fileDecodeEndEvent() {
    acquireCout();
    std::cout << id() << " - fileDecodeEndEvent - " << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::folderDecodeBeginEvent(uint32_t position) {
    acquireCout();
    std::cout << id() << " - folderDecodeBeginEvent - " << folderInfo().name() << ", " << position << ", ";
    reportFolderInfo();
    std::cout << std::endl;
    releaseCout();
    return true;
}

void app::unstuff::ThreadedReader::folderDecodeEndEvent() {
    acquireCout();
    std::cout << id() << " - folderDecodeEndEvent - " << std::endl;
    releaseCout();
}

void app::unstuff::ThreadedReader::fileNewNameEvent() {
    acquireCout();
    std::cout << id() << " - fileNewNameEvent - " << newFileName() << std::endl;
    releaseCout();
}

void app::unstuff::ThreadedReader::fileChangedNameEvent(const char* name) {
    acquireCout();
    std::cout << id() << " - fileChangedNameEvent - "<< name << std::endl;
    releaseCout();
}

bool app::unstuff::ThreadedReader::fileDeleteEvent() {
    acquireCout();
    std::cout << id() << " - fileDeleteEvent - " << std::endl;
    releaseCout();
    return false;
}

