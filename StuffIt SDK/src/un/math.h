// $Id: math.h,v 1.1.2.1 2001/07/05 23:35:27 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_math_h_included
#define un_math_h_included

#include <algorithm>
#include <string>
#include "un/endianness.h"
#include "un/stdint.h"

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:35:27 $
*/

namespace un {
    /** Tests if a number is even. Uses the bitwise and (&) operator.
    @param n the number to test
    @return true if even, false if odd
    */
    template<typename T> bool even(const T& n) {
        return (n & 1) == 0;
    }

    /** Tests if a number is odd. Uses the bitwise and (&) operator.
    @param n the number to test
    @return true if odd, false if even
    */
    template<typename T> bool odd(const T& n) {
        return (n & 1) != 0;
    }

    /** Determines the absolute value. Uses the less than (<) operator to compare
    with 0 and the negation (-) operator.
    @param n the number
    @return the absolute value of n
    */
    template<typename T> T abs(const T& n) {
        return n < 0 ? -n : n;
    }

    /* Determines the sign of a value. Uses the less than (<) operator to compare
    with 0.
    @param n the value
    @return -1 if n is negative (less than 0), +1 otherwise
    */
    template<typename T> T sign(const T& n) {
        return n < 0 ? -1 : 1;
    }

    /** Reverses <code>bits</code> bits of <code>n</code>.
    @param n number
    @param bits number of bits to reverse
    @return number with <code>bits</code> bits reversed
    */
    template<typename T> T reverse(T n, int bits) {
        T result = 0;

        for (int i = 0; i < bits; i++) {
            result <<= 1;
            result |= n & 1;
            n >>= 1;
        }

        return result;
    }

    static char to_digit(uchar_t n) {
        if (n < 10)
            return static_cast<char>('0' + n);
        else
            return static_cast<char>('a' + (n - 10));
    }

    static uchar_t is_digit(char c) {
        return (c >= '0' && c <= '9')
            || (c >= 'A' && c <= 'Z')
            || (c >= 'a' && c <= 'z');
    }

    static uchar_t from_digit(char c) {
        if (c >= '0' && c <= '9')
            return static_cast<uchar_t>(c - '0');
        else if (c >= 'A' && c <= 'Z')
            return static_cast<uchar_t>(c - 'A' + 10);
        else if (c >= 'a' && c <= 'z')
            return static_cast<uchar_t>(c - 'a' + 10);
        else
            return 0; // throw?
    }

    /** Hex converter. Converts any object to a hexadecimal string.

    @param t a value of type <code>T</code>
    @return a hex string representing the value
    */
    template<typename T> std::string hex(const T& t) {
        std::string result;
        const uchar_t* p = reinterpret_cast<const uchar_t*>(&t);
        for (size_t i = 0; i < sizeof(T); i++) {
            if (un::bigendian()) {
                result += to_digit(p[i] / 16);
                result += to_digit(p[i] % 16);
            }
            else {
                result += to_digit(p[i] % 16);
                result += to_digit(p[i] / 16);
            }
        }
        if (un::bigendian()) {
            std::reverse(result.begin(), result.end());
        }
        return result;
    }

    /** Converts a hexadecimal string to an unsigned 64-bit integer.
    @param s hexadecimal string
    @return number read from the string
    */
    static uint64_t read(const std::string& s, int base = 10) {
        uint64_t result = 0;

        for (std::string::const_iterator i = s.begin(); i != s.end(); i++) {
            if (!un::is_digit(*i))
                break;
            result *= base;
            result += un::from_digit(*i);
        }

        return result;
    }

    /** Decimal converter. Converts an unsigned 64-bit integer to a decimal string.
    @param t an unsigned 64-bit integer
    @param base a conversion base (2 - binary, 8 - octal, 10 - decimal, 16 - hex, etc.)
    @return a decimal string representing the value
    */
    static std::string write(const uint64_t& t, int base = 10) {
        std::string result;

        uint64_t n = t;
        while (n != 0) {
            result += un::to_digit(n % base);
            n /= base;
        }
        std::reverse(result.begin(), result.end());

        return result;
    }
}

#endif

