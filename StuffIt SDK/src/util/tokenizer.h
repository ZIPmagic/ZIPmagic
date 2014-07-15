// $Id: tokenizer.h,v 1.1.4.1 2001/07/05 23:35:27 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_tokenizer_h_included
#define un_tokenizer_h_included

#include "un/warnings.h"
#include <string>
#include <vector>

/** This class parses the given string into tokens separated by the
specified delimiter character or characters.

<p>This class is derived from the STL <code>vector<code> container.
Regular STL iterators may (and should) be used to access the tokens.

@author serge@aladdinsys.com
@version $Revision: 1.1.4.1 $, $Date: 2001/07/05 23:35:27 $
*/

namespace un {
    class tokenizer : public std::vector<std::string> {
    public:
        /** Constructor. Single delimiter character case.
        @param s the string to tokenize
        @param delimiter the delimiter character
        */
        tokenizer(const std::string& str, char delimiter);

        /** Constructor. Multiple delimiters.
        @param s the string to tokenize
        @param delimiters one or more delimiter characters
        */
        tokenizer(const std::string& str, const char* delimiters = " \t\n");

        /** Destructor. */
        ~tokenizer() {
        }

        /** Initializes the internal vector of strings. Called by the constructors.
        @param s the string to tokenize
        @param delimiters one or more delimiter characters
        */
        void init(const std::string& str, const char* delimiters = " \t\n");
    };
}

#endif

