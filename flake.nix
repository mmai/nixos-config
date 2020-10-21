{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, nixpkgs-unstable }: 
  let
    system = "x86_64-linux";
    overlay-unstable = final: prev: {
      # unstable = nixpkgs-unstable.legacyPackages.${system};
      unstable = import nixpkgs-unstable {
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
              nixpkgs.overlays = [ overlay-unstable ];
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
            nixpkgs.overlays = [ overlay-unstable ];
            nixpkgs.config.allowUnfree = true ;
            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
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
            nixpkgs.overlays = [ overlay-unstable ];
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
