// $Id: ErrorListener.h,v 1.3.2.1 2001/07/05 23:32:35 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_event_ErrorListener_h_included
#define stuffit5_event_ErrorListener_h_included

/** Event handler for recoverable error conditions.

<p>This abstract class is a base class of all classes (readers and writers) that
customize the <code>error</code> event callback.

<p>This event callback is invoked when a recoverable error condition is
encountered.

<p>Non-recoverable error conditions result in engine function calls throwing an
exception.

<p>Returning <code>false</code> from this callback causes the reader or writer
to abort the operation and throw the exception corresponding to the error type
indicated in the event callback.

<p>If this event callback is not customized, the default action is to continue
processing.

<p><b>Example:</b>

<p>When a reader encounters a file that cannot be expanded, but the archive
format being processed contains multiple files, and allows the reader to proceed
with the next file, this event callback may be invoked with an error code
indicating an unsupported format,
<code>stuffit5::Error::UnsupportedMethod</code>.

<p>Returning <code>true</code> from the callback means "continue the operation"
and causes the reader to skip to the next file and continue scanning or
expanding the archive if possible.

<p>Returning <code>false</code> from the callback means "abort the operation"
and causes the reader to throw an exception of type
<code>stuffit5::exception::UnsupportedFormat</code>.

@author serge@aladdinsys.com
@version $Revision: 1.3.2.1 $, $Date: 2001/07/05 23:32:35 $
@see stuffit5::Writer
*/

#if defined __cplusplus

#include "stuffit5/Error.h"
#include "stuffit5/event/Listener.h"

namespace stuffit5 {
    namespace event {
        class ErrorListener : public stuffit5::event::Listener {
        public:
            /** Destructor. */
            virtual ~ErrorListener() {
            }

            /** Event callback invoked to indicate a recoverable error condition.
            @param error error code
            @return <code>true</code> to continue the operation, <code>false</code> to stop
            */
            virtual bool errorEvent(stuffit5::Error::type error) = 0;
        };
    }
}

#endif

#if !defined __cplusplus || defined stuffit5_implementation

#include "un/config.h"
#include "stuffit5/common.h"

typedef bool (*stuffit5_event_ErrorListener_errorEvent)(stuffit5_Error_type error, stuffit5_Reader reader);
//typedef bool (*stuffit5_event_ErrorListener_errorEvent)(stuffit5_Error_type error, stuffit5_Writer writer);

extern_c exported stuffit5_event_ErrorListener stuffit5_Reader_addErrorListener(stuffit5_event_ErrorListener_errorEvent errorEvent, stuffit5_Reader reader);
extern_c exported void stuffit5_Reader_removeErrorListener(stuffit5_event_ErrorListener errorListener, stuffit5_Reader reader);

extern_c exported stuffit5_event_ErrorListener stuffit5_Writer_addErrorListener(stuffit5_event_ErrorListener_errorEvent errorEvent, stuffit5_Writer writer);
extern_c exported void stuffit5_Writer_removeErrorListener(stuffit5_event_ErrorListener errorListener, stuffit5_Writer writer);

#endif

#endif

