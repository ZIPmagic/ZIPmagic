// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: CommandElement.h,v 1.8 2001/03/06 08:39:12 serge Exp $

#if !defined util_command_CommandElement_h_included
#define util_command_CommandElement_h_included

#include "un/warnings.h"
#include <iostream>
#include <string>
#include <vector>
#include "un/property.h"
#include "un/config.h"

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.8 $, $Date: 2001/03/06 08:39:12 $
*/

namespace util {
    namespace command {
        class CommandElement {
        public:
            /** Constructor.
            @param names the (possibly multiple) names of the option, separated by <code>'|'</code>
            @param required <code>true</code> if option is required */
            CommandElement(const std::string& names, bool required);

            /** Destructor. */
            virtual ~CommandElement();

            /** Option name, one or more characters long. */
            mutable un::property<std::string> name;

            /** Option is required if <code>true</code>. */
            const un::property<bool> required;

            /** Option was found on the command line if <code>true</code>. */
            un::property<bool> found;

            virtual void digest(const std::string& arg);

            virtual void print(std::ostream& os);

            /** operator<< prints the details of the CommandElement.
            @param os output stream
            @param option CommandElement to print
            */
            #if debug_build
            friend std::ostream& operator<<(std::ostream& os, util::command::CommandElement& ce);
            #endif
        };
    }
}

#include "util/command/CommandElementLess.h"

#endif // util_command_CommandElement_h_included

