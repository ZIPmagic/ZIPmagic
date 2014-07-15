// $Id: HexInput.h,v 1.2 2001/03/14 21:15:15 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_HexInput_h_included
#define stream_HexInput_h_included

#include "un/math.h"
#include "stream/FilterInput.h"

/** This class reads data items of various types from its input stream.

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/14 21:15:15 $
*/

namespace stream {
    class HexInput : public stream::FilterInput {
    public:
        typedef stream::FilterInput super;

        /** Constructor. Creates a new numeric input stream to read data from the
        specified input stream.
        @param in underlying input stream
        */
        HexInput(stream::Input& in) :
            FilterInput(in) {
        }

        /** Destructor. */
        ~HexInput() {
        }

        int read() {
            int c1 = super::read();
            int c2 = super::read();
            if (c1 == stream::eof || c2 == stream::eof)
                return stream::eof;
            return un::from_digit(c1) * 16 + un::from_digit(c2);
        }

        size_t read(char* buf, size_t size) {
            size_t result = 0;

            while (size > 0) {
                int c = read();
                if (c == stream::eof)
                    return result;
                *(buf++) = static_cast<char>(c);
                result++;
                size--;
            }

            return result;
        }
    };
}

#endif

