{
  description = "Tooling shell for the wallpaper library: fetch, translate and palette-cache peapix images";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          # imagemagick provides `magick`, used for the perceptual hash and
          # native-dimension checks; matugen generates the cached palettes;
          # translate-shell (`trans`) backs translate-metadata.py; git-lfs is
          # needed to materialise a stored image when a hash collision has to
          # be settled on pixels.
          packages = with pkgs; [
            python3
            imagemagick
            matugen
            translate-shell
            git
            git-lfs
          ];
        };
      }
    );
}
