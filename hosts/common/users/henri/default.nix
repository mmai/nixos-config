{ pkgs, inputs, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # TODO : sops
  # Decrypt ta-password to /run/secrets-for-users/ so it can be used to create the user
  # sops.secrets.ta-password.neededForUsers = true;
  # users.mutableUsers = false; # Required for password to be set via sops during system activation!

  users.users.henri = {
    isNormalUser = true;
    # TODO : sops
    # hashedPasswordFile = config.sops.secrets.ta-password.path;
    shell = pkgs.zsh; # default shell
    # shell = pkgs.nushell;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "plugdev"
      "input"
    ] ++ ifTheyExist [
      "docker"
      "virtualbox"
      "network"
      "networkmanager"
    ];

    # openssh.authorizedKeys.keys = [
    #   (builtins.readFile ./keys/id_meek.pub)
    # ];

    packages = [ pkgs.home-manager ];
  };

  # Import this user's personal/home configurations
  home-manager.users.henri = import ../../../../home/henri/${config.networking.hostName}.nix;

}
