{
  description = "Landingpage a simple overview of running processes";
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

	/*
        packages = {
          backend = pkgs.stdenv.mkDerivation {
            pname = "backend";
            version = "1.0";
            src = ./backend;

            meta = {
              description = "Java backend watching various service status";
              license = pkgs.lib.licenses.mit;
            };
          };

          frontend = pkgs.stdenv.mkDerivation {
            pname = "frontend";
            version = "1.0";
            src = ./frontend;

            meta = {
              description = "JavaScript frontend displaying service status";
              license = pkgs.lib.licenses.mit;
            };
          };
        };
	*/
      }
    )
    // {
      nixDarwinModules.landingpage = self.nixosModules.landingpage;
      nixosModules.landingpage = {
        config,
        lib,
        pkgs,
        ...
      }: {
        options.landingpage.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable landingpage";
        };

        config = {
          warnings = if config.landingpage.enable
          then [
            ''
              Landingpage is still WIP. Things may work in unexpected ways.
            ''
          ] else [];
        };
      };
    };
}
