// Copyright (c)1996-1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: stuff.main.cpp,v 1.15.2.2 2001/07/05 23:27:20 serge Exp $

#include "stuffit5/Version.h" // need avoid_sysmacros.h up here
#include <stdio.h>
#include <iostream>
#include <string>
#include "app/option/TextType.h"
#include "app/stuff/BehavedWriter.h"
#include "app/stuff/ChattyWriter.h"
#include "app/stuff/QuietWriter.h"
#include "stream/ArrayInput.h"
#include "stream/HexInput.h"
#include "stuffit5/CompressionLevel.h"
#include "stuffit5/Format.h"
#include "stuffit5/exception/BadArgument.h"
#include "util/command/Command.h"
#include "util/command/CommandLine.h"
#include "un/auto_ptr.h"
#include "un/config.h"
#if platform_win32
    #include <windows.h>
    #include "app/stuff/ThreadedWriter.h"
#endif

int main(int argc, char** argv) {
    try {
        util::command::CommandLine options(argc, argv);
        util::command::Command<bool> abortOnError(options, "--abort-on-error", false);
        util::command::Command<std::string> comment(options, "--comment", "");
        app::option::TextType textTypeOption(options, "--eol|-e", "native");
        util::command::Command<std::string> format(options, "--format|-f", "sit5");
        util::command::Command<bool> formats(options, "--formats", false);
        util::command::Command<size_t> keySize(options, "--key-size", 5); // 5 bytes, 40 bits
        util::command::Command<stuffit5::CompressionLevel::type> compressionLevel(options, "--level|-l", stuffit5::CompressionLevel::automatic);
        util::command::Command<std::string> macCreator(options, "--mac-creator", "");
        util::command::Command<std::string> macType(options, "--mac-type", "");
        util::command::Command<std::string> name(options, "--name|-n", "");
        util::command::Command<std::string> password(options, "--password|-p", "");
        util::command::Command<bool> pause(options, "--pause", false);
        util::command::Command<bool> quiet(options, "--quiet|-q", false);
        util::command::Command<std::string> salt(options, "--salt", "");
        util::command::Command<uint32_t> segmentSize(options, "--size", 65536);
        util::command::Command<bool> threaded(options, "--threaded", false);
        util::command::Command<bool> traced(options, "--trace", false);
        util::command::Command<bool> version(options, "--version|-v", false);
        options.digest();

        if (version.value()) { // show the version
            std::cout << "StuffIt Engine " << stuffit5::Version::readable() << std::endl;
            return 0;
        }

        if (formats.value()) { // list the supported formats
            stuffit5::Writer writer;
            bool first = true;
            for (stuffit5::Format::type f = stuffit5::Format::first + 1; f <= stuffit5::Format::last; f++) {
                if (writer.canCreate(f)) {
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
            std::cout << "stuff " << stuffit5::Version::readable() << " - archive creator" << std::endl
                << "Usage: stuff [-option[=value]] [--option[=value]] (files/directories...)" << std::endl
                << std::endl
                << "         --comment=[comment]        archive comment" << std::endl
                << "    -e=  --eol=[unix|win|mac]       text type for expanded files" << std::endl
                << "    -f=  --format=formatname        archive format to create, for example: sit5, zip" << std::endl
                << "         --formats                  shows supported archive formats" << std::endl
                << "         --level=[n]                compression level" << std::endl
                << "    -n=  --name=filename            name of the archive to be created" << std::endl
                << "    -p=  --password=password        archive password" << std::endl
                << "    -q   --quiet                    suppresses messages" << std::endl
                << "         --size=[n]                 segment size" << std::endl
                << "    -v   --version                  shows version information" << std::endl
                << std::endl
                << "See stuff.html for more information." << std::endl
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
                    app::stuff::ThreadedWriter* writer = new app::stuff::ThreadedWriter;
                    writer->id(i);
                    writer->name(options.args[i]);
                    writer->formatName(format.value());
                    writer->encryptionPassword(password.value());
                    unsigned long threadID;
                    thread[i] = CreateThread(0, 0, app::stuff::ThreadedWriter::start, writer, CREATE_SUSPENDED, &threadID);
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
            un::auto_ptr<app::stuff::Writer> writer(0);

            if (quiet.value())
                writer.reset(new app::stuff::QuietWriter);
            else {
                if (traced.value())
                    writer.reset(new app::stuff::ChattyWriter);
                else
                    writer.reset(new app::stuff::BehavedWriter);
            }

            writer->abortOnError(abortOnError.value());
            writer->macType(macType.value());
            writer->macCreator(macCreator.value());
            writer->textType(textTypeOption.interpret());

            if (!name.value().empty())
                writer->archiveInfo().name(name.value());

            if (!password.value().empty())
                writer->encryptionPassword(password.value());
            writer->encryptionKeySize(keySize.value());
            if (!salt.value().empty()) {
                stream::ArrayInput arrayin(salt.value().c_str(), salt.value().size());
                stream::HexInput hexin(arrayin);
                std::vector<char> s;
                char c = '\0';
                do {
                    c = hexin.read();
                    if (c != stream::eof)
                        s.push_back(c);
                } while (c != stream::eof);

                writer->encryptionKey().salt(s);
            }
            if (!comment.value().empty())
                writer->archiveComment(comment.value());
            writer->archiveSize(segmentSize.value());
            writer->compressionLevel(compressionLevel.value());

            // handle the name of the format to be created
            stuffit5::Format::type f = stuffit5::Format::sit5;
            for (stuffit5::Format::type g = stuffit5::Format::first; g <= stuffit5::Format::last; g++) {
                if (format.value() == stuffit5::Format::name(g)) {
                    if (!writer->canCreate(g))
                        f = stuffit5::Format::unknown;
                    else
                        f = g;
                }
            }
            if (f == stuffit5::Format::unknown)
                throw stuffit5::exception::BadArgument("unknown or unsupported format");
            writer->archiveInfo().format(f);

            // create a file list required by the engine
            std::list<std::string> names;
            size_t i = 0;
            while (i < options.args.size())
                names.push_back(options.args[i++]);

            writer->create(names);
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

