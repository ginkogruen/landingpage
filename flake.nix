{
  description = "Landingpage a simple overview of running processes";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    mvn2nix.url = "github:fzakaria/mvn2nix";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    mvn2nix,
    gitignore,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
	/*
        pkgsForSystem = system: import nixpkgs {
	  # ./overlay.nix contains the logic to package local repository
	  overlays = [ mvn2nix.overlay (./overlay.nix) ];
	  inherit system;
	};
	*/
        pkgs = import nixpkgs {
	  inherit system;
	  overlays = [
	    mvn2nix.overlay
	  ];
	};
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
          backend = let
            # Run the following in ./backend to generate the lockfile:
            # nix run github:fzakaria/mvn2nix#mvn2nix > mvn2nix-lock.json
            mavenRepository = pkgs.buildMavenRepositoryFromLockFile {file = ./backend/mvn2nix-lock.json;};
          in
            pkgs.stdenv.mkDerivation rec {
              pname = "backend";
              version = "1.0";
              name = "${pname}-${version}";
              src = /*gitignore.gitignoreSource ["*.nix"]*/ ./backend;

              nativeBuildInputs = with pkgs; [jdk17 maven makeWrapper];
              buildPhase = ''
                echo "Building with maven repository ${mavenRepository}"
                mvn package --offline -Dmaven.repo.local=${mavenRepository}
              '';

              installPhase = ''
                       # create the bin directory
                              mkdir -p $out/bin

                       # create a symbolic link for the lib directory
                       ln -s ${mavenRepository} $out/lib

                       # copy out the JAR
                       # Maven already setup the classpath to use m2 repository layout
                       # with prefix of lib/
                       cp target/${name}.jar $out/

                # create a wrapper that will automatically set the classpath
                # this should be the paths from the dependency derivation
                makeWrapper ${pkgs.jdk17}/bin/java $out/bin/${pname} \
                --add-flags "-jar $out/${name}.jar"
              '';
              meta = {
                description = "Java backend watching various service status";
                license = pkgs.lib.licenses.mit;
              };
            };

          frontend = pkgs.stdenv.mkDerivation {
            pname = "frontend";
            version = "1.0";
            src = gitignore.gitignoreSource ["*.nix"] ./frontend;
            meta = {
              description = "JavaScript frontend displaying service status";
              license = pkgs.lib.licenses.mit;
            };
          };
        };
      }
    )
    // {
      nixDarwinModules.landingpage = self.nixosModules.landingpage;
      nixosModules.landingpage = {
        config,
        lib,
        ...
      }: {
        options.landingpage.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable landingpage";
        };

        config = {
          warnings =
            if config.landingpage.enable
            then [
              ''
                Landingpage is still WIP. Things may work in unexpected ways.
              ''
            ]
            else [];
        };
      };
    };
}
