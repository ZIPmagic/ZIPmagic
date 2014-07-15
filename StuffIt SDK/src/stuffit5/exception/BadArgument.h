// $Id: BadArgument.h,v 1.1.2.1 2001/07/05 23:32:38 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_exception_BadArgument_h_included
#define stuffit5_exception_BadArgument_h_included

#include "stuffit5/exception/Exception.h"

/** Invalid input or input arguments.

<p>Exception class used to indicate invalid input or input arguments.

<p>Objects of this class are thrown by StuffIt Engine when, for example, it is
given an incorrect number of file arguments.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:38 $
*/

namespace stuffit5 {
    namespace exception {
        class BadArgument : public stuffit5::exception::Exception {
        public:
            /** Constructor. Sets the error message.
            @param reason error message
            */
            BadArgument(const std::string& reason) :
                stuffit5::exception::Exception(reason, "Bad argument") {
            }

            /** Copy constructor. */
            BadArgument(const BadArgument& e) :
                stuffit5::exception::Exception(e.reason(), e.type()) {
            }

            /** Destructor. */
            virtual ~BadArgument() {
            }
        };
    }
}

#endif

