// Copyright (c)1999-2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: expand1.cpp,v 1.5 2001/03/07 07:37:46 serge Exp $

#include <iostream>
#include "un/exception.h"
#include "stuffit5/Reader.h"
#include "stuffit5/Version.h"

int main(int argc, char** argv) {
    try {
        std::cout << "StuffIt Engine " << stuffit5::Version::readable()  << std::endl;
        if (argc <= 1) {
            std::cout << "Usage: expand1 (files...)" << std::endl;
            return 1;
        }

        stuffit5::Reader reader;
        for (int i = 1; i < argc; i++) {
            std::cout << "    Expanding " << argv[i] << "..." << std::endl;
            try {
                reader.open(argv[i]);
                reader.decode();
                reader.close();
            }
            catch (un::exception& e) {
                std::cout << e.type() << " exception: " << e.reason() << std::endl;
            }
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

