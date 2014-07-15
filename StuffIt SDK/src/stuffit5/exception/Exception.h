// $Id: Exception.h,v 1.2.2.1 2001/07/05 23:32:38 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_exception_Exception_h_included
#define stuffit5_exception_Exception_h_included

#include "un/exception.h"

/** StuffIt Engine exception.

<p>The base class of all exception classes used to transmit engine error
information.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:32:38 $
*/

namespace stuffit5 {
    namespace exception {
        class Exception : public un::exception {
        public:
            /** Constructor. Sets the exception type and the error message.
            @param type exception type
            @param reason error message
            */
            Exception(const std::string& reason, const std::string& type = "StuffIt Engine") :
                un::exception(reason, type) {
            }

            /** Constructor. Sets the error message.
            @param reason error message
            */
            Exception(const std::string& reason) :
                un::exception(reason, "StuffIt Engine") {
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
}

#endif

