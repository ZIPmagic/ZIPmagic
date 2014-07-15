// $Id: stream.ArrayInput.cpp,v 1.5 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#include "stream/ArrayInput.h" // own header
#include "stream/Exception.h"
#include "stream/Output.h"

stream::ArrayInput::ArrayInput(const char* buf, size_t size) :
    buf(buf),
    bufSize(size),
    pos(0) {
}

stream::ArrayInput::ArrayInput(const un::array<char>& array) :
    buf(array.as_array()),
    bufSize(array.size()),
    pos(0) {
}

int stream::ArrayInput::read() {
    if (pos >= bufSize)
        return stream::eof;
    else
        return static_cast<int>(buf[pos++]) & 0xff;
}

size_t stream::ArrayInput::read(char* buf, size_t size) {
    size_t result = 0;
    while (size > 0) {
        if (pos >= bufSize)
            break;
        else {
            *buf++ = this->buf[pos++];
            result++;
        }
        size--;
    }
    return result;
}

stream::size stream::ArrayInput::skip(stream::size size) {
    if (size > static_cast<size_t>(-1))
        throw stream::Exception("stream::ArrayInput::skip() cannot skip more than the maximum array size");

    size_t p = pos;
    pos += static_cast<size_t>(size);
    if (pos > bufSize)
        pos = bufSize;
    return static_cast<size_t>(pos - p);
}

stream::size stream::ArrayInput::copy(stream::Output& out, stream::size size) {
    stream::size result = 0;

    if (size == stream::unknown_size)
        size = this->size();

    if (size > static_cast<size_t>(-1))
        throw stream::Exception("stream::ArrayInput::copy() cannot copy more than the maximum array size");

    if (size > bufSize - pos)
        throw stream::Exception("stream::ArrayInput::copy() cannot copy more data than the array contains");

    if (size > 0) {
        out.write(&buf[pos], static_cast<size_t>(size));
        result += size;
    }
    out.flush();

    return result;
}

stream::size stream::ArrayInput::size() const {
    return bufSize;
}

stream::size stream::ArrayInput::tell() const {
    return static_cast<stream::size>(pos);
}

