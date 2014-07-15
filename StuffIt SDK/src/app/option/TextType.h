// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: TextType.h,v 1.2 2001/03/07 21:13:49 serge Exp $

#if !defined app_option_TextType_h_included
#define app_option_TextType_h_included

#include <string>
#include "stuffit5/TextType.h"
#include "util/command/Command.h"

/** Text type command-line option.

<p>A class that interprets the text type command-line option. Converts from
human-readable representation to a value of type <code>stuffit5_TextType_type</code>.

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/07 21:13:49 $
*/

namespace app {
    namespace option {
        class TextType : public util::command::Command<std::string> {
        public:
            TextType(util::command::CommandLine& options, const std::string& names, const std::string& defaultValue) :
                util::command::Command<std::string>(options, names, defaultValue) {
            }

            virtual ~TextType() {
            }

            virtual stuffit5::TextType::type interpret() const {
                if (value().compare("native") == 0)
                    return stuffit5::TextType::native;
                else if (value().compare("win") == 0 || value().compare("windows") == 0 || value().compare("crlf") == 0)
                    return stuffit5::TextType::windows;
                else if (value().compare("unix") == 0 || value().compare("lf") == 0)
                    return stuffit5::TextType::unixx;
                else if (value().compare("mac") == 0 || value().compare("macintosh") == 0 || value().compare("cr") == 0)
                    return stuffit5::TextType::mac;
                throw util::command::CommandException("text type option must be one of: native, win, windows, crlf, unix, lf, mac, macintosh, cr");
            }
        };
    }
}

#endif // app_option_TextType_h_included

