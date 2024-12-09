# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./modules/hyprland.nix
      ./modules/sound.nix
      ./modules/networking.nix
      ./modules/danish.nix
      ./modules/dev/default.nix
      ./modules/looks/catppuccin.nix
      ./modules/boot.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade = {
    enable = true;
    dates = "daily";

    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
  };

  services.protonvpn = {
    enable = true;

    interface = {
      name = "nixos-denmark";
      privateKeyFile = "/root/secrets/nixos-denmark-privatekey";
      dns.enable = true;
    };
    endpoint = {
      publicKey = "+6VseaiwdWLFSlaTgwafQM9D9DsT1aanqywtgf7XdC8=";
      ip = "185.111.109.1";
    };
  };

  # steam
  programs.steam = {
    enable = true;

    # Ports for online gaming
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Nintendo pro controller
  services.joycond.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.etc."current-system-packages".text =
  let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;

  fileSystems = let
    compress   = "compress=zstd";
    nocompress = "compress=no";
    nocow      = "nodatacow";

    default    = [ compress ];
    in {
      "/".options          = default;
      "/home".options      = default;
      "/nix".options       = default;
      "/tmp".options       = default;
      "/var/log".options   = default;
      "/var/cache".options = default;
      "/games".options     = [ nocompress nocow ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = {
    isNormalUser = true;
    description = "Christoffer Hald Christensen";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "usb" "input" "disk" "wwwrun" ];
    shell = pkgs.zsh;
    homeMode = "0755"; # Search perms for apache servers
  };

  programs.zsh.enable = true;

  fonts.packages =
    let
      # There is a function among us
      pathsInSet = set: builtins.filter builtins.isPath (builtins.attrValues set);
    in [ pkgs.noto-fonts-extra ]
    ++ pathsInSet pkgs.nerd-fonts;

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    cache32Bit = true;
    defaultFonts.monospace = [ "jetbrains mono" ];
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    ZDOTDIR         = "$HOME/.config/zsh";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zstd
    zsh
    wget
    curl
    unzip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

