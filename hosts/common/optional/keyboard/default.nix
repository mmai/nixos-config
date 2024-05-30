{ pkgs, config, ... }:
{
  services.xserver.xkb.extraLayouts = {
    ergol = {
      description = "French (Ergo-L)";
      # copié de https://github.com/Nuclear-Squid/ergol/releases/download/ergol-v1.0.0/ergol.xkb_symbols
      symbolsFile = symbols/ergol.xkb_symbols;
      languages = [ "fr" ];
    };
  };

}
