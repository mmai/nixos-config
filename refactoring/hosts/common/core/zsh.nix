#
# This is a basic enablement of zsh at the host level as a safe guard
# in case enabling zsh as a home-manager module (see /home/henri/core/cli)
# at the user level fails for some reason.
#

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    promptInit = ""; # disable default (use zplug system with pure prompt instead)
    interactiveShellInit = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
  };
}
