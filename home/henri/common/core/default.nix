{ pkgs, ... }: {

  home = {
    username = "henri";
    homeDirectory = "/home/henri";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.desktopEntries.nvim = {
    name = "WrappedNeovim";
    exec = "alacritty -e nvim %F";
    terminal = false;
    type = "Application";
    icon = "nvim";
    categories = [ "Utility" "TextEditor" ];
    startupNotify = false;
    mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" ];
  };
  programs.nushell.enable = true;
}
