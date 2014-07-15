// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: CommandElementLess.h,v 1.1 1999/04/12 22:11:10 serge Exp $

#if !defined util_command_CommandElementLess_h_included
#define util_command_CommandElementLess_h_included

#include <functional>

/** This class is a <code>binary_function</code> that defines its only member operator as returning x < y.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 1999/04/12 22:11:10 $
*/

namespace util {
    namespace command {
        class CommandElementLess : public std::binary_function<util::command::CommandElement*, util::command::CommandElement*, bool> {
        public:
            /* Lexicographical comparison function for <code>CommandElement</code>s.
            Compares (short) option names.
            @param x first <code>util::command::CommandElement</code>
            @param y second <code>CommandElement</code>
            */
            bool operator()(const util::command::CommandElement* x, const util::command::CommandElement* y) const {
                return x->name() < y->name();
            }
        };
    }
}

#endif // util_command_CommandElementLess_h_included

