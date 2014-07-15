// $Id: Reader.h,v 1.12.2.1 2001/07/05 23:32:33 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined stuffit5_Reader_h_included
#define stuffit5_Reader_h_included

#include "stuffit5/bool.h"
#include "stuffit5/common.h"
#include "un/config.h"
#include "un/stdint.h"

#if compiler_msvc
    #pragma pack(push, 8)
#endif

#if defined __cplusplus

#include "un/warnings.h"
#include <string>
#include "algorithm/Password.h"
#include "algorithm/Key.h"
#include "stuffit5/ArchiveInfo.h"
#include "stuffit5/common.h"
#include "stuffit5/Error.h"
#include "stuffit5/FileInfo.h"
#include "stuffit5/FolderInfo.h"
#include "stuffit5/Format.h"
#include "stuffit5/MacBinaryOutput.h"
#include "stuffit5/TextConversion.h"
#include "stuffit5/TextType.h"
#include "stuffit5/event/ReaderEventDispatcher.h"
#include "un/opt_property.h"
#include "un/property.h"
namespace engine5 { class FormatReader; }
namespace io { namespace random { class File; } }
namespace io { namespace random { class FileInput; } }

/** StuffIt Engine reader.

<p>StuffIt Engine reader is a class used to read (classify, scan, decode) archives
and encoded files.

@author serge@aladdinsys.com
@version $Revision: 1.12.2.1 $, $Date: 2001/07/05 23:32:33 $
*/

namespace stuffit5 {
    class Reader : public stuffit5::event::ReaderEventDispatcher {
    public:
        /** Default constructor. */
        exported Reader();

        /** Destructor. */
        exported virtual ~Reader();

        /** Opens an archive in the reader. <code>name</code> is an
        absolute or relative path name of the archive file.

        @param reader a reader reference
        @exception stuffit5::Exception if the archive cannot be opened
        */
        exported virtual void open(const std::string& name);

        /** Determines archive format (<i>classifies</i> the archive). The
        archive must be open with <code>open()</code> first.

        <p>Classification does not rely (or, in fact, use in any way) file name
        extension, file type or creator information. Instead, it relies on patterns
        within compressed and encoded files that are specific to each format, such as
        header structures and checksums in compressed archives, or limited character
        sets in encoded files.

        <p>By default, classification begins at the current archive position which can
        be obtained by calling <code>archiveInfo().position()</code>, or controlled by
        calling <code>archiveInfo().position(uint32_t)</code>. After an archive is open,
        its initial position is 0.

        <p>Archive format information is implicitly used by <code>scan()</code> and
        <code>decode()</code>. To obtain archive format information for other purposes,
        use <code>archiveInfo().format()</code> after <code>classify()</code>.

        <p>Classification uses only a finite area of the archive immediately following
        its current position to determine the format. The size of this classification
        area can be obtained by calling <code>classifierSpan()</code>, or controlled
        by calling <code>classifierSpan(size_t)</code>. The default size is chosen to exceed
        the size of the majority of self-extracting code segments commonly used in
        archive formats such as Zip, and may change between engine versions; if this
        size is important, it should be set explicitly. If you want to find any
        supported archive format, no matter how far into the archive, you can use
        <code>classifierSpan(size_t)</code> to set the size of the classification area to
        the size of the remaining portion of the file.

        @param reader a reader reference
        @exception stuffit5::Exception if the archive cannot be classified
        */
        exported virtual void classify();

        /** Scans the archive.

        <p>The archive must be open with <code>open()</code>, but does
        not have to be classified with <code>classify()</code>. If the archive
        has not been classified, <code>classify()</code> will be called
        internally.

        <p>Scan determines if the structure of the archive file is consistent
        with its format, i.e, if it is complete and its overall structure is not
        damaged. It also obtains summary information, such as the total number
        of items in the archive (retrieved with a call to
        <code>items()</code>), the number of items at the root level of the
        archive, the name of the sigular
        item at the root level (retrieved with <code>rootName()</code> but is
        not available unless <code>hasMultupleRoots()</code> returns
        <code>false</code>), and the total compressed and uncompressed size of
        all items in the archive (retrieved with
        <code>compressedSize()</code> and
        <code>uncompressedSize()</code>, respectively.

        <p>In some formats, such as Uuencode, determining sizes requires reading
        the entire archive, so this operation may take noticeable time on large
        archives.

        <p>Throws an exception if the archive structure cannot be read or is invalid.

        @exception stuffit5::Exception if the archive cannot be scanned
        */
        exported virtual void scan();

        /** Decodes the archive and recreates all files contained in it at the
        destination location. The archive must be open with <code>open()</code>,
        but does not have to be classified with <code>classify()</code> or
        scanned with <code>scan()</code>. If the archive has not been classified
        or scanned, these operations will be executed internally before
        decoding. Therefore, decoding may be requested immediately after a
        successful <code>open()</code> if you do not need to know what archive
        format you are dealing with, or any information about the archive that
        is determined during the scan phase; this call effectively combines
        classification, scan, and decoding, or scan and decoding, or simply
        executes decoding when both classification and scan have been previously
        completed.

        <p>This call advances the archive position to the first byte past the
        end of the decoded portion, except when this call returns
        <code>false</code> due to an error, when the position may be advanced or
        remain the same. This allows you to immediately proceed with a call to
        <code>classify()</code> or <code>scan()</code> or <code>decode()</code>
        to process any other archives that may follow the one that has just been
        decoded, within the same physical file. This is a common situation with
        concatenated encoded files, such as multipart uuencoded files combined
        together in a single file, or within a mailbox file. This also allows
        you to process disk image, backup and similar files of unknown structure
        that combine multiple archives, but do not provide tools for easy
        extraction of individual pieces.

        <p>Throws an exception if the archive cannot be decoded.

        @exception stuffit5::Exception if the archive cannot be decoded
        */
        exported virtual void decode();

        /** Closes the currently open archive.
        @exception stuffit5::Exception if the archive cannot be closed
        */
        exported virtual void close();

        /** Returns <code>true</code> when the reader is capable of classifying
        the format described by the <code>format</code> parameter.
        @param format the format
        */
        exported virtual bool canClassify(stuffit5::Format::type format) const;

        /** Returns <code>true</code> when the reader is capable of decoding
        the format described by the <code>format</code> parameter.
        @param format the format
        */
        exported virtual bool canDecode(stuffit5::Format::type format) const;

        /** MacDrive volume support option. The accessor returns <code>true</code> if the MacDrive volume support option is enabled.
        MacDrive volume support allows readers to expand files into Macintosh HFS and
        HFS+ volumes, preserving all Macintosh file information and resource fork
        contents. This option is disabled by default.

        <p>The mutator assigns the MacDrive volume support option that
        applies to all subsequent archives, or until it is reassigned.
        */
        un::property<bool> useMacDrive;

        /** <code>true</code> when the reader supports text types. Depends on the
        format being processed.
        */
        un::property<bool> hasTextType;

        /** Text type generated by the reader. */
        un::opt_property<stuffit5::TextType::type> textType;

        /** <code>true</code> when reader supports text conversion. Depends on the
        format being processed.
        */
        un::property<bool>hasTextConversion;

        /** Text conversion option. */
        un::opt_property<stuffit5::TextConversion::type> textConversion;

        /** MacBinary output option. */
        un::property<stuffit5::MacBinaryOutput::type> macBinaryOutput;

        /** The destination folder: a location where the reader creates output
        files that it extracts from the archive. The default destination folder is
        the folder where the archive is located.
        */
        un::property<std::string> destinationFolder;

        /** Classifier span. Determines how far the reader looks into the archive
        when trying to classify it. Unless a different span was set with
        <code>classifierSpan(size_t)</code> this function returns the default
        value of the classifier span.

        <p>When doing archive classification, each reader starts at the current
        archive position and uses the number of bytes equal to the value of the
        classifier span property. This helps to achieve the right balance of
        classification time and reliability.

        <p>For example, some self-extracting archives may contain code segments
        that are larger than the default classifier span. Unless the span value
        is increased and is larger than the size of the segment of code, the
        reader is not able to classify such files correctly. The span value can
        be as large as the whole input file. While this helps to classify
        archives that begin very far into the file, large spans lead to longer
        delays and increase the probability of incorrect classification due to a
        false match with one of the byte patterns inside the file.

        <p>In identification of self-extracting archives is not an issue, classifier
        span may be kept in the 1 KB to 8 KB range to allow for data between
        concatenated archives or encoded files (such as email or news article
        headers). When self-extracting archives need to be classified as well
        good values for classifier span are between 32 KB and 128 KB, depending
        on the maximum size of the self-extracting code likely to be encountered.

        <p>To minimize the probability of incorrect identification, classifier
        span must be kept as low as is acceptable. However, it should not be set
        to values significantly lower then about 512 bytes, because low values
        exclude the possibility of identification of one or more formats.
        */
        un::property<size_t> classifierSpan;

        /** The password used for file decryption in formats that support encrypted archives
        (PrivateFile and StuffIt5). The maximum password length is 64 KB, 65536 characters.
        The password is text usually entered by the user.  This function copies the password
        for use in the writer. All writers that support encryption take care of transforming
        the variable-size password to the (normally) fixed-size key.

        <p>Every reader that has a password and a key erases them in the destructor.
        However, for additional security, the password and the key can be erased
        as soon as the archive is completely created (at the time of the
        <code>ArchiveDecodeEnd</code> event callback).
        */
        un::property<algorithm::Password> encryptionPassword;

        un::property<size_t> encryptionKeySize;

        /** The key used for file decryption in formats that support encrypted archives
        (PrivateFile and StuffIt5). The key can be set independently of the password
        and overrides the key that has been or would have been generated internally
        from the password. Every reader that has a key erases it in the destructor.
        However, for additional security, the key can be erased as soon as the archive
        is completely created (at the time of the <code>ArchiveDecodeEnd</code>
        event callback).
        */
        un::property<algorithm::Key> encryptionKey;

        /** The name of an unnamed file. The accessor returns the name of the
        output file created by the reader when the file stored in the archive
        has no name associated with it. This situation is handled through the
        <code>FileNewName</code> event callback that preceeds the
        <code>FileDecodeBegin</code> event callback. The accessor returns the
        proposed generic file name (not a path name). The mutator assigns the
        name of an unnamed file (not a path name).
        */
        un::property<std::string> newFileName;

        /** Archive information class. */
        un::property<stuffit5::ArchiveInfo> archiveInfo;

        /** File information class. */
        un::property<stuffit5::FileInfo> fileInfo;

        /** Folder information class. */
        un::property<stuffit5::FolderInfo> folderInfo;

        /** An arbitrary data pointer is carried to link instances of this class to
        external per-instance data. */
        un::property<void*> userData;

        un::property<stuffit5::Error::type> errorCode;

        un::property<uint32_t> endPosition;

    protected:
        static const uint32_t defaultPosition;
        static const size_t defaultSpan;

        engine5::FormatReader* formatReader;

        io::random::File* file;
        io::random::FileInput* input;

        /** True if an archive is open. */
        bool isOpen;

        /** True if archive format is known. */
        bool hasFormat;

        /** True if archive scan is complete. */
        bool scanned;
    };
}

#endif // __cplusplus

#if !defined __cplusplus || defined stuffit5_implementation

/** Creates a new reader. Returns a reader pointer. Every reader must be deleted
with a call to <code>stuffit5_Reader_delete()</code>.
@return reader pointer or <code>0</code>
*/
extern_c exported stuffit5_Reader stuffit5_Reader_new();

/** Deletes a reader.
@param reader reader pointer
*/
extern_c exported void stuffit5_Reader_delete(stuffit5_Reader reader);

/** Opens an archive. Returns <code>false</code> if the archive could not be opened.
Use <code>stuffit5_Reader_getError()</code> to obtain error information.
@param reader reader pointer
@return true if the archive has been successfully opened
@see stuffit5::Reader::open
*/
extern_c exported bool stuffit5_Reader_open(const char* name, stuffit5_Reader reader);

/** Determines archive format (<i>classifies</i> the archive). Returns <code>false</code>
if archive format was not recognized. Use <code>stuffit5_Reader_getError()</code> to obtain error
information.
@param reader reader pointer
@return true if the archive has been successfully classified
*/
extern_c exported bool stuffit5_Reader_classify(stuffit5_Reader);

/** Scans the archive. Returns <code>false</code> if the archive structure cannot
be read or is invalid. Use <code>stuffit5_Reader_getError()</code> to obtain error information.
@param reader reader pointer
@return true if the archive has been successfully scanned
*/
extern_c exported bool stuffit5_Reader_scan(stuffit5_Reader reader);

/** Decodes the archive. Returns <code>false</code> if there was an error. Use
<code>stuffit5_Reader_getError()</code> to obtain error information.
@param reader reader pointer
@return true if the archive has been successfully decoded
*/
extern_c exported bool stuffit5_Reader_decode(stuffit5_Reader reader);

/** Closes the currently open archive. <p>Returns <code>false</code> if the archive
could not be closed. Use <code>stuffit5_Reader_getError()</code> to obtain error information.
@param reader reader pointer
@return true if the archive has been successfully closed
*/
extern_c exported bool stuffit5_Reader_close(stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::canClassify()</code>. */
extern_c exported bool stuffit5_Reader_canClassify(stuffit5_Format_type format, stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::canDecode()</code>. */
extern_c exported bool stuffit5_Reader_canDecode(stuffit5_Format_type format, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::useMacDrive()</code>. */
extern_c bool stuffit5_Reader_getUseMacDrive(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::useMacDrive()</code>. */
extern_c void stuffit5_Reader_setUseMacDrive(bool b, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::textConversion()</code>. */
extern_c exported bool stuffit5_Reader_hasTextConversion(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::textConversion()</code>. */
extern_c exported stuffit5_TextConversion_type stuffit5_Reader_getTextConversion(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::textConversion()</code>. */
extern_c exported void stuffit5_Reader_setTextConversion(stuffit5_TextConversion_type tc, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::textType()</code>. */
extern_c exported bool stuffit5_Reader_hasTextType(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::textType()</code>. */
extern_c exported stuffit5_TextType_type stuffit5_Reader_getTextType(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::textType()</code>. */
extern_c exported void stuffit5_Reader_setTextType(stuffit5_TextType_type tt, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::macBinaryOutput()</code>. */
extern_c exported stuffit5_MacBinaryOutput_type stuffit5_Reader_getMacBinaryOutput(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::macBinaryOutput()</code>. */
extern_c exported void stuffit5_Reader_setMacBinaryOutput(stuffit5_MacBinaryOutput_type macBinaryOutput, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::destinationFolder()</code>. */
extern_c exported const char* stuffit5_Reader_getDestinationFolder(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::destinationFolder()</code>. */
extern_c exported void stuffit5_Reader_setDestinationFolder(const char* name, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::classifierSpan()</code>. */
extern_c exported size_t stuffit5_Reader_getClassifierSpan(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::classifierSpan()</code>. */
extern_c exported void stuffit5_Reader_setClassifierSpan(size_t size, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::password()</code>. */
extern_c exported bool stuffit5_Reader_setPassword(const char* password, stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::key()</code>. */
extern_c exported bool stuffit5_Reader_setKey(const char* key, size_t keySize, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::newFileName()</code>. */
extern_c exported const char* stuffit5_Reader_getNewFileName(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::newFileName()</code>. */
extern_c exported void stuffit5_Reader_setNewFileName(const char* fileName, stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::userData()</code>. */
extern_c exported void* stuffit5_Reader_getUserData(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::userData()</code>. */
extern_c exported void stuffit5_Reader_setUserData(void* userData, stuffit5_Reader reader);

/** Returns the last error code set by the reader. Use this function to get error
values of type <code>stuffit5::Error::type</code>:

<ul><li>when <code>stuffit5_Reader_open()</code>, <code>stuffit5_Reader_classify()</code>,
<code>stuffit5_Reader_scan()</code>, <code>stuffit5_Reader_decode()</code> or
<code>cloaseArchive()</code> function returns <code>false</code>, indicating an
error condition, and

<li>during the <code>Error</code> event callback to obtain the non-fatal error
code.</ul>

@param reader reader pointer
@return the error code
*/
extern_c exported stuffit5_Error_type stuffit5_Reader_getError(stuffit5_Reader reader);

/** C interface to <code>stuffit5::Reader::archiveInfo()</code>. */
extern_c exported stuffit5_ArchiveInfo stuffit5_Reader_archiveInfo(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::fileInfo()</code>. */
extern_c exported stuffit5_FileInfo stuffit5_Reader_fileInfo(stuffit5_Reader reader);
/** C interface to <code>stuffit5::Reader::folderInfo()</code>. */
extern_c exported stuffit5_FolderInfo stuffit5_Reader_folderInfo(stuffit5_Reader reader);

#endif // __cplusplus

#if compiler_msvc
    #pragma pack(pop)
#endif

#endif

