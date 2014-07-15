// Copyright (c)1999-2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: stuff1.cpp,v 1.5.2.2 2001/07/05 23:35:04 serge Exp $

#include <iostream>
#include "stuffit5/Version.h"
#include "stuffit5/Writer.h"
#include "un/exception.h"

class Writer : public stuffit5::Writer,
    public stuffit5::event::ArchiveCreateBeginListener,
    public stuffit5::event::ArchiveCreateEndListener,
    public stuffit5::event::FileEncodeBeginListener {
public:
    Writer() {
        addArchiveCreateBeginListener(this);
        addArchiveCreateEndListener(this);
        addFileEncodeBeginListener(this);
    }

protected:
    virtual bool archiveCreateBeginEvent() {
        std::cout << "Creating " << archiveInfo().name() << std::endl;
        return true;
    }

    virtual void archiveCreateEndEvent() {
        std::cout << "done" << std::endl;
    }

    virtual bool fileEncodeBeginEvent() {
        std::cout << fileInfo().name() << " " << std::endl;
        return true;
    }
};

int main(int argc, char** argv) {
    try {
        std::cout << "StuffIt Engine " << stuffit5::Version::readable() << std::endl;
        if (argc <= 1) {
            std::cout << "Usage: stuff1 (files...)" << std::endl;
            return 1;
        }

        std::list<std::string> names;
        for (int i = 1; i < argc; i++)
            names.push_back(argv[i]);

        Writer writer;
        try {
            writer.create(names);
        }
        catch (un::exception& e) {
            std::cout << e.type() << " exception: " << e.reason() << std::endl;
        }

        std::cout << "All OK" << std::endl;
        return 0;
    }
    catch (un::exception& e) {
        std::cout << e.type() << " exception: " << e.reason() << std::endl;
        return 2;
    }
    catch (std::exception e) {
        std::cout << "exception: " << e.what() << std::endl;
        return 3;
    }
    catch (...) {
        std::cout << "Unknown exception" << std::endl;
        return 4;
    }
}

