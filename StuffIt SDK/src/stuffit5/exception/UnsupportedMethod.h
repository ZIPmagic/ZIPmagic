// $Id: UnsupportedMethod.h,v 1.1.2.1 2001/07/05 23:32:38 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_exception_UnsupportedMethod_h_included
#define stuffit5_exception_UnsupportedMethod_h_included

#include "stuffit5/exception/Exception.h"

/** Unsupported method.

<p>Exception class used to indicate unsupported compression or encryption
methods.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:38 $
*/

namespace stuffit5 {
    namespace exception {
        class UnsupportedMethod : public stuffit5::exception::Exception {
        public:
            /** Constructor. Sets the error message.
            @param reason error message
            */
            UnsupportedMethod(const std::string& reason) :
                stuffit5::exception::Exception(reason, "Unsupported method") {
            }

            /** Copy constructor. */
            UnsupportedMethod(const UnsupportedMethod& e) :
                stuffit5::exception::Exception(e.reason(), e.type()) {
            }

            /** Destructor. */
            virtual ~UnsupportedMethod() {
            }
        };
    }
}

#endif

