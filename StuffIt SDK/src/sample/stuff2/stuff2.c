// Copyright (c)1999-2000 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: stuff2.c,v 1.4.2.2 2001/07/05 23:35:05 serge Exp $

//#include "misc/gcc/avoid_systypes.h"
#include <stdio.h>
#include <stdlib.h>
#include "stuffit5/ArchiveInfo.h"
#include "stuffit5/bool.h"
#include "stuffit5/Error.h"
#include "stuffit5/FileInfo.h"
#include "stuffit5/Version.h"
#include "stuffit5/Writer.h"
#include "stuffit5/event/ArchiveCreateBeginListener.h"
#include "stuffit5/event/ArchiveCreateEndListener.h"
#include "stuffit5/event/FileEncodeBeginListener.h"

bool archiveCreateBeginEvent(stuffit5_Writer writer) {
    stuffit5_ArchiveInfo archive = stuffit5_Writer_archiveInfo(writer);
    printf("Creating %s\n", stuffit5_ArchiveInfo_getName(archive));
    return true;
}

void archiveCreateEndEvent(stuffit5_Writer writer) {
    writer; // please gcc
    printf("done\n");
}

bool fileEncodeBeginEvent(stuffit5_Writer writer) {
    stuffit5_FileInfo file = stuffit5_Writer_fileInfo(writer);
    printf("%s\n", stuffit5_ArchiveInfo_getName(file));
    return true;
}

int main(int argc, char** argv) {
    int i;
    stuffit5_Writer writer;
    const char** names;

    printf("StuffIt Engine %s\n", stuffit5_Version_readable());
    if (argc <= 1) {
        printf("Usage: stuff2 (files...)\n");
        return 1;
    }

	writer = stuffit5_Writer_new();
    if (writer == 0) {
        printf("Cannot create an stuffit5_Writer\n");
        return 2;
    }

    stuffit5_Writer_addArchiveCreateBeginListener(archiveCreateBeginEvent, writer);
    stuffit5_Writer_addArchiveCreateEndListener(archiveCreateEndEvent, writer);
    stuffit5_Writer_addFileEncodeBeginListener(fileEncodeBeginEvent, writer);

	names = (const char**)malloc(argc * sizeof(const char*));
    if (names == 0) {
        stuffit5_Writer_delete(writer);
        printf("Out of memory\n");
        return 2;
    }

    for (i = 1; i < argc; i++)
        names[i - 1] = argv[i];
	names[argc - 1] = engineNameListEnd;

    if (stuffit5_Writer_create(names, writer) == false) {
        free((void*)names);
        stuffit5_Writer_delete(writer);
        printf("Cannot create a StuffIt archive: %s\n", stuffit5_Error_description(stuffit5_Writer_getError(writer)));
        return 3;
    }

    free((void*)names);
    stuffit5_Writer_delete(writer);

    printf("All OK\n");
    return 0;
}

