// $Id: property.h,v 1.1 2001/03/03 00:03:47 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_property_h_included
#define un_property_h_included

/** A property is an aspect of an object. The property idiom maintains the value
of a property in a member variable, hidden behind accessor and mutator functions
that <i>get</i> and <i>set</i> it. It uses a C++ template to generate access functions
automatically.

<p>This class greatly simplifies the tedious process of writing access methods used
to encapsulate class data and decouple class interface from its implementation.
Classes become not only easier to write but also easier to read and understand.

<p><b>Example.</b> Suppose that the name property of class <code>Being</code>
has type <code>std::string</code>. Then we can define:

<pre>
    // A non-anthropocentric version of Person, as in: spokesbeing, gentlebeing, chairbeing.
    class Being {
    public:
        std::string name() { return name_; } // accessor
        void name(const std::string& s) { name_ = s; } // mutator

    private:
        std::string name_; // variable
    };
</pre>

<p>The <code>un::property</code> template defined below allows us to
rewrite the previous <code>Being</code> class as:

<pre>
    class Being {
    public:
        un::property<std::string> name;
    };
</pre>

<p>This class has a single member called <code>name</code> of type
<code>un::property&lt;std::string&gt;</code>. The property defines a hidden
variable and its accessor and mutator. <code>un::property</code> captures
the variable: other member functions of <code>Being</code> - if there were any -
could not access it. The new class behaves just as its predecessor did, but is easier
to understand because the reader sees one <code>un::property</code> in place
of three assorted members.

<p>All of <code>un::property</code>'s functions are inlined, therefore the space
and time cost of the template ought to be zero.

<p><b>Why use the property idiom?</b> The property idiom hides a variable, then
immediately provides read and write access to it. Why not simply expose the
variable? There are two reasons. We do not want clients having to remember which
features are accessed as variables and which as properties. Accessing all as
properties provides a uniform interface. We may wish to change the way that a
property works. For example, we may wish to trap access to the variable, or even
to simulate its existence. Properties provide the means to do so without
modifying client code.

<p><b>Constant properties.</b> The <code>un::property</code> template can
use <code>const</code> to make a constant property, for example:

<pre>
    class Being {
    public:
        Being(const Date& d) : date_of_birth(d) { }
        const un::property<Date> date_of_birth;
    };
</pre>

<p>The <code>date_of_birth</code> <code>un::property</code> is initialized
by the constructor, as the underlying variable was. How do <code>const</code>
properties work? The accessor operator is <code>const</code>, so can be called on
<code>const</code> properties, whereas the mutator isn't, so can't be.

<p><b>References:</b>

<ul><li>Colin Hastie, <i>Patterns in Practice: A property template for C++</i>,
C++ Report, November 1995.

<li>J. O. Coplien, <i>Advanced C++ Programming Styles and Idioms</i>,
Addison-Wesley, Reading, MA, 1992, p. 38-45.</ul>

@author serge@aladdinsys.com
@version $Revision: 1.1 $, $Date: 2001/03/03 00:03:47 $
@see un::opt_property
*/

namespace un {
    template<typename value_type> class property {
    public:
        /** Default constructor. */
        property() :
            v() {
        }

        /** Conversion constructor. Initializes the value.
        @param t initial value of the property
        */
        property(const value_type& value) :
            v(value) {
        }

        /** Destructor. */
        ~property() {
        }

        /** Accessor (get). Has no arguments, and returns the reference to the
        property, as held by the variable.
        @return non-const reference to the property value
        */
        value_type& operator()() {
            return v;
        }

        /** Const accessor (get). Has no arguments, and returns the const reference
        to the property, as held by the variable.
        @return const reference to the property value
        */
        const value_type& operator()() const {
            return v;
        }

        /** Mutator (set). Returns nothing, and has one argument - the new value
        of the property - which it assigns to the variable.
        @param t new value of the property
        */
        void operator()(const value_type& value) {
            v = value;
        }

    private:
        /** The value of the property. */
        value_type v;
    };
}

/** Class test.
@return <code>0</code> if successful, a positive error code otherwise
*/
int property_test();

#endif

