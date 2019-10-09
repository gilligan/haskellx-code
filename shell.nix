{ pkgs ? import <nixpkgs> {}}:
let 
  hsPkgs = pkgs.haskellPackages;
  hsEnv = hsPkgs.ghcWithPackages (hsPkgs: with hsPkgs; [ scotty ]);
in
  pkgs.mkShell {
    buildInputs = [ hsEnv pkgs.cabal-install pkgs.zlib ];
  }
