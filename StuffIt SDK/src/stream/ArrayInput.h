// $Id: ArrayInput.h,v 1.13 2001/03/14 21:15:15 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_ArrayInput_h_included
#define stream_ArrayInput_h_included

#include "un/array.h"
#include "stream/Input.h"

/** This class implements an input stream that reads data from a fixed-size
array of characters.

@author serge@aladdinsys.com
@version $Revision: 1.13 $, $Date: 2001/03/14 21:15:15 $
@see stream::Input
*/

namespace stream {
    class ArrayInput : public virtual stream::Input {
    public:
        /** Constructor. Creates a new stream to read data from an array of characters.
        @param buf the array of characters
        @param size the size of the array
        */
        ArrayInput(const char* buf, size_t size);

        /** Constructor. Creates a new stream to read data from an array of characters.
        @param array the array of characters
        */
        ArrayInput(const un::array<char>& array);

        /** Destructor. */
        ~ArrayInput() {
        }

        /** Reads the next character of data from the stream. Returns
        <code>stream::eof</code> at the end of the stream.
        @return the character read, or <code>stream::eof</code>
        */
        int read();

        /** Reads up to <code>size</code> characters from the stream into
        an array of characters. Returns the number of characters read which
        can be less than <code>size</code> at the end of the stream.
        @param buf array of characters into which the data is read
        @param size maximum number of characters to read
        @return the number of characters read into the array
        */
        size_t read(char* buf, size_t size);

        /** Skips over and discards <code>size</code> characters of data from the
        stream. This method may skip over a smaller number of characters, possibly
        <code>0</code>. The actual number of characters skipped is returned.
        @param size the number of characters to skip
        @return the actual number of characters skipped
        */
        stream::size skip(stream::size size = 1);

        /** Copies the specified number of characters to an output stream.
        <code>stream::unknown_size</code>) copies the entire stream.
        @param out output stream to copy to
        @param size (optional) the number of characters to copy, or <code>stream::unknown_size</code>
        @return the number of characters copied
        */
        stream::size copy(stream::Output& out, stream::size size = stream::unknown_size);

        /** Returns the size of the stream.
        @return the size of the stream
        */
        stream::size size() const;

        /** Returns the absolute (from the beginning of the stream) position
        at which the next read occurs.
        @return the absolute position
        */
        stream::size tell() const;

    protected:
        /** The pointer to the array of characters to read from. */
        const char* buf;

        /** The size of the array of characters to read from. */
        size_t bufSize;

        /** Position in the array of characters. */
        size_t pos;
    };
}

#endif

