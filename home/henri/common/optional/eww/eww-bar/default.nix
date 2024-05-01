{
  programs.eww = {
    configDir = ./.;
    enable = true;
    # package = inputs.eww.packages.${pkgs.system}.eww;
  };
}
