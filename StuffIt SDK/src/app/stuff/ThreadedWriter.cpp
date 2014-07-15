// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: ThreadedWriter.cpp,v 1.5 2001/03/06 08:38:49 serge Exp $

#include "app/stuff/ThreadedWriter.h" // own header
#include <iostream>
#include "stuffit5/Error.h"
#include "stuffit5/Format.h"
#include "stuffit5/exception/BadArgument.h"
//#include "un/config.h"
#include "util/System.h"

CRITICAL_SECTION app::stuff::ThreadedWriter::coutLock;

unsigned long WINAPI app::stuff::ThreadedWriter::start(void* p) {
    ThreadedWriter* writer = (ThreadedWriter*)p;

    try {
        writer->process();
        delete writer;
    }
    catch (...) {
        delete writer;
        throw;
    }

    ExitThread(0);
    return 0;
}

void app::stuff::ThreadedWriter::process() {
    try {
        // handle the name of the format to be created
        stuffit5::Format::type f = stuffit5::Format::sit5;
        for (stuffit5::Format::type g = stuffit5::Format::first; g <= stuffit5::Format::last; g++) {
            if (formatName() == stuffit5::Format::name(g)) {
                if (!canCreate(g))
                    f = stuffit5::Format::unknown;
                else
                    f = g;
            }
        }
        if (f == stuffit5::Format::unknown)
            throw stuffit5::exception::BadArgument("unknown or unsupported format");
        archiveInfo().format(f);

        // create a file list required by the engine
        std::list<std::string> names;
        names.push_back(name());
        create(names);
    }
    catch (un::exception& e) {
        std::cout << e.type() << " exception: " << e.reason() << std::endl;
    }
}

bool app::stuff::ThreadedWriter::errorEvent(stuffit5::Error::type error) {
    acquireCout();
    std::cout << "errorEvent - " << stuffit5::Error::name(error) << ": " << stuffit5::Error::description(error) << std::endl;
    releaseCout();
    return true;
}

void app::stuff::ThreadedWriter::progressSizeBeginEvent(uint32_t size) {
    acquireCout();
    std::cout << id() << " - progressSizeBeginEvent - " << size << std::endl;
    releaseCout();
}

bool app::stuff::ThreadedWriter::progressSizeMoveEvent(uint32_t position) {
    util::System::yield();
    acquireCout();
    std::cout << id() << " - progressSizeMoveEvent - " << position << std::endl;
    releaseCout();
    return true;
}

void app::stuff::ThreadedWriter::progressSizeEndEvent() {
    acquireCout();
    std::cout << id() << " - progressSizeEndEvent - " << std::endl;
    releaseCout();
}

void app::stuff::ThreadedWriter::progressFilesBeginEvent(uint32_t size) {
    acquireCout();
    std::cout << id() << " - progressFilesBeginEvent - " << size << std::endl;
    releaseCout();
}

bool app::stuff::ThreadedWriter::progressFilesMoveEvent(uint32_t position) {
    acquireCout();
    std::cout << id() << " - progressFilesMoveEvent - " << position << std::endl;
    releaseCout();
    return true;
}

void app::stuff::ThreadedWriter::progressFilesEndEvent() {
    acquireCout();
    std::cout << id() << " - progressFilesEndEvent - " << std::endl;
    releaseCout();
}

bool app::stuff::ThreadedWriter::archiveCreateBeginEvent() {
    acquireCout();
    std::cout << id() << " - archiveCreateBeginEvent - " << archiveInfo().name() << std::endl;
    releaseCout();
    return true;
}

void app::stuff::ThreadedWriter::archiveChangedNameEvent(const char* name) {
    acquireCout();
    std::cout << id() << " - archiveChangedNameEvent - " << name << std::endl;
    releaseCout();
}

void app::stuff::ThreadedWriter::archiveCreateEndEvent() {
    acquireCout();
    std::cout << id() << " - archiveCreateEndEvent - " << std::endl;
    releaseCout();
}

void app::stuff::ThreadedWriter::archiveSizeEvent() {
    acquireCout();
    std::cout << id() << " - archiveSizeEvent - " << std::endl;
    releaseCout();
}

bool app::stuff::ThreadedWriter::fileScanStepEvent() {
    util::System::yield();
    acquireCout();
    std::cout << id() << " - fileScanStepEvent - " << fileInfo().name() << std::endl;
    releaseCout();
    return true;
}

bool app::stuff::ThreadedWriter::folderScanStepEvent() {
    util::System::yield();
    acquireCout();
    std::cout << id() << " - folderScanStepEvent - " << folderInfo().name() << std::endl;
    releaseCout();
    return true;
}

bool app::stuff::ThreadedWriter::fileEncodeBeginEvent() {
    acquireCout();
    std::cout << id() << " - fileEncodeBeginEvent - " << fileInfo().name() << std::endl;
    releaseCout();
    return true;
}

void app::stuff::ThreadedWriter::fileEncodeEndEvent() {
    acquireCout();
    std::cout << id() << " - fileEncodeEndEvent - " << std::endl;
    releaseCout();
}

bool app::stuff::ThreadedWriter::folderEncodeBeginEvent() {
    acquireCout();
    std::cout << id() << " - folderEncodeBeginEvent - " << folderInfo().name() << std::endl;
    releaseCout();
    return true;
}

void app::stuff::ThreadedWriter::folderEncodeEndEvent() {
    acquireCout();
    std::cout << id() << " - folderEncodeEndEvent - " << std::endl;
    releaseCout();
}

bool app::stuff::ThreadedWriter::fileDeleteEvent() {
    acquireCout();
    std::cout << id() << " - fileDeleteEvent - " << std::endl;
    releaseCout();
    return false;
}

