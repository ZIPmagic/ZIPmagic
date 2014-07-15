// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: data.OSType.cpp,v 1.15.2.1 2001/04/17 19:13:50 serge Exp $

#include "format/data/OSType.h" // own header
#include <algorithm>
#include "format/Exception.h"
#include "stream/Input.h"
#include "stream/Output.h"
#include "un/endianness.h"
#include "un/msvc/algorithm.h"

format::data::OSType::OSType(uint32_t type) :
    format::Header(),
    v(type) {
}

format::data::OSType::OSType(const char* type) :
    format::Header() {
    stringValue(type);
}

bool format::data::OSType::valid() const {
    return true; // all possible values are valid
}

void format::data::OSType::read(stream::Input& in, bool /*verify*/) {
    char buf[5];
    size_t n = in.read(buf, 4);
    if (n != 4)
        throw format::Exception("format::data::OSType::read() cannot read from a stream with fewer than four characters");
    buf[4] = '\0';
    stringValue(buf);
}

void format::data::OSType::write(stream::Output& out) const {
    uint32_t t = v;
    for (size_t i = 0; i < 4; i++) {
        out.write(static_cast<char>(t >> 24));
        t <<= 8;
    }
}

size_t format::data::OSType::fixed_size() {
    return sizeof(layout);
}

uint32_t format::data::OSType::value() const {
    return v;
}

void format::data::OSType::value(uint32_t n) {
    v = n;
    v = un::to_bigendian<uint32_t>(n);
}

std::string format::data::OSType::stringValue() const {
    std::string result;
    uint32_t t = v;
    for (size_t i = 0; i < 4; i++) {
        result += static_cast<char>(t >> 24);
        t <<= 8;
    }
    return result;
}

void format::data::OSType::stringValue(const std::string& s) {
    for (size_t i = 0; i < 4; i++) {
        v <<= 8;
        if (i < s.size())
            v |= s[i];
        else
            v |= ' '; // pad with spaces if still shorter than 4 characters
    }
}

