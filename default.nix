{ pkgs ? import <nixpkgs> {}
, compiler ? "ghc864"
}:

let
  hsPkgs = pkgs.haskell.packages.${compiler};
in
  hsPkgs.callCabal2nix "hello-service" ./. {}
