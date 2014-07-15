// $Id: un.tokenizer.cpp,v 1.1.4.1 2001/07/05 23:35:27 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#include "util/tokenizer.h" // own header
#include "un/config.h"
#include "un/stdint.h"

un::tokenizer::tokenizer(const std::string& str, const char* delimiters) {
    init(str, delimiters);
}

un::tokenizer::tokenizer(const std::string& str, char delimiter) {
    char delimiters[2] = { delimiter, '\0' };
    init(str, delimiters);
}

void un::tokenizer::init(const std::string& str, const char* delimiters) {
    erase(begin(), end());
    size_t n = 0;
    size_t end = 0;
    do {
        end = str.find_first_of(delimiters, n);
        if (end == std::string::npos)
            push_back(str.substr(n)); // the rest of the string
        else {
            push_back(str.substr(n, end - n));
            n = end + 1;
        }
    } while (end != std::string::npos);
}

