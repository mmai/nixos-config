# { stdenv, fetchurl, makeDesktopItem, makeWrapper
# , unzip
# , fontconfig, freetype, glib, gtk3
# , libX11, libXrender, libXtst }:
{ pkgs }:

# The build process is almost like eclipse's.
# See `pkgs/applications/editors/eclipse/*.nix`

with pkgs ; stdenv.mkDerivation rec { 
  name = "umldesigner-${version}";
  version = "9.0.0";

  desktopItem = makeDesktopItem {
    name = "UMLDesigner";
    exec = "UMLDesigner";
    icon = "UMLDesigner";
    desktopName = "UMLDesigner";
    comment = "Graphical tooling to edit and visualize UML models";
    # genericName = "Graphical tooling to edit and visualize UML models";
    categories = "Application;Development;";
  };

  buildInputs = [
    unzip
    fontconfig freetype glib gtk3
    libX11 libXrender libXtst
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  src = fetchurl { 
    url = "https://s3-eu-west-1.amazonaws.com/obeo-umldesigner-releases/${version}/bundles/UMLDesigner-linux.gtk.x86_64.zip";
    sha256 = "0r37rg1c7nynx7na9cq6pq00z2i63mbjfdb6hgvi7a0bizwdg6y4";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out

    # Patch binaries.
    interpreter=$(cat $NIX_CC/nix-support/dynamic-linker)
    patchelf --set-interpreter $interpreter $out/UMLDesigner
    patchelf --set-interpreter $interpreter $out/jre/bin/java

    makeWrapper $out/UMLDesigner $out/bin/UMLDesigner \
      --prefix LD_LIBRARY_PATH : ${stdenv.lib.makeLibraryPath ([ glib gtk3 libXtst ])} \
      --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"

    # Create desktop item.
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications

    mkdir -p $out/share/pixmaps
    ln -s $out/icon.xpm $out/share/pixmaps/UMLDesigner.xpm
  '';

  meta = with stdenv.lib; {
    homepage = http://www.umldesigner.org/;
    description = "Graphical tooling to edit and visualize UML models";
    longDescription = ''
      Uses the standard UML2 metamodel provided by the Eclipse Foundation.
      Based on Sirius, it provides an easy way to combine UML with domain specific modeling.
      You can extend the provided diagram definitions and seamlessly work on both UML and DSL models at the same time.
    '';
    license = licenses.epl20;
    platforms = [ "x86_64-linux" ];
    maintainers = [ maintainers.mmai ];
  };
}
