{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    vocage.url = "github:proycon/vocage"; # tui space repetition (à la Anki)
    # guix.url = "github:mmai/guix-flake"; # broken ? (zsh completion close tmux window...)
    # mydist.url = "/home/henri/travaux/nixpkgs"; # my fork of nixpkgs
    mydist.url = "github:mmai/nixpkgs/mydist"; # my fork of nixpkgs /!\ on branch 'mydist'
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, vocage, home-manager, mydist }: 
  let
    overlay-unstable = system: final: prev: {
      unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };
    };
    overlay-vocage = system: final: prev: {
      vocage = import vocage {
        system = system;
      };
    };
    overlay-mydist = system: final: prev: {
      mydist = import mydist {
        system = system;
        config.allowUnfree = true;
      };
    };

    commonConfig = {
      allowUnfree = true ;
      permittedInsecurePackages = [
        # "xpdf-4.04" # terminal pdf viewer (used in nvim telekasten)
        "electron-24.8.6" # for feishin music player (added 2023-12-31)
      ];
    };

  in 

  {
    nixosConfigurations = 
    let 
      withHomeManager = username: homeFile: {config, lib, pkgs, utils, ... } : home-manager.nixosModules.home-manager {
        inherit config; inherit lib; inherit pkgs; inherit utils;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # home-manager.users.${username} = import homeFile;
        home-manager.users.henri = import homeFile;
        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      };
    in {

      henri-desktop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
	        # guix.nixosModule
          ( { config, pkgs, ... }:
            { imports = [ ./machines/home-desktop.nix # Include the results of the hardware scan.
                          ./configurations/home.nix
                          ./configurations/common.nix
                          ./cfg/notRaspberry.nix # virtualbox & android studio
                          # (withHomeManager "henri" ./homes/henri.nix)

                          home-manager.nixosModules.home-manager {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.henri = import ./homes/henri.nix;
                          }

                        ];

              # services.guix.enable = true;

              networking.hostName = "henri-desktop";
              nixpkgs.overlays = [ 
                # guix.overlay 
                (overlay-unstable system) (overlay-mydist system)  ];
              nixpkgs.config = commonConfig; 

              # Let 'nixos-version --json' know about the Git revision of this flake.
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
              system.stateVersion = "23.11";
              nix.registry.nixpkgs.flake = nixpkgs;
            }
          )
        ];
      };

      nixvm = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/virtualbox.nix
                        ./configurations/light.nix
                        # henriHome
                      ];
            networking.hostName = "nixvm";
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config = commonConfig; 
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
            system.stateVersion = "23.11";
          }
        )];
      };

      raspberry = let system = "aarch64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/raspberry4.nix
                        ./configurations/pro.nix
                        # henriHome
                      ];
            networking.hostName = "raspberry";
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config = commonConfig; 
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
            system.stateVersion = "22.05";
          }
        )];
      };

      henri-laptop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/asusZenbook.nix
                        ./configurations/home.nix
                        ./configurations/common.nix
                        ./cfg/notRaspberry.nix # virtualbox & android studio
                        # henriHome
                      ];
            networking.hostName = "henri-laptop";
            nixpkgs.overlays = [ (overlay-unstable system) (overlay-mydist system)];
            nixpkgs.config = commonConfig; 
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            system.stateVersion = "21.11";
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        )];
      };

      nettop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/shuttle.nix
                        ./configurations/server.nix
                      ];
            networking.hostName = "nettop";
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config = commonConfig; 
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
            system.stateVersion = "20.09";
          }
        )];
      };

      henri-netbook = let system = "i686-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/asusEeePc.nix
                        ./configurations/light.nix
                        # no need to import common.nix
                      ];
            networking.hostName = "henri-netbook";
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config = commonConfig; 


            # Setup cross compilation. ( `nixos-rebuild -j0 switch` to force using the remote builder )
            nixpkgs = {
              # platform for wich the derivation is built
              crossSystem = { config = "i686-unknown-linux-gnu"; system = "i686-linux"; }; 
              # platform on wich the derivation is built
              localSystem = { config = "x86_64-unknown-linux-gnu"; system = "x86_64-linux"; };
            };

            nix.distributedBuilds = true;
            nix.buildMachines = [ {
              hostName = "henri-desktop";
              sshUser = "henri";
              sshKey = "/home/henri/.ssh/id_rsa";
              system = "x86_64-linux";
            } ];

            # Enable tools for remote installation.
            security.sudo.enable = true;
            hardware.enableRedistributableFirmware = true;

            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            system.stateVersion = "20.09"; # Did you read the comment?
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        )];
      };

      henri-atixnet = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected 
          ( { config, pkgs, ... }:
          { imports = [ ./machines/atixnet-desktop.nix
                        ./configurations/pro.nix
                        ./configurations/common.nix
                        ./cfg/notRaspberry.nix # virtualbox & android studio
                        home-manager.nixosModules.home-manager {
                          home-manager.useGlobalPkgs = true;
                          home-manager.useUserPackages = true;
                          home-manager.users.henri = import ./homes/henri.nix;
                        }
                      ];
            networking.hostName = "henri-atixnet";
            nixpkgs.overlays = [ (overlay-unstable system) (overlay-mydist system) ];
            nixpkgs.config = commonConfig;
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            system.stateVersion = "23.11";
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        )];
      };

      henri-atixnet-laptop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected 
          ( { config, pkgs, ... }:
          { imports = [ ./machines/thinkpadX1.nix
                        ./configurations/pro.nix
                        ./configurations/common.nix
                        ./cfg/notRaspberry.nix # virtualbox & android studio
                        home-manager.nixosModules.home-manager {
                          home-manager.useGlobalPkgs = true;
                          home-manager.useUserPackages = true;
                          home-manager.users.henri = import ./homes/henri.nix;
                        }
                      ];
            networking.hostName = "henri-atixnet-laptop";
            nixpkgs.overlays = [ (overlay-unstable system) (overlay-mydist system) ];
            nixpkgs.config = commonConfig;
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            system.stateVersion = "23.11";
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        )];
      };
    };

  };

}
