{pkgs ? import <nixpkgs> {}}: {
  alejandra-spaced = pkgs.callPackage ./pkgs/alejandra-spaced {};
  mangowm-wlonly = pkgs.callPackage ./pkgs/mangowm-wlonly {};
  mangowm = pkgs.callPackage ./pkgs/mangowm {};
}
