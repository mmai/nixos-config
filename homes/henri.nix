# { config, lib, home-manager, ... }:
#     home-manager.nixosModules.home-manager {
#       home-manager.useGlobalPkgs = true;
#       home-manager.useUserPackages = true;
#       # home-manager.users.henri = import ./homes/henri.nix;
#       home-manager.users.henri = { pkgs, ... }: {
#         xdg.desktopEntries.nvim = {
#           name = "WrappedNeovim";
#           exec="alacritty -e nvim %F";
#           terminal=false;
#           type="Application";
#           icon="nvim";
#           categories=[ "Utility" "TextEditor"];
#           startupNotify=false;
#           mimeType=[ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++"]; 
#         };
#         # home.packages = [ pkgs.atool pkgs.httpie ];
#         # programs.bash.enable = true;
#       };
#     }
{ pkgs, ... }: {
  home.stateVersion = "22.11";
  xdg.desktopEntries.nvim = {
    name = "WrappedNeovim";
    exec="alacritty -e nvim %F";
    terminal=false;
    type="Application";
    icon="nvim";
    categories=[ "Utility" "TextEditor"];
    startupNotify=false;
    mimeType=[ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++"]; 
  };
  # home.packages = [ pkgs.atool pkgs.httpie ];
  # programs.bash.enable = true;
}
