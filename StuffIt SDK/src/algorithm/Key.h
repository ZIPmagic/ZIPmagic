// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Key.h,v 1.6 2001/03/06 01:36:56 serge Exp $

#if !defined algorithm_Key_h_included
#define algorithm_Key_h_included

#include <algorithm>
#include <vector>
#include "un/stdint.h"

/** Stores a cryptographic key.

<p>This class represents a cryptographic key of arbitrary length, common to
multiple cryptographic algorithms. Uses <code>std::vector&lt;char></code>
to store the key.

<p>This class not only serves a data container but also aids in preventing
key duplication by erasing non-constant key data when "taking over" a key
and upon its own destruction.

@author serge@aladdinsys.com
@version $Revision: 1.6 $, $Date: 2001/03/06 01:36:56 $
*/

namespace algorithm {
    class Key : public std::vector<char> {
    public:
        /** Default constructor. Creates an empty key. */
        Key() {
        }

        /** Constructor. Creates a key from a constant array of characters.
        @param key constant array of key characters
        @param keySize key array size
        */
        Key(const char* key, size_t keySize) :
            std::vector<char>(key, key + keySize) {
        }

        /** Constructor. Creates a key from a constant vector of characters.
        @param key a constant vector of characters
        */
        Key(const std::vector<char>& key) :
            std::vector<char>(key) {
        }

        /** Constructor. Creates a key from a non-constant vector of characters.
        @param key a non-constant vector of characters
        @param eraseKey if <code>true</code>, erase the contents of the key vector
        */
        Key(std::vector<char>& key, bool eraseKey = false) :
            std::vector<char>(key) {
            if (eraseKey)
                std::fill(key.begin(), key.end(), '\0');
        }

        /** Destructor. */
        virtual ~Key() {
            erase();
        }

    protected:
        /** Erases the contents of the key. */
        virtual void erase() {
            std::fill(begin(), end(), '\0');
        }
    };
}

#endif // algorithm_Key_h_included

