// $Id: Exception.h,v 1.3 2001/03/14 21:15:15 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_Exception_h_included
#define stream_Exception_h_included

#include <string>
#include "un/exception.h"

/** A stream exception.

<p>The base class of all exception classes used to transmit stream error
information.

@author serge@aladdinsys.com
@version $Revision: 1.3 $, $Date: 2001/03/14 21:15:15 $
*/

namespace stream {
    class Exception : public un::exception {
    public:
        /** Constructor. Sets the exception type and the error message.
        @param reason error message
        @param type exception type
        */
        Exception(const std::string& reason, const std::string& type = "stream") :
            un::exception(reason, type) {
        }

        /** Destructor. */
        virtual ~Exception() {
        }
    };
}

#endif

