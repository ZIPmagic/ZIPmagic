// Copyright (c)2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: CommandLineTest.h,v 1.2 2001/03/06 01:37:26 serge Exp $

#if !defined util_command_CommandLineTest_h_included
#define util_command_CommandLineTest_h_included

#include <string>
#include "un/stdint.h"

/** A command line test. This class is used to test the <code>util::CommandLine</code>
class with different values..

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/06 01:37:26 $
*/

namespace util {
    namespace command {
        class CommandLineTest {
        public:
            /** Constructs an instance of <code>CommandLineTest</code>.
            @param options command line
            @param expectedBool expected bool value
            @param expectedInt expected int value
            @param expectedString expected string value
            */
            CommandLineTest(const std::string& commandLine, const bool expectedBool, const int expectedInt, const std::string& expectedString);

            /** Destructor. */
            virtual ~CommandLineTest();

            /** Runs the test. */
            virtual void test();

        protected:
            const std::string commandLine;
            const bool expectedBool;
            const int expectedInt;
            const std::string expectedString;
        };
    }
}

#endif // util_command_CommandLineTest_h_included

