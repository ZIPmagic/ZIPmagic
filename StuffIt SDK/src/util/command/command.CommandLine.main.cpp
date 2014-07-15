// Copyright (c)2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: command.CommandLine.main.cpp,v 1.1 2001/03/06 08:41:15 serge Exp $

#include <iostream>
#include "un/exception.h"
#include "util/command/CommandLineTest.h"

int main(int argc, char** argv) {
    try {
        util::command::CommandLineTest("--int=1234 --string=abc", false, 1234, "abc").test();
        util::command::CommandLineTest("--bool", true, 0, "").test();
        return 0;
    }
    catch (un::exception& e) {
        std::cout << e.type() << " exception: " << e.reason() << std::endl;
        return 1;
    }
    catch (std::exception& e) {
        std::cout << "exception: " << e.what() << std::endl;
        return 2;
    }
    #if !defined DEBUG && !defined _DEBUG
    catch (...) {
        std::cout << "Unknown exception" << std::endl;
        return 3;
    }
    #endif
}

