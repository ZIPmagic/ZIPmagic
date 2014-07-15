// $Id: auto_ptr.h,v 1.3 2001/03/06 01:37:25 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_auto_ptr_h_included
#define un_auto_ptr_h_included

#include "un/config.h"
#if compiler_msvc
    #pragma warning(4: 4284) // return type for 'un::auto_ptr<T>::operator ->' is 'T *' (ie; not a UDT or reference to a UDT.  Will produce errors if applied using infix notation)
#endif

/** A smart pointer class that stores a pointer to a dynamically allocated
object. (Dynamically allocated objects are those allocated with the C++ scalar
<code>new</code>). This class deletes the object that the pointer points to, in
the destructor or explicitly with <code>reset()</code>.

<p>This class uses scalar C++ <code>delete</code> and therefore will not work
correctly with arrays. <code>un::auto_array</code> should be used for
pointers to arrays.

<p>This class is a simple solution for pointers that do not have shared ownership.
It has a private copy constructor and a private assignment operator, which disallow
transfer of ownership of the stored pointer. <code>un::counted_ptr</code>
should be used for shared ownership pointers.

<p>This class should not have any time or space overhead over built-in pointers.

<p>This class is a template parameterized on <code>T</code>, the type of the
object it points to. To work correctly, <code>T</code>'s destructor must not
throw exceptions.

<p>This class is similar to <code>std::auto_ptr</code> but does not implement
ownership and transfer of ownership semantics.

<p><b>References:</b>

<ul><li>David Dodgson, <i>Evolution of the C++ Standard Library</i>, ACM SIGPLAN
Notices, v. 31, n. 12 (December 1996), p. 22-26.

<li>T. A. Cargill, <i>Localized Ownership: Managing Dynamic Objects in C++</i>,
in Pattern Languages of Program Design - 2 / edited by J. Vlissides, J. O.
Coplien, and N. Kerth, Reading, MA : Addison-Wesley, 1996, p. 518.

<li>Greg Colvin &lt;gregor@@netcom.com&gt;, <i>Specifications for auto_ptr and
counted_ptr</i>, posted to comp.std.c++ on Thursday, May 25, 1995.

<li>C++ Boost Smart Pointer Library by Greg Colvin and Beman Dawes.
http://www.boost.org.</ul>

@author serge@aladdinsys.com
@version $Revision: 1.3 $, $Date: 2001/03/06 01:37:25 $
@see un::counted_ptr
@see un::auto_array
*/

namespace un {
    template<typename T> class auto_ptr {
    public:
        /** Provides the type of the stored pointer. */
        typedef T element_type;

        /** Default constructor. Creates a <code>un::auto_ptr</code>, storing a
        copy of <code>p</code>, which must be a pointer to a dynamically
        allocated object of type <code>T</code> or a 0. */
        explicit auto_ptr(T* p = 0) : pointer(p) {
        }

        /** Construct from a reference instead of a pointer, as a convenience to callers
        that deal in references. The caller should avoid storing and using the original
        reference - which becomes invalid after delete. */
        explicit auto_ptr(T& r) : pointer(&r) {
        }

        /** Destructor. Deletes the object pointed to by the stored pointer.
        Note that the C++ scalar <code>delete</code> on a pointer with a value
        of 0 is harmless. */
        ~auto_ptr() {
            delete pointer;
        }

        /** Deletes the object and stores a new pointer. If <code>p</code> is
        not equal to the stored pointer, deletes the object pointed to by the
        stored pointer and then stores a copy of <code>p</code>, which must be a
        pointer to a dynamically allocated object or a 0.
        @param p the new value of the pointer
        */
        void reset(T* p = 0) {
            if (pointer != p) {
                delete pointer;
                pointer = p;
            }
        }

        /** Returns a reference to the object.
        @return a reference to the object that the stored pointer points to
        */
        T& operator*() const {
            return *pointer;
        }

        /** Returns a pointer to the object.
        @return a pointer to the object that the stored pointer points to
        */
        T* operator->() const {
            return pointer;
        }

        /** Returns a pointer to the object.
        @return a pointer to the object that the stored pointer points to
        */
        T* operator()() const {
            return pointer;
        }

    private:
        /** Unimplemented copy constructor. */
        auto_ptr(const auto_ptr& p);

        /** Unimplemented assignment operator. */
        const auto_ptr& operator=(const auto_ptr& p);

        /** The object pointer. */
        T* pointer;
    };
}

/** Class test.
@return <code>0</code> if successful, a positive error code otherwise
*/
int auto_ptr_test();

#endif // un_auto_ptr_h_included

