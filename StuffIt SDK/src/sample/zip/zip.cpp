// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: zip.cpp,v 1.5.2.2 2001/07/05 23:35:05 serge Exp $

#include <iostream>
#include "stuffit5/Version.h"
#include "stuffit5/Writer.h"
#include "stuffit5/ZipCompressionLevel.h"
#include "un/exception.h"

class CustomWriter : public stuffit5::Writer {
protected:
    virtual bool archiveCreateBeginEvent() {
        std::cout << "Creating " << archiveInfo().name() << "..." << std::endl;
        return true;
    }
};

int main(int argc, char** argv) {
    try {
        std::cout << "StuffIt Engine " << stuffit5::Version::readable() << std::endl;
        if (argc <= 1) {
            std::cout << "Usage: zip [-0123456789] (files...)" << std::endl;
            std::cout << "    [-0123456789] is the compression level (0-9)" << std::endl;
            return 1;
        }

        stuffit5::CompressionLevel::type cl = stuffit5::CompressionLevel::automatic;
        std::list<std::string> names;
        for (int i = 1; i < argc; i++) {
            if (argv[i][0] == '-' && (argv[i][1] >= '0' && argv[i][1] <= '9'))
                cl = argv[i][1] - '0';
            else
                names.push_back(argv[i]);
        }

        CustomWriter writer;
        writer.compressionLevel(cl);
        writer.archiveInfo().format(stuffit5::Format::zip);
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

