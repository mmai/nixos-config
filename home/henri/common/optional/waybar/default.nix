{ pkgs, lib, ... }: {
  programs.waybar = {
    enable = true;
    # style = import ./style.nix;
    style = (builtins.readFile ./style.css);
    settings.mainBar = (import ./layout.nix) // (import ./modules.nix);
  };
}
