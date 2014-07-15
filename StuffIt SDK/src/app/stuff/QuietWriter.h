// Copyright (c)1996-1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: QuietWriter.h,v 1.2 2001/03/09 09:52:03 serge Exp $

#if !defined app_stuff_QuietWriter_h_included
#define app_stuff_QuietWriter_h_included

#include <iostream>
#include "app/stuff/Writer.h"

/** A writer that creates archives without event messages.

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/09 09:52:03 $
*/

namespace app {
    namespace stuff {
        class QuietWriter : public app::stuff::Writer {
        public:
            typedef app::stuff::Writer super;

            /** Default constructor. */
            QuietWriter() : app::stuff::Writer() {
            }

            /** Destructor. */
            ~QuietWriter() {
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

#endif // app_stuff_QuietWriter_h_included

