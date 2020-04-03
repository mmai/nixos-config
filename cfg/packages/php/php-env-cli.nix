{ pkgs }:
let 
msgpack-php = (import ./msgpack-php/default.nix) {inherit pkgs; };

in

pkgs.stdenv.mkDerivation rec {
  name = "php-env-cli";
  stdenv = pkgs.stdenv;
  env = pkgs.buildEnv { 
    inherit buildInputs name;
    paths = buildInputs;
    postBuild = ''
      mkdir $out/bin.writable && cp --symbolic-link `readlink $out/bin`/* $out/bin.writable/ && rm $out/bin && mv $out/bin.writable $out/bin
      wrapProgram $out/bin/php --add-flags "-d extension_dir=$out/lib/php/extensions -d extension=msgpack.so"
    '';
  };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';

  buildInputs = (with pkgs; [ php makeWrapper ]) ++ [msgpack-php]; 
}
