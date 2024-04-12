{
  description = "Mmai's Nix-Config";

  inputs = {
    #################### Official NixOS Package Sources ####################

    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    #################### Utilities ####################

    # Official NixOS hardware packages
    hardware.url = "github:nixos/nixos-hardware";

    wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Windows management
    # for now trying to avoid this one because I want stability for my wm
    # this is the hyprland development flake package / unstable
    # hyprland = {
    #   url = "github:hyprwm/hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #   hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Secrets management. See ./docs/secretsmgmt.md
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-manager for declaring user/home configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mydist.url = "github:mmai/nixpkgs/mydist"; # my fork of nixpkgs /!\ on branch 'mydist'

    # vim4LMFQR!
    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #################### Personal Repositories ####################

    # Private secrets repo.  See ./docs/secretsmgmt.md
    # Authenticate via ssh and use shallow clone
    # mysecrets = {
    #   url = "git+ssh://git@gitlab.com/emergentmind/nix-secrets.git?ref=main&shallow=1";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        # "x86_64-darwin"
        # "aarch64-darwin"
        "i686-linux"
      ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;

      # Custom modules to enable special functionality for nixos or home-manager oriented configs.
      # -- currently empty (2024-04-01)
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # Custom modifications/overrides to upstream packages.
      # -- ex : apply a patch in the source code of a package...
      overlays = import ./overlays { inherit inputs outputs; };

      # Your custom packages meant to be shared or upstreamed.
      # Accessible through 'nix build', 'nix shell', etc
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      # Nix formatter available through 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      # Shell configured with packages that are typically only needed when working on or with nix-config.
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      #################### NixOS Configurations ####################
      #
      # Available through 'nixos-rebuild --flake .#hostname'
      # Typically adopted using 'sudo nixos-rebuild switch --flake .#hostname'

      nixosConfigurations = {
        # home pc
        henri-desktop = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/henri-desktop ];
          specialArgs = { inherit inputs outputs; };
        };
        # work laptop (thinkpad X1)
        henri-atixnet-laptop = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/henri-atixnet-laptop ];
          specialArgs = { inherit inputs outputs; };
        };
        # old work desktop
        henri-atixnet = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/henri-atixnet ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      #################### User-level Home-Manager Configurations ####################
      #
      # Available through 'home-manager --flake .#primary-username@hostname'
      # Typically adopted using 'home-manager switch --flake .#primary-username@hostname'

      homeConfigurations = {
        "henri@henri-desktop" = lib.homeManagerConfiguration {
          modules = [ ./home/henri/henri-desktop.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "henri@henri-atixnet-laptop" = lib.homeManagerConfiguration {
          modules = [ ./home/henri/henri-atixnet-laptop.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
