// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: CommandException.h,v 1.4 2001/03/06 08:39:12 serge Exp $

#if !defined util_command_CommandException_h_included
#define util_command_CommandException_h_included

#include <iostream>
#include <string>
#include "un/exception.h"

/** Exception class used to transmit CommandLine error information.

@author serge@aladdinsys.com
@version $Revision: 1.4 $, $Date: 2001/03/06 08:39:12 $
*/

namespace util {
    namespace command {
        class CommandException : public un::exception {
        public:
            /** Constructor. Sets the error message.
            @param reason error message
            */
            CommandException(const std::string& reason) :
                un::exception(reason, "Command") {
            }

            /** Copy constructor. */
            CommandException(const CommandException& e) :
                un::exception(e.reason(), e.type()) {
            }

            /** Destructor. */
            virtual ~CommandException() {
            }
        };
    }
}

#endif // util_command_CommandException_h_included

