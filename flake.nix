{
  description = "Mmai's Nix-Config";

  inputs = {
    #################### Official NixOS Package Sources ####################

    # nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    #################### Flake / package utilities ####################

    # generate systems & enable module structure
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Secrets management. See ./docs/secretsmgmt.md
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-manager for declaring user/home configurations
    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Official NixOS hardware packages
    hardware.url = "github:nixos/nixos-hardware";

    #################### Additional sources ####################

    wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Windows management
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprswitch = {
      url = "github:h3rmt/hyprswitch/release";
      inputs.hyprswitch.follows = "nixpkgs";
    };

    # mydist.url = "github:mmai/nixpkgs/mydist"; # my fork of nixpkgs /!\ on branch 'mydist'

    # vim4LMFQR!
    # nixvim = {
    #   url = "github:nix-community/nixvim/nixos-23.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #################### Personal Repositories ####################

    # Private secrets repo.  See ./docs/secretsmgmt.md
    # Authenticate via ssh and use shallow clone
    # mysecrets = {
    #   url = "git+ssh://git@gitlab.com/emergentmind/nix-secrets.git?ref=main&shallow=1";
    #   flake = false;
    # };
  };

  outputs =
    inputs @ { flake-parts
    , self
    , ...
    }:
    let
      stateVersion = "24.05";
      system = "x86_64-linux";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./lib ];
      flake = { config, ... }: {
        # Home manager configurations
        homeConfigurations = {
          "henri@henri-desktop" = self.lib.mkHome [ ./home/henri/henri-desktop.nix ] stateVersion system;
          "henri@henri-atixnet-laptop" = self.lib.mkHome [ ./home/henri/henri-atixnet-laptop.nix ] stateVersion system;
        };

        # NixOS configurations
        nixosConfigurations = {
          henri-desktop = self.lib.mkLinuxSystem [ ./hosts/henri-desktop ] stateVersion system;
          henri-atixnet-laptop = self.lib.mkLinuxSystem [ ./hosts/henri-atixnet-laptop ] stateVersion system;
        };
      };
      systems = [ system ];
    };
}
