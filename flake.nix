{
  description = "Developement and packaging flake for landingpage";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            # Java
            maven
            jdk17
            # Generic
            git
          ];
        };

        packages = {
          backend = pkgs.stdenv.mkDerivation {
            pname = "backend";
            version = "1.0";
            src = ./backend;

            buildInputs = with pkgs; [maven jdk17];
            buildPhase = "mvn package";
            installPhase = ''
              mkdir -p $out/bin
              cp target/landingpage-backend.jar $out/bin/
            '';
            meta = {
              description = "Java backend watching various service status";
              license = pkgs.lib.licenses.mit;
            };
          };

	  #frontend = pkgs.stdenv.mkDerivation {};
        };

        nixosModules.landingpage = { config, lib, pkgs, ...}: {
          options.landingpage.enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable landingpage";
          };
        };
      }
    );
}
