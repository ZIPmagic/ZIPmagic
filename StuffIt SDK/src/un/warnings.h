// $Id: warnings.h,v 1.2 2001/03/06 08:39:11 serge Exp $
//
// Copyright (c)2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_warnings_h_included
#define un_warnings_h_included

/* Suppress pervasive Visual C++ compiler warnings of limited use and
make compiler output somewhat meaningful at high warning levels.
Also, promote important Visual C++ compiler warnings to higher levels.
Visual C++ standard library and STL headers generate a sea (on a second
thought, make that an ocean) of warnings at level 4, so we must avoid
warning level 4 that drowns meaningful warnings. Problem is, some
meaningful warnings are at level 4. Hence, include this abomination
every time you write a new file. (Borrowed from Stan Brown of Oak Road
Systems, with permission.)

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/06 08:39:11 $
*/

#if defined _MSC_VER
    #pragma warning(2: 4032) // (level 4) formal parameter 'number' has different type when promoted
    #pragma warning(2: 4092) // (level 4) sizeof returns 'unsigned long'
    #pragma warning(2: 4131) // (level 4) 'function' : uses old-style declarator
    #pragma warning(2: 4132) // (level 4) 'object' : const object should be initialized
    #pragma warning(2: 4152) // (level 4) non standard extension, function/data ptr conversion in expression
    #pragma warning(2: 4239) // (level 4) nonstandard extension used : 'token' : conversion from 'type' to 'type'
    #pragma warning(2: 4268) // (level 4) 'identifier' : 'const' static/global data initialized with compiler generated default constructor fills the object with zeros
    #pragma warning(2: 4701) // (level 4) local variable 'name' may be used without having been initialized
    #pragma warning(2: 4706) // (level 4) assignment within conditional expression
    #pragma warning(2: 4709) // (level 4) comma operator within array index expression

    #pragma warning(3: 4019) // (level 4) empty statement at global scope
    #pragma warning(3: 4057) // (level 4) 'operator' : 'identifier1' indirection to slightly different base types from 'identifier2'
    #pragma warning(3: 4061) // (level 4) enumerate 'identifier' in switch of enum 'identifier' is not explicitly handled by a case label
    #pragma warning(3: 4121) // (level 4) 'symbol' : alignment of a member was sensitive to packing
    #pragma warning(3: 4125) // (level 4) decimal digit terminates octal escape sequence
    #pragma warning(3: 4211) // (level 4) nonstandard extension used : redefined extern to static
    #pragma warning(3: 4213) // (level 4) nonstandard extension used : cast on l-value
    #pragma warning(3: 4222) // (level 4) nonstandard extension used : 'identifier' : 'static' should not be used on member functions defined at file scope
    #pragma warning(3: 4234) // (level 4) nonstandard extension used: 'keyword' keyword reserved for future use
    #pragma warning(3: 4235) // (level 4) nonstandard extension used : 'keyword' keyword not supported in this product
    #pragma warning(3: 4504) // (level 4) type still ambiguous after parsing 'number' tokens, assuming declaration
    //#pragma warning(3: 4505) // (level 4) 'function' : unreferenced local function has been removed
    #pragma warning(3: 4507) // (level 4) explicit linkage specified after default linkage was used
    #pragma warning(3: 4515) // (level 4) 'namespace' : namespace uses itself
    #pragma warning(3: 4516) // (level 4) 'class::symbol' : access-declarations are deprecated; member using-declarations provide a better alternative
    #pragma warning(3: 4517) // (level 4) access-declarations are deprecated; member using-declarations provice a better alternative
    #pragma warning(3: 4670) // (level 4) 'identifier' : this base class is inaccessible
    #pragma warning(3: 4671) // (level 4) 'identifier' : the copy constructor is inaccessible
    #pragma warning(3: 4673) // (level 4) throwing 'identifier' the following types will not be considered at the catch site
    #pragma warning(3: 4674) // (level 4) 'identifier' : the destructor is inaccessible
    #pragma warning(3: 4705) // (level 4) statement has no effect
    //#pragma warning(3: 4710) // (level 4) 'function' : function not inlined

    #pragma warning(4: 4250) // (level 2) 'class1' : inherits 'class2::member' via dominance
    #pragma warning(4: 4711) // (level 1) function 'function' selected for inline expansion
    #pragma warning(4: 4786) // (level 1) 'identifier' : identifier was truncated to 'number' characters in the debug information
#endif

#endif

