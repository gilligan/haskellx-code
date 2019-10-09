{ pkgs ? import <nixpkgs> {} }:

let
  testing = import (pkgs.path + /nixos/lib/testing.nix) { system = builtins.currentSystem; };
  hello-service = import ./. { inherit pkgs; };
  makeTest = testing.makeTest;
in
  makeTest {
    name = "hello-service-test";

    machine = { pkgs, ... }:
    {
      virtualisation.memorySize = 1024;
      time.timeZone = "UTC";
      networking.firewall.allowedTCPPorts = [ 3000 ];
      environment.systemPackages = [ hello-service ];
      systemd.services.hello-service = {
        enable = true;
        description = "haskellX hello service";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Restart = "always";
          RestartSec = 2;
          ExecStart = "${hello-service}/bin/hello-service";
        };
      };
    };

    testScript = ''
      $machine->waitForUnit("multi-user.target");
      $machine->waitForUnit("hello-service");
      $machine->waitForOpenPort(3000);
      $machine->succeed("curl http://localhost:3000/folks | grep Welcome");
    '';
  }
