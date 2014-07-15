// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: command.CommandLine.cpp,v 1.1.2.1 2001/07/05 23:35:34 serge Exp $

#include "util/command/CommandLine.h" // own header
#include <iostream>
#include <list>
#include "un/config.h"
#include "un/tokenizer.h"
#include "util/command/Command.h"
#include "util/command/CommandElement.h"
#include "util/command/CommandException.h"

util::command::CommandLine::CommandLine(int argc, char** argv) :
    argc(argc)
{
    int n = 0;
    while (n < argc) {
        this->argv.push_back(argv[n]);
        n++;
    }
}

util::command::CommandLine::~CommandLine() {
}

// Add a variable to the list of variables that the program should try to extract from the command line

void util::command::CommandLine::add(CommandElement* p) {
    options.insert(p);
}

// Parse the command line and read data into the specified variables

void util::command::CommandLine::digest() {
    int n = 1;
    while (n < argc) {
        if (argv[n][0] == '-') {
            // Look for parameters
            // TODO: handle --option=value and --option="value"
            un::tokenizer st(argv[n], "=");

            std::vector<std::string>::const_iterator arg = st.begin();
            util::command::CommandElement pattern(*arg, false);
            std::set<util::command::CommandElement*, util::command::CommandElementLess>::iterator i = options.find(&pattern);
            if (i == options.end())
                throw util::command::CommandException("unknown parameter \"" + argv[n] + "\"");
            util::command::CommandElement* p = *i;
            arg++;

            p->digest(*arg);
        }
        else
            args.push_back(argv[n]);
        n++;
    }
    verify();
}

void util::command::CommandLine::verify() const {
    std::set<util::command::CommandElement*, util::command::CommandElementLess>::const_iterator i = options.begin();
    while (i != options.end()) {
        if ((*i)->required() && !(*i)->found())
            throw util::command::CommandException("required option \"" + (*i)->name() + "\" not found on command line");
        i++;
    }
}

#if debug_build
std::ostream& operator<<(std::ostream& os, util::command::CommandLine& cl) {
    std::set<util::command::CommandElement*, util::command::CommandElementLess>::iterator i = cl.options.begin();
    while (i != cl.options.end()) {
        (**i).print(os); // includes std::endl
        i++;
    }
    return os;
}
#endif

