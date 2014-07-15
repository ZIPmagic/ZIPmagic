// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdin.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: CommandSynonym.h,v 1.3 2000/03/22 01:00:04 serge Exp $

#if !defined util_command_CommandSynonym_h_included
#define util_command_VommandSynonym_h_included

#include <string>
#include "util/command/Command.h"
#include "util/command/CommandElement.h"

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.3 $, $Date: 2000/03/22 01:00:04 $
*/

namespace util {
    namespace command {
        template<typename T> class CommandSynonym : public util::command::CommandElement {
        public:
            CommandSynonym(util::command::Command<T>& option, const std::string& name);
        
            void digest(const std::string& arg) {
                option.digest(arg);
            }

        private:
            util::command::Command<T>& option;
        };
    }
}

template<typename T> util::command::CommandSynonym<T>::CommandSynonym(util::command::Command<T>& option, const std::string& name) :
    util::command::CommandElement(name, option.required()),
    option(option) {
}

#endif // util_command_CommandSynonym_h_included

