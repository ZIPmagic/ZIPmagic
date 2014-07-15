#include "un/gcc/wstring.h" // own header
#include "un/config.h"

#if compiler_gcc

inline void* wstring::Rep::operator new(size_t s, size_t extra) {
    return ::operator new(s + extra * sizeof(wchar_t));
}

inline size_t wstring::Rep::
#if _G_ALLOC_CONTROL
    default_frob(size_t s)
#else
    frob_size(size_t s)
#endif
{
    size_t i = 16;
    while(i < s) i *= 2;
    return i;
}

inline wstring::Rep* wstring::Rep::create(size_t extra) {
    extra = frob_size(extra + 1);
    Rep* p = new(extra) Rep;
    p->res = extra;
    p->ref = 1;
    p->selfish = false;
    return p;
}

wchar_t* wstring::Rep::clone() {
    Rep* p = Rep::create(len);
    p->copy(0, data(), len);
    p->len = len;
    return p->data();
}

inline bool wstring::Rep::
#if defined _G_ALLOC_CONTROL
    default_excess(size_t s, size_t r)
#else
    excess_slop(size_t s, size_t r)
#endif
{
    return 2 *(s <= 16 ? 16 : s) < r;
}

inline bool wstring::check_realloc(size_t s) const {
    s += sizeof(wchar_t);
    return(rep()->ref > 1 || s > capacity() || Rep::excess_slop(s, capacity()));
}

void wstring::alloc(size_t size, bool save) {
    if (! check_realloc(size))
        return;
    Rep *p = Rep::create(size);
    if (save) {
        p->copy(0, data(), length());
        p->len = length();
    }
    else
        p->len = 0;
    repup(p);
}

wstring& wstring::replace(size_t pos1, size_t n1, const wstring& str, size_t pos2, size_t n2) {
    const size_t len2 = str.length();
    if (pos1 == 0 && n1 >= length() && pos2 == 0 && n2 >= len2)
        return operator=(str);
    if (pos2 > len2)
        throw out_of_range("pos2 > len2");
    if (n2 > len2 - pos2)
        n2 = len2 - pos2;
    return replace(pos1, n1, str.data() + pos2, n2);
}

inline void wstring::Rep::copy(size_t pos, const wchar_t *s, size_t n) {
    if (n)
        wchar_traits::copy(data() + pos, s, n);
}

inline void wstring::Rep::move(size_t pos, const wchar_t *s, size_t n) {
    if (n)
        wchar_traits::move(data() + pos, s, n);
}

wstring& wstring::replace(size_t pos, size_t n1, const wchar_t* s, size_t n2) {
    const size_t len = length();
    if (pos > len)
        throw out_of_range("pos > len");
    if (n1 > len - pos)
        n1 = len - pos;
    if (len - n1 > max_size() - n2)
        throw length_error("len - n1 > max_size() - n2");
    size_t newlen = len - n1 + n2;
    if (check_realloc(newlen)) {
        Rep *p = Rep::create(newlen);
        p->copy(0, data(), pos);
        p->copy(pos + n2, data() + pos + n1, len -(pos + n1));
        p->copy(pos, s, n2);
        repup(p);
    }
    else {
        rep()->move(pos + n2, data() + pos + n1, len -(pos + n1));
        rep()->copy(pos, s, n2);
    }
    rep()->len = newlen;
    return *this;
}

inline void wstring::Rep::set(size_t pos, const wchar_t c, size_t n) {
    wchar_traits::set (data() + pos, c, n);
}

wstring& wstring::replace(size_t pos, size_t n1, size_t n2, wchar_t c) {
    const size_t len = length();
    if (pos > len)
        throw out_of_range("pos > len");
    if (n1 > len - pos)
        n1 = len - pos;
    if (len - n1 > max_size() - n2)
        throw length_error("len - n1 > max_size() - n2");
    size_t newlen = len - n1 + n2;
    if (check_realloc(newlen)) {
        Rep *p = Rep::create(newlen);
        p->copy(0, data(), pos);
        p->copy(pos + n2, data() + pos + n1, len -(pos + n1));
        p->set (pos, c, n2);
        repup(p);
    }
    else {
        rep()->move(pos + n2, data() + pos + n1, len -(pos + n1));
        rep()->set (pos, c, n2);
    }
    rep()->len = newlen;
    return *this;
}

void wstring::resize(size_t n, wchar_t c) {
    if (n > max_size())
        throw length_error("n > max_size()");
    if (n > length())
        append(n - length(), c);
    else
        erase(n);
}

size_t wstring::copy(wchar_t* s, size_t n, size_t pos) {
    if (pos > length())
        throw out_of_range("pos > length()");
    if (n > length() - pos)
        n = length() - pos;
    wchar_traits::copy(s, data() + pos, n);
    return n;
}

size_t wstring::find(const wchar_t* s, size_t pos, size_t n) const {
    size_t xpos = pos;
    for (; xpos + n <= length(); ++xpos)
        if (wchar_traits::eq(data() [xpos], *s) && wchar_traits::compare(data() + xpos, s, n) == 0)
            return xpos;
    return npos;
}

inline size_t wstring::_find(const wchar_t* ptr, wchar_t c, size_t xpos, size_t len) {
    for (; xpos < len; ++xpos)
        if (wchar_traits::eq(ptr [xpos], c))
            return xpos;
    return npos;
}

size_t wstring::find(wchar_t c, size_t pos) const {
    return _find(data(), c, pos, length());
}

size_t wstring::rfind(const wchar_t* s, size_t pos, size_t n) const {
    if (n > length())
        return npos;
    size_t xpos = length() - n;
    if (xpos > pos)
        xpos = pos;
    for (++xpos; xpos-- > 0; )
        if (wchar_traits::eq(data() [xpos], *s) && wchar_traits::compare(data() + xpos, s, n) == 0)
            return xpos;
    return npos;
}

size_t wstring::rfind(wchar_t c, size_t pos) const {
    if (1 > length())
        return npos;
    size_t xpos = length() - 1;
    if (xpos > pos)
        xpos = pos;
    for (++xpos; xpos-- > 0; )
        if (wchar_traits::eq(data() [xpos], c))
            return xpos;
    return npos;
}

size_t wstring::find_first_of(const wchar_t* s, size_t pos, size_t n) const {
    size_t xpos = pos;
    for (; xpos < length(); ++xpos)
        if (_find(s, data() [xpos], 0, n) != npos)
            return xpos;
    return npos;
}

size_t wstring::find_last_of(const wchar_t* s, size_t pos, size_t n) const {
    size_t xpos = length() - 1;
    if (xpos > pos)
        xpos = pos;
    for (; xpos; --xpos)
        if (_find(s, data() [xpos], 0, n) != npos)
            return xpos;
    return npos;
}

size_t wstring::find_first_not_of(const wchar_t* s, size_t pos, size_t n) const {
    size_t xpos = pos;
    for (; xpos < length(); ++xpos)
        if (_find(s, data() [xpos], 0, n) == npos)
            return xpos;
    return npos;
}

size_t wstring::find_first_not_of(wchar_t c, size_t pos) const {
    size_t xpos = pos;
    for (; xpos < length(); ++xpos)
        if (wchar_traits::ne(data() [xpos], c))
            return xpos;
    return npos;
}

size_t wstring::find_last_not_of(const wchar_t* s, size_t pos, size_t n) const {
    size_t xpos = length() - 1;
    if (xpos > pos)
        xpos = pos;
    for (; xpos; --xpos)
        if (_find(s, data() [xpos], 0, n) == npos)
        return xpos;
    return npos;
}

size_t wstring::find_last_not_of(wchar_t c, size_t pos) const {
    size_t xpos = length() - 1;
    if (xpos > pos)
        xpos = pos;
    for (; xpos; --xpos)
        if (wchar_traits::ne(data() [xpos], c))
            return xpos;
    return npos;
}

int wstring::compare(const wstring& str, size_t pos, size_t n) const {
    if (pos > length())
        throw out_of_range("pos > length()");
    size_t rlen = length() - pos;
    if (rlen > n)
        rlen = n;
    if (rlen > str.length())
        rlen = str.length();
    int r = wchar_traits::compare(data() + pos, str.data(), rlen);
    if (r != 0)
        return r;
    if (rlen == n)
        return 0;
    return(length() - pos) - str.length();
}

int wstring::compare(const wchar_t* s, size_t pos, size_t n) const {
    if (pos > length())
        throw out_of_range("pos > length()");
    size_t rlen = length() - pos;
    if (rlen > n)
        rlen = n;
    int r = wchar_traits::compare(data() + pos, s, rlen);
    if (r != 0)
        return r;
    return (length() - pos) - n;
}

#if debug_build
istream& operator>>(istream& is, wstring& s) {
    int w = is.width(0);
    if (is.ipfx0()) {
        streambuf* sb = is.rdbuf();
        s.erase();
        while(1) {
            int ch = sb->sbumpc();
            if (ch == EOF) {
                is.setstate(ios::eofbit);
                break;
            }
            else if (wchar_traits::is_del(ch)) {
                sb->sungetc();
                break;
            }
            s += ch;
            if (--w == 1) break;
        }
    }
    is.isfx();
    if (s.length() == 0)
        is.setstate(ios::failbit);
    return is;
}

ostream& operator<<(std::ostream& o, const wstring& s) {
    return o.write(s.data(), s.length());
}

istream& getline(istream &is, wstring& s, wchar_t delim) {
    if (is.ipfx1()) {
        _IO_size_t count = 0;
        streambuf *sb = is.rdbuf();
        s.erase();
        while(1) {
            int ch = sb->sbumpc();
            if (ch == EOF) {
                is.setstate(count == 0 ? (ios::failbit|ios::eofbit) : ios::eofbit);
                break;
            }
            ++count;
            if (ch == delim) break;
            s += ch;
            if (s.length() == s.npos - 1) {
                is.setstate(ios::failbit);
                break;
            }
        }
    }
    // We need to be friends with istream to do this.
    // is._gcount = count;
    is.isfx();
    return is;
}
#endif

wstring::Rep wstring::nilRep = { 0, 0, 1 };

const size_t wstring::npos;

#if defined _G_ALLOC_CONTROL
bool(*wstring::Rep::excess_slop)(size_t, size_t) = wstring::Rep::default_excess;
size_t(*wstring::Rep::frob_size)(size_t) = wstring::Rep::default_frob;
#endif

wchar_t* wmemset(wchar_t* dest, const wchar_t& val, size_t len) {
    wchar_t* ptr = dest;
    while(len-- > 0)
        *ptr++ = val;
    return dest;
}

wchar_t* wmemcpy(wchar_t* dest, const wchar_t* src, size_t len) {
    wchar_t* result = dest;
    if (dest < src)
        while (len--)
            *dest++ = *src++;
    else {
        wchar_t* lasts = const_cast<wchar_t*>(src +(len - 1));
        wchar_t* lastd = dest +(len - 1);
        while (len--)
            *(char*)lastd-- = *(char*)lasts--;
    }
    return result;
}

#endif

