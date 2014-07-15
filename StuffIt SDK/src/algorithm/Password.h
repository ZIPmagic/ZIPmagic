// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Password.h,v 1.5 2001/03/06 08:38:44 serge Exp $

#if !defined algorithm_Password_h_included
#define algorithm_Password_h_included

#include <algorithm>
#include <string>
#include "un/property.h"

/** Stores a password.

<p>This class represents a password (string) of arbitrary length, common to
multiple cryptographic algorithms. Uses <code>std::string</code> to store the
password.

@author serge@aladdinsys.com
@version $Revision: 1.5 $, $Date: 2001/03/06 08:38:44 $
*/

namespace algorithm {
    class Password {
    public:
        /** Default constructor. Creates an empty key. */
        Password() :
            password() {
        }

        /** Constructor.
        @param s a string to copy the password from */
        Password(const std::string& s) :
            password(s) {
        }

        /** Constructor.
        @param s a zero-terminated const char array to copy the password from */
        Password(const char* s) :
            password(s) {
        }

        /** Destructor. */
        virtual ~Password() {
            erase();
        }

        /** Erases the contents of the key. */
        virtual void erase() {
            std::fill(password().begin(), password().end(), '\0');
        }

        /** Key storage. */
        un::property<std::string> password;
    };
}

#endif // algorithm_Password_h_included

