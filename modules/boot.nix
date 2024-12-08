{ pkgs, ... }:
{
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
}
