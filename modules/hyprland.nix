{ inputs,  pkgs, ... }:

{
  imports = [
    ./nvidia.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    withUWSM = true;
  };

  programs.hyprlock.enable = true;

  # Xorg setup
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    sddm = {
      enable      = true;
      autoNumlock = true;
      package     = pkgs.kdePackages.sddm;

      wayland.enable = true;
      wayland.compositor = "weston";
    };
  };

  # Make Hyprland cache properly when using flakes
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Hyprland rice packages
  environment.systemPackages = with pkgs; [
    pwvucontrol
    swww
    eww
    nwg-look
    swaynotificationcenter
    libnotify
    rofi-calc
    rofi-wayland
    clipboard-jh
    wl-clipboard
    hyprshot
  ];
}
