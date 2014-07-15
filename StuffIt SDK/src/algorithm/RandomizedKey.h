// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: RandomizedKey.h,v 1.4 2001/03/06 08:38:44 serge Exp $

#if !defined algorithm_RandomizedKey_h_included
#define algorithm_RandomizedKey_h_included

#include <vector>
#include "algorithm/Key.h"
#include "un/property.h"

/** Stores a randomized cryptographic key.

<p>This class represents a randomized cryptographic key of arbitrary length,
common to multiple cryptographic algorithms. Adds salt to
<code>algorithm::Key</code>; uses <code>std::vector&lt;char></code>
to store it.

<p>This class not only serves a data container but also aids in preventing
key duplication by erasing non-constant key data when "taking over" a key
and upon its own destruction.

<p>Note that this class has the same constructors as <code>algorithm::Key<code>.
To add or change salt, access the value of the salt through its property interface.

@author serge@aladdinsys.com
@version $Revision: 1.4 $, $Date: 2001/03/06 08:38:44 $
*/

namespace algorithm {
    class RandomizedKey : public algorithm::Key {
    public:
        /** Default constructor. Creates an empty key. */
        RandomizedKey() {
        }

        /** Constructor. Creates a key from a constant array of characters.
        @param key constant array of key characters
        @param keySize key array size
        */
        RandomizedKey(const char* key, size_t keySize) :
            algorithm::Key(key, keySize) {
        }

        /** Constructor. Creates a key from a constant vector of characters.
        @param key a constant vector of characters
        */
        RandomizedKey(const std::vector<char>& key) :
            algorithm::Key(key) {
        }

        /** Constructor. Creates a key from a non-constant vector of characters.
        @param key a non-constant vector of characters
        @param eraseKey if <code>true</code>, erase the contents of the key vector
        */
        RandomizedKey(std::vector<char>& key, bool eraseKey = false) :
            algorithm::Key(key, eraseKey) {
        }

        /** Destructor. */
        virtual ~RandomizedKey() {
            erase();
        }

        /** Salt value. */
        un::property<std::vector<char> > salt;
    };
}

#endif // algorithm_RandomizedKey_h_included

