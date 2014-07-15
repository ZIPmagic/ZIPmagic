// Copyright (c)1996-2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: QuietReader.h,v 1.2 2001/03/09 09:52:03 serge Exp $

#if !defined app_unstuff_QuietReader_h_included
#define app_stuff_QuietReader_h_included

#include <iostream>
#include "app/unstuff/Reader.h"

/** A reader that expands archives without event messages.

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/09 09:52:03 $
*/

namespace app {
    namespace unstuff {
        class QuietReader : public app::unstuff::Reader {
        public:
            typedef app::unstuff::Reader super;

            /** Default constructor. */
            QuietReader() : app::unstuff::Reader() {
            }

            /** Destructor. */
            ~QuietReader() {
            }

        protected:
            bool errorEvent(stuffit5::Error::type error) {
                std::cout << "Error: " << stuffit5::Error::description(error) << std::endl;
                return super::errorEvent(error);
            }

            bool fileDeleteEvent() {
                std::cout << "Warning: " << archiveInfo().name() << " is incomplete or damaged" << std::endl;
                return super::fileDeleteEvent();
            }
        };
    }
}

#endif // app_stuff_QuietReader_h_included

