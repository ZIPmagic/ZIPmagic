// $Id: stream.Output.cpp,v 1.4 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
#include "stream/Output.h" // own header
#include "stream/Exception.h"
#include "stream/Input.h"
#include "un/config.h"

stream::size stream::Output::copy(stream::Input& in, stream::size size) {
    stream::size result = 0;

    if (size == stream::unknown_size)
        size = in.size();

    if (size > 0) {
        hint_line(true, "Using potentially inefficient stream::Output::copy()");
        int c;
        do {
            c = in.read();
            if (c != stream::eof) {
                write(static_cast<char>(c));
                result++;
                size--;
            }
        } while (size > 0 && c != stream::eof);
    }
    flush();

    return result;
}

