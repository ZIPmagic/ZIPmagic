// Copyright (c)1996-1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: unstuff.main.cpp,v 1.12.2.2 2001/07/05 23:27:20 serge Exp $

//#include <stack>
#include "un/warnings.h"
#include "stuffit5/Version.h" // need avoid_sysmacros.h up here
#include <iostream>
#include <string>
#include "app/option/MacBinaryOutput.h"
#include "app/option/TextType.h"
#include "app/option/TextConversion.h"
#include "app/unstuff/BehavedReader.h"
#include "app/unstuff/ChattyReader.h"
#include "app/unstuff/QuietReader.h"
#include "un/auto_ptr.h"
#include "stuffit5/Format.h"
#include "stuffit5/exception/BadArgument.h"
#include "un/config.h"
#include "util/command/Command.h"
#include "util/command/CommandLine.h"
#if platform_win32
    #include <windows.h>
    #include "app/unstuff/ThreadedReader.h"
#endif

int main(int argc, char** argv) {
    try {
        util::command::CommandLine options(argc, argv);
        util::command::Command<bool> abortOnError(options, "--abort-on-error", false);
        util::command::Command<bool> classify(options, "--classify|-c", false);
        util::command::Command<size_t> classifierSpan(options, "--classifier-span", 65536);
        util::command::Command<uint32_t> classifierPosition(options, "--classifier-position", 0);
        util::command::Command<std::string> destination(options, "--destination|-d", "");
        app::option::TextType textTypeOption(options, "--eol|-e", "native");
        util::command::Command<bool> formats(options, "--formats", false);
        app::option::MacBinaryOutput macBinaryOutputOption(options, "--macbinary|--mb|-m", "off");
        util::command::Command<std::string> password(options, "--password|-p", "");
        util::command::Command<bool> pause(options, "--pause", false);
        util::command::Command<bool> quiet(options, "--quiet|-q", false);
        util::command::Command<bool> scan(options, "--scan|-s", false);
        app::option::TextConversion textConversionOption(options, "--text|-t", "off");
        util::command::Command<bool> threaded(options, "--threaded", false);
        util::command::Command<bool> trace(options, "--trace", false);
        util::command::Command<bool> version(options, "--version|-v", false);
        options.digest();

        if (version.value()) { // show the version
            std::cout << "StuffIt Engine " << stuffit5::Version::readable() << std::endl;
            return 0;
        }

        if (formats.value()) { // list the supported formats
            stuffit5::Reader reader;
            bool first = true;
            for (stuffit5::Format::type f = stuffit5::Format::first; f <= stuffit5::Format::last; f++) {
                if (reader.canClassify(f) && reader.canDecode(f)) {
                    if (!first)
                        std::cout << ", ";
                    std::cout << stuffit5::Format::name(f) << std::flush;
                    first = false;
                }
            }
            std::cout << std::endl;
            return 0;
        }

        if (options.args.empty()) { // no arguments
            std::cout << "unstuff " << stuffit5::Version::readable() << " - archive expander" << std::endl
                << "Usage: unstuff [-option[=value]] [--option[=value]] (archives...)" << std::endl
                << std::endl
                << "    -d=  --destination=path         destination directory for expanded files" << std::endl
                << "    -e=  --eol=[unix|win|mac]       text type for expanded files" << std::endl
                << "         --formats                  shows supported archive formats" << std::endl
                << "    -m=  --macbinary=[off|auto|on]  MacBinary output option for two-fork expanded files" << std::endl
                << "    -p=  --password=password        archive password" << std::endl
                << "    -q   --quiet                    suppresses messages" << std::endl
                << "    -t=  --text=[off|auto|on]       text conversion for expanded files" << std::endl
                << "    -v   --version                  shows version information" << std::endl
                << std::endl
                << "See unstuff.html for more information." << std::endl
                << std::endl;
            return 0;
        }

        if (threaded.value()) {
            #if platform_win32
                int threads = options.args.size();
                HANDLE* thread = new HANDLE[options.args.size()];

                // process the arguments
                int i = 0;
                while (i < threads) {
                    app::unstuff::ThreadedReader* reader = new app::unstuff::ThreadedReader();
                    reader->id(i);
                    reader->name(options.args[i]);
                    reader->encryptionPassword(password.value());
                    unsigned long threadID;
                    thread[i] = CreateThread(0, 0, app::unstuff::ThreadedReader::start, reader, CREATE_SUSPENDED, &threadID);
                    i++;
                }
                for (i = 0; i < threads; i++)
                    ResumeThread(thread[i]);

                bool running = true;
                while (running) {
                    running = false;
                    for (i = 0; i < threads; i++) {
                        unsigned long result;
                        GetExitCodeThread(thread[i], &result);
                        if (result != STILL_ACTIVE) {
                            int i = 0;
                        }
                        running |= (result == STILL_ACTIVE);
                    }
                }

                for (i = 0; i < threads; i++)
                    delete thread[i];
                delete[] thread;
            #else
                throw stuffit5::exception::BadArgument("threaded writing is supported only on Windows");
            #endif
        }
        else { // not threaded
            un::auto_ptr<app::unstuff::Reader> reader(0);

            if (quiet.value())
                reader.reset(new app::unstuff::QuietReader);
            else {
                if (trace.value())
                    reader.reset(new app::unstuff::ChattyReader);
                else
                    reader.reset(new app::unstuff::BehavedReader);
            }

            reader->abortOnError(abortOnError.value());
            reader->classifierSpan(classifierSpan.value());
            reader->textConversion(textConversionOption.interpret());
            reader->textType(textTypeOption.interpret());
            reader->macBinaryOutput(macBinaryOutputOption.interpret());
            reader->encryptionPassword(password.value());

            // process the arguments
            for (size_t i = 0; i < options.args.size(); i++) {
                try {
                    reader->open(options.args[i]);
                    if (classify.value()) {
                        stuffit5::Format::type format = stuffit5::Format::sit5; // something valid to begin with
                        while (format >= stuffit5::Format::first) {
                            if (!quiet.value())
                                std::cout << "classify(" << classifierPosition.value() << ", " << classifierSpan.value() << ")" << std::endl;

                            reader->archiveInfo().position(classifierPosition.value());
                            reader->classify();
                            format = reader->archiveInfo().format();
                            classifierPosition.value() = reader->archiveInfo().position() + 1;

                            if (!quiet.value())
                                std::cout << "classify(): " << stuffit5::Format::name(format) << " at " << reader->archiveInfo().position() << std::endl;
                        }
                    }
                    else if (scan.value()) {
                        if (!quiet.value())
                            std::cout << "scan()" << std::endl;

                        reader->scan();

                        if (!quiet.value()) {
                            std::cout << "scan(): " << reader->archiveInfo().items() << " items, ";
                            std::cout << (reader->archiveInfo().rootName().empty() ? "multiple roots" : reader->archiveInfo().rootName().c_str()) << ", ";
                            std::cout << reader->archiveInfo().compressedSize() << "->" << reader->archiveInfo().uncompressedSize() << " bytes" << std::endl;
                        }
                    }
                    else { // our regularly scheduled expand
                        reader->destinationFolder(destination.value());
                        stuffit5::Format::type format = stuffit5::Format::sit5; // something valid to begin with
                        while (format >= stuffit5::Format::first) {
                            reader->decode();
                            reader->classify();
                            format = reader->archiveInfo().format();
                        }
                    }
                    reader->close();
                }
                catch (un::exception& e) {
                    std::cout << e.type() << " exception: " << e.reason() << std::endl;
                }
            }
        }

        if (pause.value()) {
            std::cout << "Press Enter to continue..." << std::flush;
            char c;
            std::cin.getline(&c, 1);
        }

        return 0;
    }
    catch (un::exception& e) {
        std::cout << e.type() << " exception: " << e.reason() << std::endl;
        return 1;
    }
    catch (std::exception& e) {
        std::cout << "exception: " << e.what() << std::endl;
        return 2;
    }
    #if !defined DEBUG && !defined _DEBUG
    catch (...) {
        std::cout << "Unknown exception" << std::endl;
        return 3;
    }
    #endif
}

