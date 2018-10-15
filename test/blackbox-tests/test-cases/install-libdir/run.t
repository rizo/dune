`dune install` should handle destination directories that don't exist

  $ dune build @install
  $ dune install --prefix install --libdir lib
  Installing install/lib/foo/META
  Installing install/lib/foo/foo$ext_lib
  Installing install/lib/foo/foo.cma
  Installing install/lib/foo/foo.cmi
  Installing install/lib/foo/foo.cmt
  Installing install/lib/foo/foo.cmx
  Installing install/lib/foo/foo.cmxa
  Installing install/lib/foo/foo.cmxs
  Installing install/lib/foo/foo.dune
  Installing install/lib/foo/foo.ml
  Installing install/lib/foo/opam
  Installing install/bin/exec

If prefix is passed, the default for libdir is `$prefix/lib`:

  $ dune install --prefix install
  Installing install/lib/foo/META
  Installing install/lib/foo/foo$ext_lib
  Installing install/lib/foo/foo.cma
  Installing install/lib/foo/foo.cmi
  Installing install/lib/foo/foo.cmt
  Installing install/lib/foo/foo.cmx
  Installing install/lib/foo/foo.cmxa
  Installing install/lib/foo/foo.cmxs
  Installing install/lib/foo/foo.dune
  Installing install/lib/foo/foo.ml
  Installing install/lib/foo/opam
  Installing install/bin/exec

If prefix is not passed, libdir defaults to the output of `ocamlfind printconf
destdir`:

  $ export OCAMLFIND_DESTDIR=$(mktemp -d); dune install 2>&1 | sed s\#$OCAMLFIND_DESTDIR\#OCAMLFIND_DESTDIR\#\;s\#$(opam config var prefix)\#OPAM_VAR_PREFIX\# ; rm -r $OCAMLFIND_DESTDIR
  Installing OCAMLFIND_DESTDIR/foo/META
  Installing OCAMLFIND_DESTDIR/foo/foo$ext_lib
  Installing OCAMLFIND_DESTDIR/foo/foo.cma
  Installing OCAMLFIND_DESTDIR/foo/foo.cmi
  Installing OCAMLFIND_DESTDIR/foo/foo.cmt
  Installing OCAMLFIND_DESTDIR/foo/foo.cmx
  Installing OCAMLFIND_DESTDIR/foo/foo.cmxa
  Installing OCAMLFIND_DESTDIR/foo/foo.cmxs
  Installing OCAMLFIND_DESTDIR/foo/foo.dune
  Installing OCAMLFIND_DESTDIR/foo/foo.ml
  Installing OCAMLFIND_DESTDIR/foo/opam
  Installing OPAM_VAR_PREFIX/bin/exec

If only libdir is passed, binaries are installed under prefix/bin and libraries
in libdir:

  $ export OCAMLFIND_DESTDIR=$(mktemp -d) LIBDIR=$(mktemp -d); dune install --libdir $LIBDIR 2>&1 | sed s\#$LIBDIR\#LIBDIR\#\;s\#$(opam config var prefix)\#OPAM_VAR_PREFIX\# ; rm -r $OCAMLFIND_DESTDIR $LIBDIR
  Installing LIBDIR/foo/META
  Installing LIBDIR/foo/foo$ext_lib
  Installing LIBDIR/foo/foo.cma
  Installing LIBDIR/foo/foo.cmi
  Installing LIBDIR/foo/foo.cmt
  Installing LIBDIR/foo/foo.cmx
  Installing LIBDIR/foo/foo.cmxa
  Installing LIBDIR/foo/foo.cmxs
  Installing LIBDIR/foo/foo.dune
  Installing LIBDIR/foo/foo.ml
  Installing LIBDIR/foo/opam
  Installing OPAM_VAR_PREFIX/bin/exec
