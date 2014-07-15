// $Id: Input.h,v 1.17 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_Input_h_included
#define stream_Input_h_included

#include "stream/common.h"
#include "un/hint.h"
namespace stream { class Output; }

/** This abstract class is the superclass of all classes representing an input
stream of characters.

<p>This class may serve as an abstract interface for objects that provide
externally driven input via <code>read()</code>.

<p>Applications that need to define a subclass of <code>stream::Input</code>
must always provide a method that returns the next character of input.

@author serge@aladdinsys.com
@version $Revision: 1.17 $, $Date: 2001/03/14 21:15:16 $
*/

namespace stream {
    class Input {
    public:
        /** Destructor. */
        virtual ~Input() {
            try {
                close();
            }
            catch (...) {
            }
        }

        /** Begins processing a data stream. May be used to open or reset
        underlying storage or initialize a transform. */
        virtual void begin() {
        }

        /** Completes processing a data stream. May be used to close or flush
        underlying storage or complete a transform. */
        virtual void end() {
        }

        /** Reads the next character of data from the stream. Returns
        <code>stream::eof</code> at the end of the stream.
        @return the character read, or <code>stream::eof</code>
        */
        virtual int read() = 0;

        /** Reads up to <code>size</code> characters from the stream into an array of
        characters. Returns the number of characters read which can be less than <code>size</code>
        at the end of the stream.

        @param buf array of characters into which the data is read
        @param size maximum number of characters to read
        @return the number of characters read into the array
        */
        virtual size_t read(char* buf, size_t size) {
            size_t result = 0;

            if (size > 0) {
                hint_line(true, "Using potentially inefficient stream::Readable::read()");

                while (size > 0) {
                    int c = read();
                    if (c == stream::eof)
                        return result;
                    *(buf++) = static_cast<char>(c);
                    result++;
                    size--;
                }
            }

            return result;
        }

        /** Skips over and discards <code>size</code> characters of data from the
        stream. This method may skip over a smaller number of characters, possibly
        <code>0</code>. The actual number of characters skipped is returned.

        <p>This method reads data into an array until <code>size</code> characters have
        been read or the end of the stream has been reached. Subclasses are
        encouraged to provide a more efficient implementation of this method.

        @param size the number of characters to skip
        @return the actual number of characters skipped
        */
        virtual stream::size skip(stream::size size = 1) {
            stream::size result = 0;

            if (size > 0) {
                hint_line(true, "Using potentially inefficient stream::Readable::skip()");

                while (size > 0 && read() != stream::eof) {
                    result++;
                    size--;
                }
            }

            return result;
        }

        /** Copies the specified number of characters to an output stream.
        <code>stream::unknown_size</code>) copies the entire stream.
        @param out output stream to copy to
        @param size (optional) the number of characters to copy, or <code>stream::unknown_size</code>
        @return the number of characters copied
        */
        virtual stream::size copy(stream::Output& out, stream::size size = stream::unknown_size);

        /** Returns the absolute (from the beginning of the stream) position
        at which the next read occurs.
        @return the absolute position
        */
        virtual stream::size tell() const = 0;

        /** Returns the size of the stream, or <code>stream::unknown_size</code> when
        size is unknown.
        @return the size of the stream
        */
        virtual stream::size size() const {
            return stream::unknown_size;
        }

        /** Closes the stream and releases all resources associated with the stream. */
        virtual void close() {
        }
    };
}

#endif

