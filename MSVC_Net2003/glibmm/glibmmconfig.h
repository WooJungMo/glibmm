/* glib/glibmmconfig.h.  Generated by configure.  */
#ifndef _GLIBMM_CONFIG_H
#define _GLIBMM_CONFIG_H 1

/* version numbers */
#define GLIBMM_MAJOR_VERSION 2
#define GLIBMM_MINOR_VERSION 4
#define GLIBMM_MICRO_VERSION 4

// detect common platforms
#if defined(_WIN32)
// Win32 compilers have a lot of varation
#if defined(_MSC_VER)
#define GLIBMM_MSC
#define GLIBMM_WIN32
#define GLIBMM_DLL
#elif defined(__CYGWIN__)
#define GLIBMM_GCC
#elif defined(__MINGW32__)
#define GLIBMM_WIN32
#define GLIBMM_GCC
#define GLIBMM_DLL
#else
#warning "Unknown architecture (send me gcc --dumpspecs or equiv)"
#endif
#else
#define GLIBMM_GCC
#endif /* _WIN32 */

#ifdef GLIBMM_GCC
/* compiler feature tests that are used during compile time and run-time
   by gtk-- only. tests used by gdk-- and gtk-- should go into
   gdk--config.h.in */
/* #undef GLIBMM_CXX_HAVE_MUTABLE */
/* #undef GLIBMM_CXX_HAVE_NAMESPACES */
//#undef GLIBMM_CXX_GAUB
//#undef GLIBMM_CXX_AMBIGUOUS_TEMPLATES
#endif

#ifdef GLIBMM_MSC
#define GLIBMM_CXX_HAVE_MUTABLE
#define GLIBMM_CXX_HAVE_NAMESPACES
#pragma warning (disable: 4786 4355 4800 4181)
#endif

/* #undef GLIBMM_COMPILER_SUN_FORTE */

/* #undef GLIBMM_DEBUG_REFCOUNTING */

#define GLIBMM_HAVE_NAMESPACE_STD 1
#define GLIBMM_HAVE_STD_ITERATOR_TRAITS 1
/* #undef GLIBMM_HAVE_SUN_REVERSE_ITERATOR */
#define GLIBMM_HAVE_TEMPLATE_SEQUENCE_CTORS 1, Defined if the STL containers have templated sequence ctors
#define GLIBMM_HAVE_DISAMBIGUOUS_CONST_TEMPLATE_SPECIALIZATIONS 1

#ifndef GLIBMM_HAVE_NAMESPACE_STD
#  define GLIBMM_USING_STD(Symbol) namespace std { using ::Symbol; }
#else
#  define GLIBMM_USING_STD(Symbol) /* empty */
#endif

#ifdef GLIBMM_DLL
#if defined(GLIBMM_BUILD)
#define GLIBMM_API __declspec(dllexport)
#elif !defined(GLIBMM_BUILD)
#define GLIBMM_API __declspec(dllimport)
#else
#define GLIBMM_API
#endif /* glibmm_COMPILATION - DLL_EXPORT */
#else
#define GLIBMM_API
#endif /* GLIBMM_DLL */

#endif /* _GLIBMM_CONFIG_H */

