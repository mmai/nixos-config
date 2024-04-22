{ lib, ... }: {
  time.timeZone = lib.mkDefault "Europe/Paris";

  i18n = {
    defaultLocale = lib.mkDefault "fr_FR.UTF-8";
    supportedLocales = [ "fr_FR.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  services.xserver.xkb = {
    layout = "us,fr";
    variant = "intl,"; # US, intl., with dead keys
    options = "compose:menu, grp:shifts_toggle"; # switch keyboard layout with both shift keys pressed 
  };
  console.useXkbConfig = true; # Console use same keyboard config as xserver

}
