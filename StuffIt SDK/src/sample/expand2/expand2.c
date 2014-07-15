// Copyright (c)1999 Aladdin Systems, Inc. All Rights Reserved.
// 165 Westridge Drive, Watsonville, CA 95076
// http://www.aladdinsys.com/
// 831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.
//
// $Id: expand2.c,v 1.1.2.2 2001/07/05 23:35:04 serge Exp $

#include <stdio.h>
#include "stuffit5/Error.h"
#include "stuffit5/Reader.h"
#include "stuffit5/Version.h"

int main(int argc, char** argv) {
    int i;
    stuffit5_Reader reader;

    printf("StuffIt Engine %s\n", stuffit5_Version_readable());
    if (argc <= 1) {
        printf("Usage: expand2 (files...)\n");
        return 1;
    }

    reader = stuffit5_Reader_new();
    if (reader == 0) {
        printf("Cannot create an stuffit5_Reader\n");
        return 2;
    }

    for (i = 1; i < argc; i++) {
        printf("    Expanding %s...\n", argv[i]);
        if (stuffit5_Reader_open(argv[i], reader) == false) {
            stuffit5_Reader_delete(reader);
            printf("Cannot open %s\n", argv[i]);
            return 3;
        }

        if (stuffit5_Reader_decode(reader) == false)
            printf("Cannot decode %s: %s\n", argv[i], stuffit5_Error_description(stuffit5_Reader_getError(reader)));
        stuffit5_Reader_close(reader);
    }
    stuffit5_Reader_delete(reader);

    printf("All OK\n");
    return 0;
}

