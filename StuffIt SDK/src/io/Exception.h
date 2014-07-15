// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Exception.h,v 1.2 2001/03/06 08:39:07 serge Exp $

#if !defined io_Exception_h_included
#define io_Exception_h_included

#include <string>
#include "un/exception.h"

/** Exception class used to transmit error information from I/O classes.

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/06 08:39:07 $
*/

namespace io {
    class Exception : public un::exception {
    public:
        /** Constructor. Sets the error message.
        @param reason error message
        */
        Exception(const std::string& reason) :
            un::exception(reason, "I/O") {
        }

        /** Copy constructor. */
        Exception(const Exception& e) :
            un::exception(e.reason(), e.type()) {
        }

        /** Destructor. */
        virtual ~Exception() {
        }
    };
}

#endif // io_Exception_h_included

