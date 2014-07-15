// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: CommandLine.h,v 1.4 2001/03/06 01:37:26 serge Exp $

#if !defined util_command_CommandLine_h_included
#define util_command_CommandLine_h_included

#include "un/warnings.h"
#include <iostream>
#include <list>
#include <string>
#include <set>
#include <vector>
#include "un/config.h"
#include "util/command/CommandElement.h"
#include "util/command/CommandException.h"

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.4 $, $Date: 2001/03/06 01:37:26 $
*/

namespace util {
    namespace command {
        class CommandLine {
        public:
            CommandLine(int argc, char** argv);
            ~CommandLine();

            void add(util::command::CommandElement* p); // add a variable to the list to be parsed
            void digest(); // parse command line and update variables

            std::vector<std::string> args;
            std::set<util::command::CommandElement*, util::command::CommandElementLess> options;

            #if debug_build
            friend std::ostream& operator<<(std::ostream& os, util::command::CommandLine& cl);
            #endif

        private:
            void verify() const;

            const int argc; // number of arguments
            mutable std::vector<std::string> argv; // argument list
        };
    }
}

#endif // util_command_CommandLine_h_included

