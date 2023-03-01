{ config, lib, pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
    # Microsoft teams instant messaging
    # teams # 2022-02-26 => error: cannot download teams_1.5.00.23861_amd64.deb from any mirror

    # Java / Android dev
    android-studio # launch with `unset GDK_PIXBUF_MODULE_FILE ; android-studio` (cf. https://github.com/NixOS/nixpkgs/issues/52302#issuecomment-477818365) -> done in .zsh/aliases.sh
    # jetbrains.jdk
    # oraclejdk # old insecure ffmpeg lib dependency 
  ];
}
