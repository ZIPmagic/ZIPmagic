// $Id: array.h,v 1.2 2001/03/06 01:37:25 serge Exp $
//
// Copyright (c)1999-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_array_h_included
#define un_array_h_included

#include "un/config.h"
#include "un/exception.h"
#include "un/stdint.h"

/** A wrapper for fixed-size built-in arrays that behaves as a reference type.

<p>This class adds STL-compatible notational convenience of a standard container
to built-in arrays.

<p>This class has no internal storage, does not copy the data, shares external
storage with a built-in array, does not delete storage upon destruction, and has
shallow copy and assignment behavior.

<p><b>References:</b>

<ul><li>Bjarne Stroustrup, <i>The C++ Programming Language</i>,
Third Edition, Addison-Wesley, Reading, MA, 1997, p. 496-497.</ul>

@author serge@aladdinsys.com
@version $Revision: 1.2 $, $Date: 2001/03/06 01:37:25 $
*/

namespace un {
    template<typename T> class array {
    public:
        /** Element type. */
        typedef T value_type;

        /** Element iterator. Behaves like <code>value_type*</code>. */
        typedef T* iterator;

        /** Constant element iterator. Behaves like <code>const value_type*</code>. */
        typedef const T* const_iterator;

        /** Element reference. Behaves like <code>value_type&</code>. */
        typedef T& reference;

        /** Constant element reference. Behaves like <code>const value_type&</code>. */
        typedef const T& const_reference;

        /** Size type. */
        typedef size_t size_type;

        /** Difference type. */
        typedef ptrdiff_t difference_type;

        /** Default constructor. Creates an empty array. */
        array() :
            data(0),
            capacity(0) {
        }

        /** Constructor. Creates an array from an existing buffer of elements.
        @param buf the buffer of elements
        @param size the number of elements in the buffer
        */
        array(T* buf, size_type size) :
            data(buf),
            capacity(size) {
        }

        /** Copy constructor.
        @param a the array to copy from
        */
        array(const array<T>& a) :
            data(a.data),
            capacity(a.capacity) {
        }

        /** Destructor. */
        ~array() {
        }

        /** Assignment operator.
        @param a the array to assign from
        */
        const array<T>& operator=(const array<T>& a) {
            if (this != &a) {
                data = a.data;
                capacity = a.capacity;
            }
            return *this;
        }

        /** Subscript operator. Provides unchecked element access.
        @param i index into the array; element index
        @return reference to the indexed element
        */
        reference operator[](size_type i) {
            #if debug_build
            if (!valid(i))
                throw un::exception("un::array::operator[] index out of bounds");
            #endif
            return data[i];
        }

        /** Constant subscript operator. Provides unchecked element access.
        @param i index into the array; element index
        @return constant reference to the indexed element
        */
        const_reference operator[](size_type i) const {
            #if debug_build
            if (!valid(i))
                throw un::exception("un::array::operator[] index out of bounds");
            #endif
            return data[i];
        }

        /** Container size.
        @return the number of elements
        */
        size_type size() const {
            return capacity;
        }

        /** Maximum container size.
        @return the maximum possible number of elements
        */
        size_type max_size() const {
            return capacity;
        }

        /** Conversion to ordinary array.
        @return the pointer to the ordinary "C" array
        */
        T* as_array() const {
            return data;
        }

        /** First element iterator.
        @return pointer to the first element
        */
        iterator begin() {
            return data;
        }

        /** Constant first element iterator.
        @return constant pointer to the first element
        */
        const_iterator begin() const {
            return data;
        }

        /** One past last element iterator.
        @return pointer to the one-past-last element
        */
        iterator end() {
            return data + capacity;
        }

        /** Constant one past last element iterator.
        @return constant pointer to the one-past-last element
        */
        const_iterator end() const {
            return data + capacity;
        }

    protected:
        /** Checks if an index is valid, i.e., within the array bounds.
        @param i the index to check
        @return <code>true</code> if the index is valid
        */
        bool valid(size_type i) const {
            return i < capacity;
        }

        /** The element array. */
        T* data;

        /** The size of the array. */
        size_type capacity;
    };
}

/** Class test.
@return <code>0</code> if successful, a positive error code otherwise
*/
int array_test();

#endif

