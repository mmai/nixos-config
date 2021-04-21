{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  # inputs.mydist.url = "/home/henri/travaux/nixpkgs"; # my fork of nixpkgs
  inputs.mydist.url = "github:mmai/nixpkgs/mydist"; # my fork of nixpkgs /!\ on branch 'mydist'

  outputs = { self, nixpkgs, nixpkgs-unstable, mydist }: 
  let
    overlay-unstable = system: final: prev: {
      unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };
    };
    overlay-mydist = system: final: prev: {
      mydist = import mydist {
        system = system;
        config.allowUnfree = true;
      };
    };

  in 

  {
    nixosConfigurations = {

      henri-desktop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
            { imports = [ ./machines/home-desktop.nix # Include the results of the hardware scan.
                          ./configurations/home.nix
                          ./configurations/common.nix
                        ];
              nixpkgs.overlays = [ (overlay-unstable system) (overlay-mydist system) ];
              nixpkgs.config.allowUnfree = true ;

              # Let 'nixos-version --json' know about the Git revision of this flake.
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
              nix.registry.nixpkgs.flake = nixpkgs;
            }
          )
        ];
      };

      henri-laptop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/asusZenbook.nix
                        ./configurations/home.nix
                        ./configurations/common.nix
                      ];
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config.allowUnfree = true ;
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
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
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config.allowUnfree = true ;


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
                      ];
            networking.hostName = "henri-atixnet";
            nixpkgs.overlays = [ (overlay-unstable system) (overlay-mydist system) ];
            nixpkgs.config.allowUnfree = true ;
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        )];
      };

    };

  };

}
