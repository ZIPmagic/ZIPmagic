// $Id: Output.h,v 1.1.2.1 2001/07/05 23:32:38 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_exception_Output_h_included
#define stuffit5_exception_Output_h_included

#include "stuffit5/exception/Exception.h"

/** Failure to create an output (file) stream or to write to an output stream.

<p>Exception class used to indicate failure to create an output (file) stream
or to write to an output stream.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/07/05 23:32:38 $
*/

namespace stuffit5 {
    namespace exception {
        class Output : public stuffit5::exception::Exception {
        public:
            /** Constructor. Sets the error message.
            @param reason error message
            */
            Output(const std::string& reason) :
                stuffit5::exception::Exception(reason, "Output") {
            }

            /** Copy constructor. */
            Output(const Output& e) :
                stuffit5::exception::Exception(e.reason(), e.type()) {
            }

            /** Destructor. */
            virtual ~Output() {
            }
        };
    }
}

#endif

