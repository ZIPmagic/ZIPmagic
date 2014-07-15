// $Id: opt_property.h,v 1.3 2001/03/06 10:10:20 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

#if !defined un_opt_property_h_included
#define un_opt_property_h_included

#include "un/property.h"

/** An optional property that may or may not be available at different times.
Equivalent to a <code>un::property</code> with an additional <code>bool</code>
value to indicate availability.

@author serge@aladdinsys.com
@version $Revision: 1.3 $, $Date: 2001/03/06 10:10:20 $
@see un::property
*/

namespace un {
    template<typename value_type> class opt_property {
    public:
        /** Default constructor. */
        opt_property() :
            v(),
            available(false) {
        }

        /** Conversion constructor. Initializes the value.
        @param t initial value of the property
        */
        opt_property(const value_type& value) :
            v(value),
            available(true) {
        }

        /** Destructor. */
        ~opt_property() {
        }

        /** Accessor (get). Has no arguments, and returns the reference to the
        property, as held by the variable. Marks the property as available (assumes
        that non-const access assigns/modifies the previously unavailable property).
        Obviously, this works best with const-correct code.
        @return non-const reference to the property value
        */
        value_type& operator()() {
            available(true);
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
        of the property - which it assigns to the variable. Marks the property as available.
        @param t new value of the property
        */
        void operator()(const value_type& value) {
            v = value;
            available(true);
        }

        /** Marks the property as unavailable. */
        void unavailable() {
            available(false);
        }

        /** The property availability flag. */
        un::property<bool> available;

    private:
        /* The value of the property. */
        value_type v;
    };
}

#endif

