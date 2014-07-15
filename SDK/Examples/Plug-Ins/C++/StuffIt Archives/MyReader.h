/* ========================================================================== 
   Copyright(c) 1992-2002 MimarSinan International. All rights reserved.      
   This source code provided for demonstrative use only. All rights reserved. 
   ========================================================================== */

#include <iostream>
#include <string>
#include <stdlib.h>
#include "app/unstuff/Reader.h"
#include <time.h>

std::string Names;
std::string Sizes;
std::string CompSizes;
std::string Pass;
std::string DateTimes;

int itemCount;

namespace app {
    namespace unstuff {
        class MyReader : public app::unstuff::Reader {
        protected:
            bool fileInfoEvent(uint32_t position) {
				itemCount++;
				Names.append("\"");
				Names.append(fileInfo().name());
				Names.append("\",");
				if (fileInfo().isEncrypted())
				{
					Pass.append("\"");
					Pass.append(fileInfo().name());
					Pass.append("\",");
				}
				long time = fileInfo().modificationTime();
				struct tm* tm = gmtime(&time);
				char t[64];
				strftime(t, 64, "%Y %m %d-%H %M %S", tm);
				DateTimes.append("\"");
				DateTimes.append(t);
				DateTimes.append("\",");
				_itoa(fileInfo().uncompressedSize(), t, 10);
				Sizes.append("\"");
				Sizes.append(t);
				Sizes.append("\",");
				_itoa(fileInfo().compressedSize(), t, 10);
				CompSizes.append("\"");
				CompSizes.append(t);
				CompSizes.append("\",");
                return Reader::fileInfoEvent(position);
            }
        };
    }
}
