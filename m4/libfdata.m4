dnl Functions for libfdata
dnl
dnl Version: 20150409

dnl Function to detect if libfdata is available
dnl ac_libfdata_dummy is used to prevent AC_CHECK_LIB adding unnecessary -l<library> arguments
AC_DEFUN([AX_LIBFDATA_CHECK_LIB],
 [dnl Check if parameters were provided
 AS_IF(
  [test "x$ac_cv_with_libfdata" != x && test "x$ac_cv_with_libfdata" != xno && test "x$ac_cv_with_libfdata" != xauto-detect],
  [AS_IF(
   [test -d "$ac_cv_with_libfdata"],
   [CFLAGS="$CFLAGS -I${ac_cv_with_libfdata}/include"
   LDFLAGS="$LDFLAGS -L${ac_cv_with_libfdata}/lib"],
   [AC_MSG_WARN([no such directory: $ac_cv_with_libfdata])
   ])
  ])

 AS_IF(
  [test "x$ac_cv_with_libfdata" = xno],
  [ac_cv_libfdata=no],
  [dnl Check for a pkg-config file
  AS_IF(
   [test "x$cross_compiling" != "xyes" && test "x$PKGCONFIG" != "x"],
   [PKG_CHECK_MODULES(
    [libfdata],
    [libfdata >= 20150409],
    [ac_cv_libfdata=yes],
    [ac_cv_libfdata=no])
   ])

  AS_IF(
   [test "x$ac_cv_libfdata" = xyes],
   [ac_cv_libfdata_CPPFLAGS="$pkg_cv_libfdata_CFLAGS"
   ac_cv_libfdata_LIBADD="$pkg_cv_libfdata_LIBS"],
   [dnl Check for headers
   AC_CHECK_HEADERS([libfdata.h])
 
   AS_IF(
    [test "x$ac_cv_header_libfdata_h" = xno],
    [ac_cv_libfdata=no],
    [dnl Check for the individual functions
    ac_cv_libfdata=yes
 
    AC_CHECK_LIB(
     fdata,
     libfdata_get_version,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
   
    dnl Stream functions
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_initialize,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_free,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_clone,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])

    AC_CHECK_LIB(
     fdata,
     libfdata_stream_empty,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_resize,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_reverse,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])

    AC_CHECK_LIB(
     fdata,
     libfdata_stream_get_number_of_segments,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_get_segment_by_index,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_set_segment_by_index,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_prepend_segment,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_append_segment,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
 
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_get_segment_index_at_offset,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_get_segment_at_offset,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
 
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_read_buffer,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_read_buffer_at_offset,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_write_buffer,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_seek_offset,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_get_offset,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
    AC_CHECK_LIB(
     fdata,
     libfdata_stream_get_size,
     [ac_cv_libfdata_dummy=yes],
     [ac_cv_libfdata=no])
 
    ac_cv_libfdata_LIBADD="-lfdata"
    ])
   ])
  ])

 AS_IF(
  [test "x$ac_cv_libfdata" = xyes],
  [AC_DEFINE(
   [HAVE_LIBFDATA],
   [1],
   [Define to 1 if you have the `fdata' library (-lfdata).])
  ])

 AS_IF(
  [test "x$ac_cv_libfdata" = xyes],
  [AC_SUBST(
   [HAVE_LIBFDATA],
   [1]) ],
  [AC_SUBST(
   [HAVE_LIBFDATA],
   [0])
  ])
 ])

dnl Function to detect how to enable libfdata
AC_DEFUN([AX_LIBFDATA_CHECK_ENABLE],
 [AX_COMMON_ARG_WITH(
  [libfdata],
  [libfdata],
  [search for libfdata in includedir and libdir or in the specified DIR, or no if to use local version],
  [auto-detect],
  [DIR])

 dnl Check for a shared library version
 AX_LIBFDATA_CHECK_LIB

 dnl Check if the dependencies for the local library version
 AS_IF(
  [test "x$ac_cv_libfdata" != xyes],
  [ac_cv_libfdata_CPPFLAGS="-I../libfdata";
  ac_cv_libfdata_LIBADD="../libfdata/libfdata.la";

  ac_cv_libfdata=local

  AC_DEFINE(
   [HAVE_LOCAL_LIBFDATA],
   [1],
   [Define to 1 if the local version of libfdata is used.])
  AC_SUBST(
   [HAVE_LOCAL_LIBFDATA],
   [1])
  ])

 AM_CONDITIONAL(
  [HAVE_LOCAL_LIBFDATA],
  [test "x$ac_cv_libfdata" = xlocal])
 AS_IF(
  [test "x$ac_cv_libfdata_CPPFLAGS" != "x"],
  [AC_SUBST(
   [LIBFDATA_CPPFLAGS],
   [$ac_cv_libfdata_CPPFLAGS])
  ])
 AS_IF(
  [test "x$ac_cv_libfdata_LIBADD" != "x"],
  [AC_SUBST(
   [LIBFDATA_LIBADD],
   [$ac_cv_libfdata_LIBADD])
  ])

 AS_IF(
  [test "x$ac_cv_libfdata" = xyes],
  [AC_SUBST(
   [ax_libfdata_pc_libs_private],
   [-lfdata])
  ])

 AS_IF(
  [test "x$ac_cv_libfdata" = xyes],
  [AC_SUBST(
   [ax_libfdata_spec_requires],
   [libfdata])
  AC_SUBST(
   [ax_libfdata_spec_build_requires],
   [libfdata-devel])
  ])
 ])
