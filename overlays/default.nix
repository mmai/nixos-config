#
# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: let ... in {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  overlay-mydist = final: prev: {
    mydist = import inputs.mydist {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # cf. https://gist.github.com/sioodmy/1932583dd8a804e0b3fe86416b923a16
  # overlay-wayland = inputs.nixpkgs-wayland.overlay;
}
