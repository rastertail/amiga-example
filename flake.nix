{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
        pkgs-unpatched = import nixpkgs { inherit system; };
        nixpkgs-patched = pkgs-unpatched.applyPatches {
          name = "nixpkgs-amiga";
          src = nixpkgs;
          patches = [ (pkgs-unpatched.fetchpatch {
            url = "https://github.com/rastertail/nixpkgs/compare/3c632ea1f62ea76be77b57a28e65615b4c8e5148...e7dc736224e863bb945e1cd3f5ad474cdbda8de1.patch";
            sha256 = "sha256-q6ZCXWO7ZspXkybWP+mfJjlUejrQPecX+sISpriBbwU=";
          }) ];
        };
        pkgs = import nixpkgs-patched { inherit system; };
        pkgsCross = import nixpkgs-patched { inherit system; crossSystem = {
          config = "m68k-amiga-elf";
        }; };
      in {
        devShell = pkgsCross.mkShell {
          nativeBuildInputs = [ pkgs.ninja pkgs.fsuae pkgs.vlink ];
          buildInputs = [ pkgs.ndk_32 ];
        };
      }
    );
}
