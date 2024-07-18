.PHONY: build test t clean dev_update fmt


build:
	dune build

clean:
	dune clean

t: test

test:
	dune runtest -f

fmt:
	dune build @fmt
	@echo 'run "dune promote" to update files'

doc:
	dune build @doc && $(BROWSER) _build/default/_doc/_html/caml-sdl2-mixer/CamlSDL2_mixer/Mixer/index.html

dev_update:
	opam install --working-dir ./caml-sdl2-mixer.opam

