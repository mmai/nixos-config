{
  inputs,
  config,
  ...
}: let
  pkgsForSystem = system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
in {
  flake.lib = {
    mkHome = modules: stateVersion: system:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsForSystem system;
        extraSpecialArgs = {
          inherit inputs stateVersion system;
          flake = {inherit config;};
        };
        inherit modules;
      };
    mkLinuxSystem = modules: stateVersion: system:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs stateVersion system;
          flake = {inherit config;};
          pkgs = pkgsForSystem system;
        };
        inherit modules;
      };
    inherit pkgsForSystem;
  };
}
