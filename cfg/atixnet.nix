{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config.allowUnfree = true; };# XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
  nixUserRepository = builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz";
  # nixUserRepository = builtins.fetchTarball {
  #   # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
  #   url = "https://github.com/nix-community/NUR/archive/3a6a6f4da737da41e27922ce2cfacf68a109ebce.tar.gz";
  #   # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
  #   sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
  # };
in
  {

    nixpkgs.config.packageOverrides = pkgs: {
      nur = import nixUserRepository {
        inherit pkgs;
      };
    };

  environment.systemPackages = with pkgs; [
    unstable.teams # Microsoft teams instant messaging
  ];

}
