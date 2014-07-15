// $Id: structure.h,v 1.1 2001/03/06 10:11:43 serge Exp $
//
// Copyright (c)1996-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_structure_h_included
#define un_structure_h_included

#include "un/stdint.h"
namespace stream { class Input; }
namespace stream { class Output; }

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2001/03/06 10:11:43 $
*/

namespace un {
    class structure {
    public:
        /** Default constructor. */
        structure() {
        }

        /** Destructor. */
        virtual ~structure() {
        }

        /** Determines if the structure is valid.
        @return <code>true</code> when the structure is valid
        */
        virtual bool valid() const = 0;

        /** Reads the structure from an input stream.
        @param in an input stream
        @param verify verify data if <code>true</code>
        */
        virtual void read(stream::Input& in, bool verify = true) = 0;

        /** Writes the structure to an output stream.
        @param out an output stream
        */
        virtual void write(stream::Output& out) const = 0;

        /** Returns the size of the structure.
        @return the size of the structure
        */
        virtual size_t size() const = 0;
    };
}

#endif

