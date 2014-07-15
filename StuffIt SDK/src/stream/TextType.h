// $Id: TextType.h,v 1.6 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_TextType_h_included
#define stream_TextType_h_included

#include "un/config.h"

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.6 $, $Date: 2001/03/14 21:15:16 $
*/

namespace stream {
    namespace TextType {
        /** Underlying type. */
        typedef int type;

        /** No type. */
        const stream::TextType::type none = 0;

        /** The text file format with line feed (LF) end-of-lines. */
        const stream::TextType::type lf = 1;

        /** The text file format with carriage return (CR) end-of-lines. */
        const stream::TextType::type cr = 2;

        /** The text file format with carriage return (CR) and line feed (LF)
        end-of-lines. */
        const stream::TextType::type crlf = 3;

        /** The UNIX text file format with line feed (LF) end-of-lines. */
        const stream::TextType::type unixx = 1;

        /** The Macintosh text file format with carriage return (CR) end-of-lines. */
        const stream::TextType::type mac = 2;

        /** The DOS/Windows text file format with carriage return (CR) and line feed
        (LF) end-of-lines. */
        const stream::TextType::type windows = 3;

        /** The text file format of the operating system on which the engine is running. */
        #if platform_win32 || platform_cygwin
            const stream::TextType::type native = windows;
        #elif platform_macintosh
            const stream::TextType::type native = mac;
        #else
            const stream::TextType::type native = unixx;
        #endif

        static bool valid(stream::TextType::type textType) {
            return textType == lf || textType == cr || textType == crlf;
        }

        static bool hasLF(stream::TextType::type textType) {
            return textType == lf || textType == crlf;
        }

        static bool hasCR(stream::TextType::type textType) {
            return textType == cr || textType == crlf;
        }
    }
}

#endif

