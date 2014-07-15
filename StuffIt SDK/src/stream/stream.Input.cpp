// $Id: stream.Input.cpp,v 1.5 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#include "stream/Input.h" // own header
#include "un/auto_array.h"
#include "stream/Output.h"
#include "un/config.h"

stream::size stream::Input::copy(stream::Output& out, stream::size size) {
    stream::size result = 0;

    if (size == stream::unknown_size)
        size = this->size() - tell();

    if (size > 0) {
        hint_line(true, "Using potentially inefficient stream::Input::copy()");
        int c;
        do {
            c = read();
            if (c != stream::eof) {
                out.write(static_cast<char>(c));
                result++;
                size--;
            }
        } while (size > 0 && c != stream::eof);
    }
    out.flush();

    return result;
}

