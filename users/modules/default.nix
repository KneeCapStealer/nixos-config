{
  imports = [
    ./desktop/hyprland.nix
    ./games.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
