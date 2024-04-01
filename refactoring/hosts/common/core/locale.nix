{ lib, ... }: {
  i18n.defaultLocale = lib.mkDefault "fr_FR.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Paris";
}
