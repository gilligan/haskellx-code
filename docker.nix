{ pkgs ? import <nixpkgs> {}
, compiler ? "ghc864"
}:

let 
  hello-service = import ./. { inherit compiler; };
in
  pkgs.dockerTools.buildLayeredImage {
    name = "hello-service";
    contents = [ pkgs.iana-etc ];
    config.Cmd = [ "${hello-service}/bin/hello-service" ];
  }
