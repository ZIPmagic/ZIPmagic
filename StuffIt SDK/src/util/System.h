// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: System.h,v 1.1 1999/05/03 21:15:24 serge Exp $

#if !defined util_System_h_included
#define util_System_h_included

/** Implements miscellaneous system (OS-specific) operations.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 1999/05/03 21:15:24 $ */

namespace util {
    class System {
    public:
        /** Yields control in a cooperative multitasking environment. */
        static void yield();

    private:
        /** Unimplemented default constructor. */
        System();
    };
}

#endif // util_System_h_included

