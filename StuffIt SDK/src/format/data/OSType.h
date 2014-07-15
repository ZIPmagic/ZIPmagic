// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: OSType.h,v 1.12.2.1 2001/04/17 19:13:50 serge Exp $

#if !defined format_data_OSType_h_included
#define format_data_OSType_h_included

#include <string>
#include "format/Header.h"
#include "un/property.h"
#include "un/stdint.h"

/** Macintosh <code>OSType</code>. 4 bytes long.

<p>Used for MacOS type and creator file attribute (both are four characters long).

<p>The stored value is dual-typed: it can be interpreted as a 32-bit unsigned
integer (<code>uint32_t</code>) or as a (four-character) string
(<code>std::string</code>).

<p>When the value is treated as a string, it must be four characters long and
(obviously) cannot contain null characters. For types and creators that can
contain null characters, restrict the use of this class to <code>uint32_t</code>
based constructor and member functions.

@author serge@aladdinsys.com
@version $Revision: 1.12.2.1 $, $Date: 2001/04/17 19:13:50 $
*/

namespace format {
    namespace data {
        class OSType : public format::Header {
        public:
            /** Default constructor. Uses four (or all, if less than four) characters
            of the string to assign the type.
            @param type mnemonic for the type to assign
            */
            OSType(const char* type = "????");

            /** Construct from a uint23_t value.
            @param type the type to assign
            */
            OSType(uint32_t type);

            /** Destructor. */
            ~OSType() {
            }

            /** Determines if the structure is valid.
            @return <code>true</code> when the structure is valid
            */
            bool valid() const;

            /** Reads the structure from an input stream.
            @param in an input stream
            @param verify verify data if <code>true</code>
            */
            void read(stream::Input& in, bool verify = true);

            /** Writes the structure to an output stream.
            @param out an output stream
            */
            void write(stream::Output& out) const;

            /** Returns the size of the header.
            @return the size of the header
            */
            size_t size() const {
                return fixed_size();
            }

            /** Returns the size of the fixed part of the header.
            @return the size of the fixed part of the header
            */
            static size_t fixed_size();

            /** Returns the minimum size of the header.
            @return the minimum size of the header
            */
            static size_t min_size() {
                return fixed_size();
            }

            /** Returns the maximum size of the header.
            @return the maximum size of the header
            */
            static size_t max_size() {
                return fixed_size();
            }

            /** Accessor.
            @return the stored value as an integer
            */
            uint32_t value() const;

            /** Mutator.
            @param s the new value as an integer
            */
            void value(uint32_t n);

            /** Alternative accessor.
            @return the stored value as a string
            */
            std::string stringValue() const;

            /** Alternative mutator.
            @param s the new value as a string
            */
            void stringValue(const std::string& s);

        protected:
            /** The value of either Macintosh type or creator. */
            uint32_t v;

            /** Data layout. For naming and layout reference only. */
            typedef union {
                uint32_t value;
                char stringValue[4]; // only in big-endian architectures
            } layout;

        };
    }
}

#endif // format_data_OSType_h_included

