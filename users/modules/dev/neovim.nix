{ pkgs, ... }:

{
  imports = [
    ./langs/lua.nix
  ];

  home.packages = [ pkgs.neovim ];

  programs.neovim = {
    enable        = false;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;
  };

}
