{ pkgs ? import <nixpkgs> { } }:

{
  alejandra-spaced = pkgs.callPackage ./pkgs/alejandra-spaced {};
  stacklet = pkgs.callPackage ./pkgs/stacklet {};
  failure = pkgs.callPackage ./pkgs/failure {};
}
