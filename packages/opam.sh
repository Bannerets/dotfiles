#!/usr/bin/env bash

opam update

opam install -y \
  dune \
  utop \
  ocaml-lsp-server \
  merlin \
  odoc \
  ocamlformat \
  ocp-indent \
  ocp-index \
  base
