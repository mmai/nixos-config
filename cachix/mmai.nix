
{
  nix.settings = {
    substituters = [
      "https://mmai.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "mmai.cachix.org-1:Tsm/Qy4nL22PplBmJCWhE8CorgfO4NGy+mRPF85EEeQ="
    ];
  };
}
    
