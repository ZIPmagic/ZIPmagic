// Copyright (c)2001 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: rr.cpp,v 1.1.2.1 2001/06/04 23:57:18 serge Exp $

#include <iostream>
#include <cstring>
#include "stuffit5/Archive.h"
#include "stuffit5/Version.h"
#include "un/exception.h"

int main(int argc, char** argv) {
    try {
        std::cout << "StuffIt Engine " << stuffit5::Version::readable() << std::endl;

        bool on = false;
        bool off = false;
        std::string name;
        for (int i = 1; i < argc; i++) {
            if (strcmp(argv[i], "-on") == 0)
                on = true;
            else if (strcmp(argv[i], "-off") == 0)
                off = true;
            else
                name = argv[i];
        }

        if (name.empty()) {
            std::cout << "Usage: rr [-on|-off] archive" << std::endl;
            return 1;
        }

        stuffit5::Archive a;
        try {
            a.open(name);
            if (on)
                a.returnReceipt(true);
            else if (off)
                a.returnReceipt(false);
            else
                std::cout << "Return receipt is " << (a.returnReceipt() ? "on" : "off") << std::endl;
            a.close();
        }
        catch (un::exception& e) {
            std::cout << e.type() << " exception: " << e.reason() << std::endl;
        }

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

