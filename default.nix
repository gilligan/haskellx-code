{ pkgs ? import <nixpkgs> {} }:
let
  hsPkgs = pkgs.haskellPackages;
in
  hsPkgs.callCabal2nix "hello-service" ./. {}
