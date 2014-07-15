// $Id: endianness.h,v 1.3 2001/03/06 19:16:47 mhalpin Exp $
//
// Copyright (c)2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_endianness_h_included
#define un_endianness_h_included

#include "un/stdint.h"

/* Processor endianness and template functions for little- and big-endian conversions.

@author serge@aladdinsys.com
@version $Revision: 1.3 $, $Date: 2001/03/06 19:16:47 $
*/

namespace un {
    /** Determines if the processor is little-endian.
    @return <code>true</code> if the processor is little-endian
    */
    static bool littleendian() {
        static unsigned long x = 0x01020304;
        return *(unsigned char*)&x == 0x04;
    }

    /** Determines if the processor is big-endian.
    @return <code>true</code> if the processor is big-endian
    */
    static bool bigendian() {
        return !littleendian();
    }

    /** Combines <code>sizeof(T)</code> bytes in <code>buf</code> into
    a value of type <code>T</code>, least-significant byte first.
    @param buf the buffer containing the bytes of the value
    @return the value of type <code>T</code> represented by the bytes in <code>buf</code>
    */
    template<typename T> T from_lsb(const uchar_t* buf) {
        T result = 0;
        int shift = 0;
        for (size_t i = 0; i < sizeof(T); i++) {
            result |= static_cast<T>(buf[i] << shift);
            shift += 8;
        }
        return result;
    }

    /** Splits a value of type <code>T</code> into bytes, least-significant
    byte first, and stores in <code>buf</code>.
    @param value a value of type <code>T</code>
    @param buf the buffer to put bytes into
    */
    template<typename T> void to_lsb(const T& value, uchar_t* buf) {
        int shift = 0;
        for (size_t i = 0; i < sizeof(T); i++) {
            buf[i] = static_cast<uchar_t>((value >> shift) & 0xff);
            shift += 8;
        }
    }

    /** Changes the endianness of a value of an arbitrary type. Inverts byte order.
    @param value the value to invert
    */
    template<typename T> T invert(const T& value) {
        T result = 0;
        int shift1 = (sizeof(T) - 1) * 8;
        int shift2 = 0;
        for (size_t i = 0; i < sizeof(T); i++) {
            result |= static_cast<T>(static_cast<uchar_t>((value >> shift1) & 0xff) << shift2);
            shift1 -= 8;
            shift2 += 8;
        }
        return result;
    }

    /** Changes the endianness of a value of an arbitrary type to big-endian.
    @param value the value to convert to big-endian
    */
    template<typename T> T to_bigendian(const T& value) {
        if (bigendian())
            return value;
        else
            return invert(value);
    }

    /** Changes the endianness of a value of an arbitrary type to little-endian.
    @param value the value to convert to little-endian
    */
    template<typename T> T to_littleendian(const T& value) {
        if (bigendian())
            return value;
        else
            return invert(value);
    }
}

#endif

