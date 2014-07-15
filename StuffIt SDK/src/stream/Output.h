// $Id: Output.h,v 1.20 2001/03/14 21:15:16 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_Output_h_included
#define stream_Output_h_included

#include "stream/common.h"
#include "stream/Exception.h"
#include "un/hint.h"
namespace stream { class Input; }

/** This abstract class is the superclass of all classes representing an output
stream of characters.

<p>This class may serve as an abstract interface for objects that provide
externally driven output via <code>write()</code>.

<p>Applications that need to define a subclass of <code>stream::Output</code>
must always provide a method that writes one character to the output.

@author serge@aladdinsys.com
@version $Revision: 1.20 $, $Date: 2001/03/14 21:15:16 $
*/

namespace stream {
    class Output {
    public:
        /** Destructor. */
        virtual ~Output() {
            try {
                flush();
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

        /** Writes a character to the stream. This method blocks until output is
        completed, fails, or an exception is thrown. A subclass must provide an
        implementation of this method.

        @param c the character to write
        */
        virtual void write(char c) = 0;

        /** Writes <code>size</code> characters from the specified array of
        characters to the stream.

        @param buf the array of characters from which the data is written
        @param size the number of characters to write
        */
        virtual void write(const char* buf, size_t size) {
            hint_line(true, "Using potentially inefficient stream::Writable::write()");
            if (buf != 0 && size > 0)
                for (size_t i = 0; i < size; i++)
                    write(buf[i]);
        }

        /** Appends <code>size</code> characters of data to the stream.
        @param size the number of characters to append
        @param c the character used to fill the stream
        */
        virtual void fill(stream::size size = 1, char c = '\0') {
            while (size > 0) {
                write(c);
                size--;
            }
        }
        /** Copies the specified number of characters from an input stream.
        <code>stream::unknown_size</code>) copies the entire input stream.
        @param in the input stream to copy from
        @param size (optional) the number of characters to copy, or <code>stream::unknown_size</code>
        @return the number of characters copied
        */
        virtual stream::size copy(stream::Input& in, stream::size size = stream::unknown_size);

        /** Returns the absolute (from the beginning of the stream) position at which
        the next write occurs.

        @return the absolute position
        */
        virtual stream::size tell() const = 0;

        /** Returns the size of the stream.
        @return the size of the stream
        */
        virtual stream::size size() const {
            return tell();
        }

        /** Resizes the stream. Truncates or extends the container object
        (such as file) of a subclass. The contents of the extended portion are
        undefined. When truncating, this method can truncate the container
        object only at the current stream position; it cannot <i>shorten</i>
        the container object.

        @param size the new size of the stream
        @exception stream::Exception if the stream cannot be resized
        */
        virtual void resize(stream::size size) {
            stream::size streamSize = this->size();
            if (size < streamSize)
                throw stream::Exception("default stream::Output::resize() does not truncate its stream");
            else if (size > streamSize)
                fill(size - streamSize);
            // else size == size(), nothing to do
        }

        /** Flushes the output stream and forces any buffered output characters
        to be written out.
        */
        virtual void flush() {
        }

        /** Closes the stream and releases all resources associated with the stream. */
        virtual void close() {
        }
    };
}

#endif

