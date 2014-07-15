// $Id: FilterInput.h,v 1.22 2001/03/14 21:15:15 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stream_FilterInput_h_included
#define stream_FilterInput_h_included

#include "stream/Input.h"
#include "un/stdint.h"

/** This class is the superclass of all classes that filter input streams.
These streams work with an existing input stream (the <i>underlying</i>
input stream) and provide additional functionality.

<p>The class <code>FilterInput</code> itself simply overrides all methods of
<code>stream::Input</code> with versions that pass all requests to the
underlying input stream. Subclasses of <code>FilterInput</code> may further
override some of these methods as well as provide additional methods and fields.

<p>This class must be subclassed to perform some sort of filtering operation,
and may not be instantiated directly. (There should be no need for a null filter
because a filter IS A stream).

<p>The underlying stream is passed as a reference but stored as a pointer and
can be changed mid-stream (so to speak).

@author serge@aladdinsys.com
@version $Revision: 1.22 $, $Date: 2001/03/14 21:15:15 $
@see stream::Input
*/

namespace stream {
    class FilterInput : public virtual stream::Input {
    public:
        /** Destructor. */
        virtual ~FilterInput() {
        }

        /** Provides access to the underlying stream.
        @return underlying input stream
        */
        virtual stream::Input& under() {
            return *input;
        }

        /** Reassigns the underlying stream.
        @param in new underlying input stream
        */
        virtual void under(stream::Input& in) {
            input = &in;
        }

        /** Begins processing a data stream. May be used to open or reset
        underlying storage or initialize a transform. */
        virtual void begin() {
            input->begin();
        }

        /** Completes processing a data stream. May be used to close or flush
        underlying storage or complete a transform. */
        virtual void end() {
            input->end();
        }

        /** Reads the next character of data from the stream. Returns
        <code>stream::eof</code> at the end of the stream.
        @return the character read, or <code>stream::eof</code>
        */
        virtual int read() {
            return input->read();
        }

        /** Reads up to <code>size</code> characters from the stream into an array of
        characters.
        @param buf array of characters into which the data is read
        @param size maximum number of characters to read
        @return the total number of characters read into the array (may be 0 at end of file)
        */
        virtual size_t read(char* buf, size_t size) {
            return input->read(buf, size);
        }

        /** Skips over and discards <code>size</code> characters of data from the
        stream. This method may skip over a smaller number of characters, possibly
        <code>0</code>. The actual number of characters skipped is returned.
        @param size the number of characters to skip
        @return the actual number of characters skipped
        */
        virtual stream::size skip(stream::size size = 1) {
            return input->skip(size);
        }

        /** Copies the specified number of characters to an output stream.
        <code>stream::unknown_size</code>) copies the entire stream.
        @param out output stream to copy to
        @param size (optional) the number of characters to copy, or <code>stream::unknown_size</code>
        @return the number of characters copied
        */
        virtual stream::size copy(stream::Output& out, stream::size size = stream::unknown_size) {
            return input->copy(out, size);
        }

        /** Returns the absolute (from the beginning of the stream) position
        at which the next read occurs.
        @return the absolute position
        */
        virtual stream::size tell() const {
            return input->tell();
        }

        /** Returns the size of the stream.
        @return the size of the stream
        */
        virtual stream::size size() const {
            return input->size();
        }

        /** Closes the stream and releases all resources associated with the stream. */
        virtual void close() {
            input->close();
        }

    protected:
        /** Protected constructor. Can be invoked only by subclass' constructors.
        @param in (reference to) underlying input stream
        */
        FilterInput(stream::Input& in) :
            input(&in) {
        }

        /** The underlying input stream. */
        stream::Input* input;
    };
}

#endif

