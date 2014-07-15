// $Id: Version.h,v 1.17.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1996-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_Version_h_included
#define stuffit5_Version_h_included

#include "un/config.h"

#if defined __cplusplus

/** StuffIt Engine version information.

<p>StuffIt Engine versions consist of: a major version number, a minor version
number, a patch level, and a build number.

<p>In addition to version numbers, each StuffIt Engine build also contains its
build date and time that is unique for each build and is assigned at the time
the version or build number is changed.

@author serge@aladdinsys.com
@version $Revision: 1.17.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    namespace Version {
        /** Major version number of the engine. Incremented when major interface and
        internal changes are made. */
        exported int majorv();

        /** Minor version number of the engine. Incremented when significant interface
        changes and additions are made. */
        exported int minorv();

        /** Patch level of the engine. Incremented when any interface changes are made. */
        exported int patchlevel();

        /** Build number of the engine. Incremented with each build of the engine. */
        exported int build();

        /** Debug level of the engine. Increases with the amount of debugging suport included.
        Debug level 0 is used for release builds that do not contain debugging information. */
        exported int debug();

        /** Build year. */
        exported int year();

        /** Build month. */
        exported int month();

        /** Build day. */
        exported int day();

        /** Build hour (24-hour "military" format). */
        exported int hour();

        /** Build minute. */
        exported int minute();

        /** Human-readable string representation of StuffIt Engine version number and
        build date and time. */
        exported const char* readable();
    }
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

/** C equivalent of <code>stuffit5::Version::majorv</code>. */
extern_c exported int stuffit5_Version_majorv();
/** C equivalent of <code>stuffit5::Version::minorv</code>. */
extern_c exported int stuffit5_Version_minorv();
/** C equivalent of <code>stuffit5::Version::patchlevel</code>. */
extern_c exported int stuffit5_Version_patchlevel();
/** C equivalent of <code>stuffit5::Version::build</code>. */
extern_c exported int stuffit5_Version_build();
/** C equivalent of <code>stuffit5::Version::lf</code>. */
extern_c exported int stuffit5_Version_debug();
/** C equivalent of <code>stuffit5::Version::year</code>. */
extern_c exported int stuffit5_Version_year();
/** C equivalent of <code>stuffit5::Version::month</code>. */
extern_c exported int stuffit5_Version_month();
/** C equivalent of <code>stuffit5::Version::day</code>. */
extern_c exported int stuffit5_Version_day();
/** C equivalent of <code>stuffit5::Version::hour</code>. */
extern_c exported int stuffit5_Version_hour();
/** C equivalent of <code>stuffit5::Version::minute</code>. */
extern_c exported int stuffit5_Version_minute();
/** C equivalent of <code>stuffit5::Version::readable</code>. */
extern_c exported const char* stuffit5_Version_readable();

#endif // __cplusplus

#endif

