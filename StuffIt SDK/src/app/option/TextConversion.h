// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: TextConversion.h,v 1.1 2000/07/18 00:29:45 serge Exp $

#if !defined app_option_TextConversion_h_included
#define app_option_TextConversion_h_included

#include <string>
#include "stuffit5/TextConversion.h"
#include "util/command/Command.h"

/** Text conversion command-line option.

<p>A class that interprets the text conversion command-line option. Converts from
human-readable representation to a value of type <code>stuffit5_TextConversion_type</code>.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2000/07/18 00:29:45 $
*/

namespace app {
    namespace option {
        class TextConversion : public util::command::Command<std::string> {
        public:
            TextConversion(util::command::CommandLine& options, const std::string& names, const std::string& defaultValue) :
                util::command::Command<std::string>(options, names, defaultValue) {
            }

            virtual ~TextConversion() {
            }

            virtual stuffit5::TextConversion::type interpret() const {
                if (value().compare("on") == 0 || value().compare("yes") == 0)
                    return stuffit5::TextConversion::on;
                else if (value().compare("off") == 0 || value().compare("no") == 0)
                    return stuffit5::TextConversion::off;
                else if (value().compare("auto") == 0)
                    return stuffit5::TextConversion::automatic;
                throw util::command::CommandException("text conversion option must be one of: on, yes, off, no, auto");
            }
        };
    }
}

#endif // app_option_TextConversion_h_included

