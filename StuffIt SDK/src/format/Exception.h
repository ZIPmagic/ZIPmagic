// Copyright (c)1999-2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Exception.h,v 1.4 2001/03/06 08:38:57 serge Exp $

#if !defined format_Exception_h_included
#define format_Exception_h_included

#include "un/exception.h"

/** A format exception.

<p>The base class of all exception classes used to transmit format error
information.

@author serge@aladdinsys.com
@version $Revision: 1.4 $, $Date: 2001/03/06 08:38:57 $
*/

namespace format {
    class Exception : public un::exception {
    public:
        /** Constructor. Sets the exception type and the error message.
        @param reason error message
        @param type exception type
        */
        Exception(const std::string& reason, const std::string& type = "format") :
            un::exception(reason, type) {
        }

        /** Destructor. */
        virtual ~Exception() {
        }
    };
}

#endif // format_Exception_h_included

