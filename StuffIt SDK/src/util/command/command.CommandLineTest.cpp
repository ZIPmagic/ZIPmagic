// Copyright (c)2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: command.CommandLineTest.cpp,v 1.1.2.1 2001/07/05 23:35:34 serge Exp $

#include "util/command/CommandLineTest.h" // own header
#include "util/command/Command.h"
#include "util/command/CommandLine.h"

util::command::CommandLineTest::CommandLineTest(const std::string& commandLine, const bool expectedBool, const int expectedInt, const std::string& expectedString) :
    commandLine(commandLine),
    expectedBool(expectedBool),
    expectedInt(expectedInt),
    expectedString(expectedString) {
}

util::command::CommandLineTest::~CommandLineTest() {
}

void util::command::CommandLineTest::test() {
    un::tokenizer st(commandLine);

    int argc = st.size() + 1;
    char** argv = new char*[argc + 2];
    argv[0] = "";
    for (size_t i = 0; i < st.size(); i++) {
        argv[i + 1] = const_cast<char*>(st[i].c_str());
    }
    argv[argc + 1] = 0;

    util::command::CommandLine options(argc, argv);
    util::command::Command<bool> boolCommand(options, "--bool", false);
    util::command::Command<int> intCommand(options, "--int", 0);
    util::command::Command<std::string> stringCommand(options, "--string", "");
    options.digest();

    if (boolCommand.value() != expectedBool
        || intCommand.value() != expectedInt
        || stringCommand.value() != expectedString)
        throw un::exception("failed on (" + commandLine + ")", "CommandLineTest");
}

