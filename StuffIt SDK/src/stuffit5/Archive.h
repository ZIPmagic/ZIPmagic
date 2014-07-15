// Copyright (c)2001 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: Archive.h,v 1.1.2.1 2001/06/04 23:19:49 serge Exp $

#if !defined stuffit5_Archive_h_included
#define stuffit5_Archive_h_included

#include "stuffit5/common.h"
#include "un/config.h"
namespace io { namespace random { class File; } }

#if compiler_msvc
    #pragma pack(push, 8)
#endif

#if defined __cplusplus

#include "un/warnings.h"
#include <string>

/** StuffIt Engine archive.

@author serge@aladdinsys.com
@version $Revision: 1.1.2.1 $, $Date: 2001/06/04 23:19:49 $
*/

namespace stuffit5 {
    class Archive {
    public:
        /** Default constructor. */
        exported Archive();

        /** Destructor. */
        exported ~Archive();

        /** Opens an existing archive.
        @param name archive name
        @exception stuffit5::exception::Input if the archive cannot be opened
        */
        exported void open(const std::string& name);

        /** Closes the archive.
        @exception stuffit5::exception::Input if the archive cannot be closed
        */
        exported void close();

        /** Returns the value of the return-receipt flag (sit5 format only).
        @return the flag value
        */
        exported bool returnReceipt() const;

        /** Assigns the value of the return-receipt flag (sit5 format only).
        @param value the new flag value
        */
        exported void returnReceipt(bool value);

    private:
        io::random::File* file;
    };
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

#include "stuffit5/bool.h"

/** Creates a new archive object.
@return an archive reference or <code>0</code>
*/
extern_c exported stuffit5_Archive stuffit5_Archive_new();

/** Deletes an archive object.
@param archive archive reference
*/
extern_c exported void stuffit5_Archive_delete(stuffit5_Archive archive);

/** Opens an archive.
@param name archive name
@param archive archive reference
@return <code>true</code> if the archive has been opened
*/
extern_c exported bool stuffit5_Archive_open(const char* name, stuffit5_Archive archive);

/** Closes an archive.
@param archive archive reference
@return <code>true</code> if the archive has been closed
*/
extern_c exported bool stuffit5_Archive_close(stuffit5_Archive archive);

/** Returns the value of the return-receipt flag (sit5 format only).
@param archive archive reference
@return the flag value
*/
extern_c exported bool stuffit5_Archive_getReturnReceipt(stuffit5_Archive archive);

/** Assigns the value of the return-receipt flag (sit5 format only).
@param archive archive reference
@param value the new flag value
*/
extern_c exported void stuffit5_Archive_setReturnReceipt(bool value, stuffit5_Archive archive);

#endif // __cplusplus

#if compiler_msvc
    #pragma pack(pop)
#endif

#endif // stuffit5_Archive_h_included

