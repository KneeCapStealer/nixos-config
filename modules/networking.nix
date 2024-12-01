{
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hosts = {
    "127.0.0.1" = [ "local.partytrackr.com" ];
  };
}
