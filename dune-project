(lang dune 3.15)

(name caml-sdl2-mixer)
(version 1.0)

(generate_opam_files true)

(source
 (github ssbx/caml-sdl2-mixer))

(authors "Seb")

(maintainers "Seb")

(license "BSD Zero Clause License")

(documentation https://github.com/ssbx/caml-sdl2-mixer)

(use_standard_c_and_cxx_flags true)

(formatting (enabled_for ocaml))

(package
 (name caml-sdl2-mixer)
 (synopsis "Bindings to the SDL2 mixer library")
 (description "Bindings to the SDL2 mixer library")
 (depends ocaml dune caml-sdl2 conf-sdl2-mixer)
 (tags
  (topics bindings sound mixer player)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
