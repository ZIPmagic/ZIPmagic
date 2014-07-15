// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: command.CommandElement.cpp,v 1.1.2.1 2001/07/05 23:35:34 serge Exp $

#include "util/command/CommandElement.h" // own header
#include "un/config.h"
#include "un/tokenizer.h"

util::command::CommandElement::CommandElement(const std::string& names, bool required) :
    required(required) {
    found(false);
    un::tokenizer st(names, "|");
    std::vector<std::string>::const_iterator i = st.begin();
    if (i != st.end())
        name(*i);
}

util::command::CommandElement::~CommandElement() {
}

void util::command::CommandElement::digest(const std::string& /*arg*/) {
}

void util::command::CommandElement::print(std::ostream& /*os*/) {
}

#if debug_build
std::ostream& operator<<(std::ostream& os, util::command::CommandElement& ce) {
    ce.print(os);
    return os;
}
#endif

