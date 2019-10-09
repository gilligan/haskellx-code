{ pkgs ? import <nixpkgs> {}
, compiler ? "ghc864"
}:

(import ./. {inherit compiler;}).overrideAttrs(o: {
  buildInputs = o.buildInputs ++ [pkgs.cabal-install pkgs.hlint]; 
})
