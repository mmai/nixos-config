# Stremio is a modern media center that's a one-stop solution for your video entertainment. 
# source: https://gist.github.com/jasonwhite/d32f5806921471c857148276bfd32806 
{
  pkgs ? import <nixpkgs> {},
}:

with pkgs;
with builtins;

let
  serverJS = fetchurl {
    url = "https://s3-eu-west-1.amazonaws.com/stremio-artifacts/four/master/server.js";
    sha256 = "0znn18qdlix7wcgc19nx29dqlmfs0f4picfn0ai2mzpdfby9x0sa";
  };
in qt5.mkDerivation rec {
  name = "stremio";
  version = "4.4.106";

  nativeBuildInputs = [ which ];
  buildInputs = [
    ffmpeg
    mpv
    nodejs
    openssl
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtquickcontrols
    qt5.qtquickcontrols2
    qt5.qttools
    qt5.qttranslations
    qt5.qtwebchannel
    qt5.qtwebengine
    librsvg
  ];

  dontWrapQtApps = true;
  preFixup = ''
    wrapQtApp "$out/opt/stremio/stremio" --prefix PATH : "$out/opt/stremio"
  '';

  src = fetchgit {
    url = "https://github.com/Stremio/stremio-shell";
    rev = version;
    sha256 = "05lp1iq08n8wh7m12d9pz9lg6hwc0d936kmlzvdxwxbnm86cxy54";
    fetchSubmodules = true;
  };

  buildPhase = ''
    cp ${serverJS} server.js
    make -f release.makefile PREFIX="$out/"
  '';

  installPhase = ''
    make -f release.makefile install PREFIX="$out/"
    mkdir -p "$out/bin"
    ln -s "$out/opt/stremio/stremio" "$out/bin/stremio"
  '';
}
