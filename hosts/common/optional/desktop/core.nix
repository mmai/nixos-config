{ pkgs, ... }:

{

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1; # Enable Alt+Sysrq+r key (why is it restricted by default ?) to recover from freezed X sessions
  };

  #FONTS
  #  nerdfonts for dev symbols in text editors
  #  noto-fonts-cjk for chinese characters
  fonts = {
    # permet de lister les fonts dans /nix/var/nix/profiles/system/sw/share/X11/fonts : 
    # cd /nix/var/nix/profiles/system/sw/share/X11/fonts
    # fc-query MesloLGSNerdFontMono-Regular.ttf | grep 'family:'
    fontDir.enable = true;

    packages = with pkgs; [
      victor-mono
        dejavu_fonts
        meslo-lgs-nf
        fantasque-sans-mono # `a tester
        powerline-fonts
        nerdfonts
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk
        noto-fonts-emoji
    ];

    fontconfig.defaultFonts = {
      # monospace = [ "DejaVuSansMono Nerd Font" ];
      monospace = [ "MesloLGS Nerd Font Mono" ]; # font recommended by powerlevel10k zsh prompt. 
    };
  };

  # Chinese input
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

}
