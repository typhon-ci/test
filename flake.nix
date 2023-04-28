{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    typhon.url = "github:typhon-ci/typhon";
  };

  outputs = { self, nixpkgs, typhon }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      libTyphon = typhon.actions.${system};
    in {
      typhonProject = libTyphon.mkProject {
        meta = {
          title = "Test";
          description = "testing Typhon";
          homepage = "https://typhon-ci.org";
        };
        actions = {
          jobsets = libTyphon.gitJobsets "https://github.com/typhon-ci/test";
        };
      };
      typhonJobs = {
        hello = pkgs.stdenv.mkDerivation {
          name = "hello";
          src = ./hello;
          configurePhase = ''
            echo Hello
            for i in $(seq 0 5 100); do
              printf "% 4d%s\n" $i '%'
              sleep 0.5
            done
            exit 1
            export PREFIX=$out
          '';
        };
        # failing = pkgs.stdenv.mkDerivation {
        #   name = "failing";
        # };
      };
    };
}
