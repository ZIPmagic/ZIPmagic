// $Id: exception.h,v 1.1 2001/03/03 00:03:47 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_exception_h_included
#define un_exception_h_included

#include <exception>
#include <string>
#include "un/property.h"

/** Exception superclass.

<p>The superclass of all exceptions. Carries a human-readable exception type
and a human-readable error message.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2001/03/03 00:03:47 $
*/

namespace un {
    class exception : public std::exception {
    public:
        /** Default constructor.
        @param type exception type
        @param reason error message
        */
        exception(const std::string& reason, const std::string& type = "un") :
            reason(reason),
            type(type) {
        }

        /** Copy constructor. */
        exception(const exception& e) :
            reason(e.reason()),
            type(e.type()) {
        }

        /** Destructor. */
        virtual ~exception() {
        }

        /** Exception message. This method is provided for compatibility with
        <code>std::exception</code>.
        @return message string
        */
        virtual const char* what() const {
            return reason().c_str();
        }

        /** Error message. A human-readable string. */
        const un::property<std::string> reason;

        /** Exception type. A human-readable string. */
        const un::property<std::string> type;
    };
}

#endif // un_exception_h_included

