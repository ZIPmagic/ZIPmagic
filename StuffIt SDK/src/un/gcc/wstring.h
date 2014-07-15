// $Id: wstring.h,v 1.2.2.1 2001/07/05 23:35:27 serge Exp $
//
// Copyright (c)1998-2001 Aladdin Systems, Inc. All Rights Reserved.
// 245 Westridge Drive, Watsonville, CA 95076, USA
// http://www.aladdinsys.com/
// 1-831-761-6200
//
// This source code and specific concepts contained herein are confidential
// information and property of Aladdin Systems. Distribution is prohibited
// without written permission of Aladdin Systems.

/** Deals with gcc/egcs not defining <code>std::wstring</code> properly.

@author serge@aladdinsys.com
@version $Revision: 1.2.2.1 $, $Date: 2001/07/05 23:35:27 $
*/

#if !defined un_gcc_wstring_included
#define un_gcc_wstring_included

#include "un/config.h"

#if compiler_gcc

#include <cstddef>
#include <iterator>
#include <stdexcept>
#include "un/config.h"
#if debug_build
    #include <iostream>
#endif

struct wchar_traits {
    static void assign(wchar_t& c1, const wchar_t& c2) { c1 = c2; }
    static bool eq(const wchar_t & c1, const wchar_t& c2) { return c1 == c2; }
    static bool ne(const wchar_t& c1, const wchar_t& c2) { return c1 != c2; }
    static bool lt(const wchar_t& c1, const wchar_t& c2) { return c1 < c2; }
    static wchar_t eos() { return 0; }
    static bool is_del(wchar_t wc) { return wc == ' ' || wc == '\t' || wc == '\n' || wc == '\r'; }

    static int compare(const wchar_t* s1, const wchar_t* s2, size_t n) {
        size_t i;
        for (i = 0; i < n; ++i)
            if (ne(s1[i], s2[i]))
                return lt(s1[i], s2[i]) ? -1 : 1;
        return 0;
    }

    static size_t length (const wchar_t* s) {
        size_t l = 0;
        while (ne(*s++, eos ()))
            ++l;
        return l;
    }

    static wchar_t* copy (wchar_t* s1, const wchar_t* s2, size_t n) {
        for (; n--; )
            assign(s1[n], s2[n]);
        return s1;
    }

    static wchar_t* move (wchar_t* s1, const wchar_t* s2, size_t n) {
        wchar_t a[n];
        size_t i;
        for (i = 0; i < n; ++i)
            assign(a[i], s2[i]);
        for (i = 0; i < n; ++i)
            assign(s1[i], a[i]);
        return s1;
    }

    static wchar_t* set (wchar_t* s1, const wchar_t& c, size_t n) {
        for (; n--; )
            assign(s1[n], c);
        return s1;
    }
};

class wstring {
private:
    struct Rep {
        size_t len, res, ref;
        bool selfish;

        wchar_t* data() { return reinterpret_cast<wchar_t*>(this + 1); }
        wchar_t& operator[](size_t s) { return data()[s]; }
        wchar_t* grab() {
            if (selfish) return clone();
            ++ref;
            return data();
        }
        void release() { if (--ref == 0) delete this; }

        inline static void* operator new(size_t, size_t);
        inline static Rep* create(size_t);
        wchar_t* clone();

        inline void copy(size_t, const wchar_t *, size_t);
        inline void move(size_t, const wchar_t *, size_t);
        inline void set(size_t, const wchar_t, size_t);

        #if _G_ALLOC_CONTROL
        // These function pointers allow you to modify the allocation policy used
        // by the std::string classes.  By default they expand by powers of two, but
        // this may be excessive for space-critical applications.

        // Returns true if ALLOCATED is too much larger than LENGTH
        static bool(*excess_slop)(size_t length, size_t allocated);
        inline static bool default_excess(size_t, size_t);

        // Returns a good amount of space to allocate for a std::string of length LENGTH
        static size_t(*frob_size)(size_t length);
        inline static size_t default_frob(size_t);
        #else
        inline static bool excess_slop(size_t, size_t);
        inline static size_t frob_size(size_t);
        #endif

    private:
        Rep& operator=(const Rep&);
    };

public:
    // types:
    typedef wchar_t* iterator;
    typedef const wchar_t* const_iterator;
    typedef ::reverse_iterator<iterator> reverse_iterator;
    typedef ::reverse_iterator<const_iterator> const_reverse_iterator;
    static const size_t npos = static_cast<size_t>(-1);

private:
    Rep* rep() const { return reinterpret_cast<Rep*>(dat) - 1; }
    void repup(Rep* p) { rep()->release(); dat = p->data(); }

public:
    const wchar_t* data() const { return rep()->data(); }
    size_t length() const { return rep()->len; }
    size_t size() const { return rep()->len; }
    size_t capacity() const { return rep()->res; }
    size_t max_size() const { return (npos - 1) / sizeof(wchar_t); }
    bool empty() const { return size() == 0; }

    wstring& operator=(const wstring& str) {
        if (&str != this) { rep()->release(); dat = str.rep()->grab(); }
        return *this;
    }

    wstring() : dat(nilRep.grab()) { }
    wstring(const wstring& str) : dat(str.rep()->grab()) { }
    wstring(const wstring& str, size_t pos, size_t n = npos) : dat(nilRep.grab()) { assign(str, pos, n); }
    wstring(const wchar_t* s, size_t n) : dat(nilRep.grab()) { assign(s, n); }
    wstring(const wchar_t* s) : dat(nilRep.grab()) { assign(s); }
    wstring(size_t n, wchar_t c) : dat(nilRep.grab()) { assign(n, c); }

    #if defined __STL_MEMBER_TEMPLATES
    template<typename InputIterator> wstring(InputIterator begin, InputIterator end)
    #else
    wstring(const_iterator begin, const_iterator end)
    #endif
        : dat(nilRep.grab()) { assign(begin, end); }

    ~wstring() { rep()->release(); }

    void swap(wstring &s) { wchar_t* d = dat; dat = s.dat; s.dat = d; }

    wstring& append(const wstring& str, size_t pos = 0, size_t n = npos) { return replace(length(), 0, str, pos, n); }
    wstring& append(const wchar_t* s, size_t n) { return replace(length(), 0, s, n); }
    wstring& append(const wchar_t* s) { return append(s, wchar_traits::length(s)); }
    wstring& append(size_t n, wchar_t c) { return replace(length(), 0, n, c); }
    #if defined __STL_MEMBER_TEMPLATES
    template<typename InputIterator> wstring& append(InputIterator first, InputIterator last)
    #else
    wstring& append(const_iterator first, const_iterator last)
    #endif
    { return replace(iend(), iend(), first, last); }

    wstring& assign(const wstring& str, size_t pos = 0, size_t n = npos) { return replace(0, npos, str, pos, n); }
    wstring& assign(const wchar_t* s, size_t n) { return replace(0, npos, s, n); }
    wstring& assign(const wchar_t* s) { return assign(s, wchar_traits::length(s)); }
    wstring& assign(size_t n, wchar_t c) { return replace(0, npos, n, c); }
    #if defined __STL_MEMBER_TEMPLATES
    template<typename InputIterator> wstring& assign(InputIterator first, InputIterator last)
    #else
    wstring& assign(const_iterator first, const_iterator last)
    #endif
    { return replace(ibegin(), iend(), first, last); }

    wstring& operator=(const wchar_t* s) { return assign(s); }
    wstring& operator=(wchar_t c) { return assign(1, c); }

    wstring& operator+=(const wstring& rhs) { return append(rhs); }
    wstring& operator+=(const wchar_t* s) { return append(s); }
    wstring& operator+=(wchar_t c) { return append(1, c); }

    wstring& insert(size_t pos1, const wstring& str, size_t pos2 = 0, size_t n = npos) { return replace(pos1, 0, str, pos2, n); }
    wstring& insert(size_t pos, const wchar_t* s, size_t n) { return replace(pos, 0, s, n); }
    wstring& insert(size_t pos, const wchar_t* s) { return insert(pos, s, wchar_traits::length(s)); }
    wstring& insert(size_t pos, size_t n, wchar_t c) { return replace(pos, 0, n, c); }
    iterator insert(iterator p, wchar_t c) { insert(p - ibegin(), 1, c); return p; }
    iterator insert(iterator p, size_t n, wchar_t c) { insert(p - ibegin(), n, c); return p; }
    #if defined __STL_MEMBER_TEMPLATES
    template<typename InputIterator> void insert(iterator p, InputIterator first, InputIterator last)
    #else
    void insert(iterator p, const_iterator first, const_iterator last)
    #endif
    { replace(p, p, first, last); }

    wstring& erase(size_t pos = 0, size_t n = npos) { return replace(pos, n,(size_t)0,(wchar_t)0); }
    iterator erase(iterator p) { replace(p - ibegin(), 1,(size_t)0,(wchar_t)0); return p; }
    iterator erase(iterator f, iterator l) { replace(f - ibegin(), l - f,(size_t)0,(wchar_t)0); return f; }

    wstring& replace(size_t pos1, size_t n1, const wstring& str, size_t pos2 = 0, size_t n2 = npos);
    wstring& replace(size_t pos, size_t n1, const wchar_t* s, size_t n2);
    wstring& replace(size_t pos, size_t n1, const wchar_t* s) { return replace(pos, n1, s, wchar_traits::length(s)); }
    wstring& replace(size_t pos, size_t n1, size_t n2, wchar_t c);
    wstring& replace(size_t pos, size_t n, wchar_t c) { return replace(pos, n, 1, c); }
    wstring& replace(iterator i1, iterator i2, const wstring& str) { return replace(i1 - ibegin(), i2 - i1, str); }
    wstring& replace(iterator i1, iterator i2, const wchar_t* s, size_t n) { return replace(i1 - ibegin(), i2 - i1, s, n); }
    wstring& replace(iterator i1, iterator i2, const wchar_t* s) { return replace(i1 - ibegin(), i2 - i1, s); }
    wstring& replace(iterator i1, iterator i2, size_t n, wchar_t c) { return replace(i1 - ibegin(), i2 - i1, n, c); }
    #if defined __STL_MEMBER_TEMPLATES
    template<typename InputIterator> wstring& replace(iterator i1, iterator i2, InputIterator j1, InputIterator j2);
    #else
    wstring& replace(iterator i1, iterator i2, const_iterator j1, const_iterator j2);
    #endif

private:
    static wchar_t eos() { return wchar_traits::eos(); }
    void unique() { if (rep()->ref > 1) alloc(capacity(), true); }
    void selfish() { unique(); rep()->selfish = true; }

public:
    wchar_t operator[](size_t pos) const { if (pos == length()) return eos(); return data()[pos]; }
    wchar_t& operator[](size_t pos) { unique(); return (*rep())[pos]; }
    wchar_t& at(size_t pos) { if (pos >= length()) throw out_of_range("pos >= length()"); return (*this)[pos]; }
    const wchar_t& at(size_t pos) const {  if (pos >= length()) throw out_of_range("pos >= length()"); return data()[pos]; }

private:
    void terminate() const { wchar_traits::assign((*rep())[length()], eos()); }

public:
    const wchar_t* c_str() const { terminate(); return data(); }
    void resize(size_t n, wchar_t c);
    void resize(size_t n) { resize(n, eos()); }
    void reserve(size_t) { }

    size_t copy(wchar_t* s, size_t n, size_t pos = 0);

    size_t find(const wstring& str, size_t pos = 0) const { return find(str.data(), pos, str.length()); }
    size_t find(const wchar_t* s, size_t pos, size_t n) const;
    size_t find(const wchar_t* s, size_t pos = 0) const { return find(s, pos, wchar_traits::length(s)); }
    size_t find(wchar_t c, size_t pos = 0) const;

    size_t rfind(const wstring& str, size_t pos = npos) const { return rfind(str.data(), pos, str.length()); }
    size_t rfind(const wchar_t* s, size_t pos, size_t n) const;
    size_t rfind(const wchar_t* s, size_t pos = npos) const { return rfind(s, pos, wchar_traits::length(s)); }
    size_t rfind(wchar_t c, size_t pos = npos) const;

    size_t find_first_of(const wstring& str, size_t pos = 0) const { return find_first_of(str.data(), pos, str.length()); }
    size_t find_first_of(const wchar_t* s, size_t pos, size_t n) const;
    size_t find_first_of(const wchar_t* s, size_t pos = 0) const { return find_first_of(s, pos, wchar_traits::length(s)); }
    size_t find_first_of(wchar_t c, size_t pos = 0) const { return find(c, pos); }

    size_t find_last_of(const wstring& str, size_t pos = npos) const { return find_last_of(str.data(), pos, str.length()); }
    size_t find_last_of(const wchar_t* s, size_t pos, size_t n) const;
    size_t find_last_of(const wchar_t* s, size_t pos = npos) const { return find_last_of(s, pos, wchar_traits::length(s)); }
    size_t find_last_of(wchar_t c, size_t pos = npos) const { return rfind(c, pos); }

    size_t find_first_not_of(const wstring& str, size_t pos = 0) const { return find_first_not_of(str.data(), pos, str.length()); }
    size_t find_first_not_of(const wchar_t* s, size_t pos, size_t n) const;
    size_t find_first_not_of(const wchar_t* s, size_t pos = 0) const { return find_first_not_of(s, pos, wchar_traits::length(s)); }
    size_t find_first_not_of(wchar_t c, size_t pos = 0) const;

    size_t find_last_not_of(const wstring& str, size_t pos = npos) const { return find_last_not_of(str.data(), pos, str.length()); }
    size_t find_last_not_of(const wchar_t* s, size_t pos, size_t n) const;
    size_t find_last_not_of(const wchar_t* s, size_t pos = npos) const { return find_last_not_of(s, pos, wchar_traits::length(s)); }
    size_t find_last_not_of(wchar_t c, size_t pos = npos) const;

    wstring substr(size_t pos = 0, size_t n = npos) const { return wstring(*this, pos, n); }

    int compare(const wstring& str, size_t pos = 0, size_t n = npos) const;
    // There is no 'strncmp' equivalent for wchar_t pointers.
    int compare(const wchar_t* s, size_t pos, size_t n) const;
    int compare(const wchar_t* s, size_t pos = 0) const { return compare(s, pos, wchar_traits::length(s)); }

    iterator begin() { selfish(); return &(*this)[0]; }
    iterator end() { selfish(); return &(*this)[length()]; }

private:
    iterator ibegin() const { return &(*rep())[0]; }
    iterator iend() const { return &(*rep())[length()]; }

public:
    const_iterator begin() const { return ibegin(); }
    const_iterator end() const { return iend(); }

    reverse_iterator rbegin() { return reverse_iterator(end()); }
    const_reverse_iterator rbegin() const { return const_reverse_iterator(end()); }
    reverse_iterator rend() { return reverse_iterator(begin()); }
    const_reverse_iterator rend() const { return const_reverse_iterator(begin()); }

private:
    void alloc(size_t size, bool save);
    static size_t _find(const wchar_t* ptr, wchar_t c, size_t xpos, size_t len);
    inline bool check_realloc(size_t s) const;

    static Rep nilRep;
    wchar_t* dat;
};

#if defined __STL_MEMBER_TEMPLATES
template <class InputIterator> wstring& wstring::replace(iterator i1, iterator i2, InputIterator j1, InputIterator j2)
#else
wstring& wstring::replace(iterator i1, iterator i2, const_iterator j1, const_iterator j2)
#endif
{
    const size_t len = length();
    size_t pos = i1 - ibegin();
    size_t n1 = i2 - i1;
    size_t n2 = j2 - j1;
    if (pos > len) throw out_of_range("pos > len");
    if (n1 > len - pos)
        n1 = len - pos;
    if (len - n1 > max_size() - n2) throw length_error("len - n1 > max_size() - n2");
    size_t newlen = len - n1 + n2;
    if (check_realloc(newlen)) {
        Rep *p = Rep::create(newlen);
        p->copy(0, data(), pos);
        p->copy(pos + n2, data() + pos + n1, len -(pos + n1));
        for (; j1 != j2; ++j1, ++pos)
            wchar_traits::assign((*p)[pos], *j1);
        repup(p);
    }
    else {
        rep()->move(pos + n2, data() + pos + n1, len -(pos + n1));
        for (; j1 != j2; ++j1, ++pos)
        wchar_traits::assign((*rep())[pos], *j1);
    }
    rep()->len = newlen;
    return *this;
}

inline wstring operator+(const wstring& lhs, const wstring& rhs) {
    wstring str(lhs);
    str.append(rhs);
    return str;
}

inline wstring operator+(const wchar_t* lhs, const wstring& rhs) {
    wstring str(lhs);
    str.append(rhs);
    return str;
}


inline wstring operator+(wchar_t lhs, const wstring& rhs) {
    wstring str(1, lhs);
    str.append(rhs);
    return str;
}

inline wstring operator+(const wstring& lhs, const wchar_t* rhs) {
    wstring str(lhs);
    str.append(rhs);
    return str;
}

inline wstring operator+(const wstring& lhs, wchar_t rhs) {
    wstring str(lhs);
    str.append(1, rhs);
    return str;
}

inline bool operator==(const wstring& lhs, const wstring& rhs) {
    return lhs.compare(rhs) == 0;
}

inline bool operator==(const wchar_t* lhs, const wstring& rhs) {
    return rhs.compare(lhs) == 0;
}

inline bool operator==(const wstring& lhs, const wchar_t* rhs) {
    return lhs.compare(rhs) == 0;
}

inline bool operator!=(const wchar_t* lhs, const wstring& rhs) {
    return rhs.compare(lhs) != 0;
}

inline bool operator!=(const wstring& lhs, const wchar_t* rhs) {
    return lhs.compare(rhs) != 0;
}

inline bool operator<(const wstring& lhs, const wstring& rhs) {
    return lhs.compare(rhs) < 0;
}

inline bool operator<(const wchar_t* lhs, const wstring& rhs) {
    return rhs.compare(lhs) > 0;
}

inline bool operator<(const wstring& lhs, const wchar_t* rhs) {
    return lhs.compare(rhs) < 0;
}

inline bool operator>(const wchar_t* lhs, const wstring& rhs) {
    return rhs.compare(lhs) < 0;
}

inline bool operator>(const wstring& lhs, const wchar_t* rhs) {
    return lhs.compare(rhs) > 0;
}

inline bool operator<=(const wchar_t* lhs, const wstring& rhs) {
    return rhs.compare(lhs) >= 0;
}

inline bool operator<=(const wstring& lhs, const wchar_t* rhs) {
    return lhs.compare(rhs) <= 0;
}

inline bool operator>=(const wchar_t* lhs, const wstring& rhs) {
    return rhs.compare(lhs) <= 0;
}

inline bool operator>=(const wstring& lhs, const wchar_t* rhs) {
    return lhs.compare(rhs) >= 0;
}

inline bool operator!=(const wstring& lhs, const wstring& rhs) {
    return lhs.compare(rhs) != 0;
}

inline bool operator>(const wstring& lhs, const wstring& rhs) {
    return lhs.compare(rhs) > 0;
}

inline bool operator<=(const wstring& lhs, const wstring& rhs) {
    return lhs.compare(rhs) <= 0;
}

inline bool operator>=(const wstring& lhs, const wstring& rhs) {
    return lhs.compare(rhs) >= 0;
}

#if debug_build
istream& operator>>(istream&, wstring&);
ostream& operator<<(std::ostream&, const wstring&);
istream& getline(istream&, wstring&, wchar_t delim = '\n');
#endif

#endif

#endif

