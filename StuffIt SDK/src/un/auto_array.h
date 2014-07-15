// $Id: auto_array.h,v 1.1 2001/03/03 00:03:47 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_auto_array_h_included
#define un_auto_array_h_included

#include "un/stdint.h"

/** A smart pointer class that stores a pointer to a dynamically allocated array
of objects. (Dynamically allocated arrays are those allocated with the C++
vector <code>new</code>). This class deletes the array of objects that the
pointer points to, in the destructor or explicitly with <code>reset()</code>. It
is an extension of <code>un::auto_ptr</code> to arrays of objects.

<p>This class uses vector C++ <code>delete</code> and therefore will not work
correctly with individual objects. <code>un::auto_ptr</code> should be used
for pointers to objects.

<p>This class is a simple solution for pointers that do not have shared ownership.
It has a private copy constructor and a private assignment operator, which disallow
transfer of ownership of the stored pointer. <code>un::counted_array</code>
should be used for shared-ownership pointers.

<p>This class should not have any time or space overhead over built-in pointers.

<p>This class is a template parameterized on <code>T</code>, the type of the
object it points to. To work correctly, <code>T</code>'s destructor must not
throw exceptions.

<p>A more functional alternative to this class is a <code>un::auto_ptr</code>
to an <code>std::vector</code>.

<p>This class is similar to <code>std::auto_ptr</code> but uses C++ vector
<code>delete</code> and does not implement ownership and transfer of ownership
semantics.

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2001/03/03 00:03:47 $
@see un::auto_ptr
@see un::counted_array
*/

namespace un {
    template<typename T> class auto_array {
    public:
        /** Provides the type of the stored pointer. */
        typedef T element_type;

        /** Default constructor. Creates a <code>un::auto_array</code>, storing
        a copy of <code>p</code>, which must be a pointer to a dynamically
        allocated array of objects of type <code>T</code> or a 0.
        */
        explicit auto_array(T* p = 0) : pointer(p) {
        }

        /** Destructor. Deletes the array of objects pointed to by the stored
        pointer. Note that the C++ vector <code>delete</code> on a pointer with
        a value of 0 is harmless. */
        ~auto_array() {
            delete[] pointer;
        }

        /** Deletes the array of objects and stores a new pointer. If
        <code>p</code> is not equal to the stored pointer, deletes the object
        pointed to by the stored pointer and then stores a copy of
        <code>p</code>, which must be a pointer to a dynamically allocated array
        of objects or a 0.

        @param p the new value of the pointer
        */
        void reset(T* p = 0) {
            if (pointer != p) {
                delete[] pointer;
                pointer = p;
            }
        }

        /** Returns a reference to an element of the array. Behavior is
        undefined if the stored pointer is 0 or if <code>i</code> is less than 0
        or is greater or equal to the number of elements in the array.

        @param i the index of the element of the array
        @return a reference to element <code>i</code> of the array that the
        stored pointer points to
        */
        T& operator[](size_t i) const {
            return pointer[i];
        }

        /** Returns a pointer to the object.

        @return a pointer to the array of objects that the stored pointer points to
        */
        T* operator()() const {
            return pointer;
        }

    private:
        /** Unimplemented copy constructor. */
        auto_array(const auto_array& p);

        /** Unimplemented assignment operator. */
        const auto_array& operator=(const auto_array& p);

        /** The pointer to the array of objects. */
        T* pointer;
    };
}

/** Class test.
@return <code>0</code> if successful, a positive error code otherwise
*/
int auto_array_test();

#endif // un_auto_array_h_included

