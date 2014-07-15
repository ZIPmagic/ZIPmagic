// Copyright (c)1996-1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Header.h,v 1.11 2001/03/07 21:13:50 serge Exp $

#if !defined format_Header_h_included
#define format_Header_h_included

#include "un/structure.h"

/** ...

@author serge@aladdinsys.com
@version $Revision: 1.11 $, $Date: 2001/03/07 21:13:50 $
*/

namespace format {
    class Header : public un::structure {
    public:
        /** Constructor.
        @param e the endianness of the external representation of the structure
        */
        Header() :
            un::structure() {
        }

        /** Destructor. */
        virtual ~Header() {
        }
    };
}

#endif // format_Header_h_included

