{ pkgs }:

let 
  version = "9.0.0";
in
pkgs.stdenv.mkDerivation { 
  name = "umldesigner-${version}";
  src = pkgs.fetchurl { 
    url = "https://s3-eu-west-1.amazonaws.com/obeo-umldesigner-releases/${version}/bundles/UMLDesigner-linux.gtk.x86.zip";
    sha256 = "1fz696kj0c0cniyhs0vnsnz9aab2zmay7ky0ix0b97bnyzrx9mrj";
  };
  buildInputs = [ pkgs.unzip ];
  installPhase = ''
    mkdir -p $out
    cp -r * $out
    runHook postInstall
  '';

  postInstall = ''
    ${pkgs.patchelf}/bin/patchelf \
      --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      $out/UMLDesigner
    ${pkgs.patchelf}/bin/patchelf \
      --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      $out/jre/bin/java
      '';
}
