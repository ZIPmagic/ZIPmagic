// Copyright (c)1998 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Command.h,v 1.11.2.1 2001/07/05 23:35:34 serge Exp $

#if !defined util_command_Command_h_included
#define util_command_Command_h_included

#include "un/warnings.h"
#include <iostream>
#include <list>
#include <set>
#include <string>
#include "un/property.h"
#include "un/config.h"
#include "util/tokenizer.h"
#include "util/command/CommandElement.h"
#include "util/command/CommandException.h"
#include "util/command/CommandLine.h"
#if compiler_gcc
    #include <strstream> // nonstandard
#else
    #include <sstream>
#endif

/** A class representing a command-line option. Contains the <code>value</code>
member that stores the value of the option.

@author serge@aladdinsys.com
@version $Revision: 1.11.2.1 $, $Date: 2001/07/05 23:35:34 $
*/

namespace util {
    namespace command {
        template<typename T> class Command : public util::command::CommandElement {
        public:
            /** A constructor for an 'optional' option. Needs the initial value.
            @param names the (possibly multiple) names of the option, separated by <code>'|'</code>
            @param value the initial value of the option; the default value if the option is unused
            */
            Command(util::command::CommandLine& options, const std::string& names, const T& value);

            /** A constructor for a required option. Does not have the initial value.
            @param names the (possibly multiple) names of the option, separated by <code>'|'</code>
            */
            Command(util::command::CommandLine& options, const std::string& names);

            /** Destructor. */
            ~Command();

            /** Parse the value of the option from one of the command line arguments.
            @param names the names of the options (from a constructor argument)
            */
            #if compiler_gcc
                void setSynonyms(const std::string& names);
            #else
                void setSynonyms(const std::string& names) {
                    un::tokenizer st(names, "|");
                    std::vector<std::string>::const_iterator i = st.begin();
                    while (i != st.end()) {
                        util::command::CommandElement* coe = new util::command::CommandSynonym<T>(*this, *i);
                        synonyms.push_back(coe);
                        options.add(coe);
                        i++;
                    }
                }
            #endif

            /** Parse the value of the option from one of the command line arguments.
            @param arg the command line argument to parse (digest)
            */
            void digest(const std::string& arg) {
                #if compiler_gcc
                    std::istrstream iss(arg.c_str()); // nonstandard
                #else
                    std::istringstream iss(arg);
                #endif
                T t;
                iss >> t;
                value(t);
                #if compiler_msvc
                    if (iss.fail())
                        throw util::command::CommandException("failed to read command line parameter \"" + arg + "\"");
                #endif
                found(true);
            }

            /** Print the value of the option to a stream.
            @param os an output stream
            */
            void print(std::ostream& os) {
                printName(os);
                printValue(os);
                os << std::endl;
            }

            /** A bidirectional list of the synonyms for the option. */
            std::list<util::command::CommandElement*> synonyms;

            /** The value of the option. */
            un::property<T> value;

        protected:
            void printName(std::ostream& os) {
                os << name() << " (" << (required() ? "required" : "not required") << ", " << (found() ? "found" : "not found") << "): ";
            }

            void printValue(std::ostream& os) {
                os << value();
            }

            util::command::CommandLine& options;
       };
    }
}

#include "util/command/CommandSynonym.h"

template<typename T> util::command::Command<T>::Command(CommandLine& options, const std::string& names, const T& value) :
    util::command::CommandElement(names, false),
    value(value),
    options(options) {
    options.add(this);
    setSynonyms(names);
}

template<typename T> util::command::Command<T>::Command(util::command::CommandLine& options, const std::string& names) :
    util::command::CommandElement(names, true),
    options(options) {
    // okay to leave the value uninitialized because the option is required
    options.add(this);
    setSynonyms(names);
}

template<typename T> util::command::Command<T>::~Command() {
    while (!synonyms.empty()) {
        delete synonyms.front();
        synonyms.pop_front();
    }
}

#if compiler_gcc
    template<typename T> void util::command::Command<T>::setSynonyms(const std::string& names) {
        un::tokenizer st(names, "|");
        std::vector<std::string>::const_iterator i = st.begin();
        while (i != st.end()) {
            util::command::CommandElement* coe = new util::command::CommandSynonym<T>(*this, *i);
            synonyms.push_back(coe);
            options.add(coe);
            i++;
        }
    }
#endif

template<> inline void util::command::Command<bool>::digest(const std::string& /*arg*/) {
    value() = !value(); // toggle the flag
    found(true);
}

template<> inline void util::command::Command<std::string>::digest(const std::string& arg) {
    value(arg);
    found(true);
}

template<> inline void util::command::Command<bool>::printValue(std::ostream& os)  {
    os << (value() ? "true" : "false");
}

template<> inline void util::command::Command<std::string>::printValue(std::ostream& os) {
    os << "\"" << value() << "\"";
}

#endif // util_command_Command_h_included

