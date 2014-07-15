// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: util.System.w32.cpp,v 1.1 2001/03/06 08:40:41 serge Exp $

#include "util/System.h"
#include <windows.h>

void util::System::yield() {
    MSG m;
    while (::PeekMessage(&m, 0, 0, 0, PM_REMOVE)) {
        ::TranslateMessage(&m);
        ::DispatchMessage(&m);
    }
}

