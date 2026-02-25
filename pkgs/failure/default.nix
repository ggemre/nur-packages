{ lib, rustPlatform, fetchFromGitHub, ncurses }:

rustPlatform.buildRustPackage rec {
  pname = "failure";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "ggemre";
    repo = pname;
    rev = version;
    sha256 = "0zfm4v6hnzjgcn8566frcixqz8y8w9k0yjhx8fvakyagnbscvvbk";
  };

  cargoHash = "sha256-SUt4uvs7iUYO480z4qOD1c06biwnHXiwVdmuAXDMTjg=";
  buildInputs = [ ncurses ];
}
