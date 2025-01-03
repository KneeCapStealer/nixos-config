{ pkgs, inputs, ... }:

let
  defaultCatppuccin = (import ../modules/looks/catppuccin.nix).catppuccin;
in
{
  imports = [
    ./modules/default.nix
    ./modules/dev/default.nix
  ];

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  catppuccin = defaultCatppuccin // {
    pointerCursor.enable = true;
  };

  home.packages = with pkgs; [
    activate-linux
    fastfetch
    vesktop
    btop
    spotify
    inputs.zen-browser.packages."${system}".specific
    tor-browser
    qbittorrent-enhanced
    proton-pass
    dolphin
    haruna
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
  };
}
