{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.mydist.url = "github:mmai/nixpkgs/mydist"; # my fork of nixpkgs

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

      henri-desktop = nixpkgs.lib.nixosSystem {
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

      henri-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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

      henri-netbook = nixpkgs.lib.nixosSystem {
        system = "i686-linux";
        modules = [ 
          nixpkgs.nixosModules.notDetected
          ( { config, pkgs, ... }:
          { imports = [ ./machines/asusEeePc.nix
                        ./configurations/light.nix
                        # no need to import common.nix
                      ];
            nixpkgs.overlays = [ (overlay-unstable system) ];
            nixpkgs.config.allowUnfree = true ;
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            system.stateVersion = "20.09"; # Did you read the comment?
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        )];
      };

      henri-atixnet = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
