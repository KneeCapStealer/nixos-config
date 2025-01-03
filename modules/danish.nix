{ lib, ... }:

{
  # Set your time zone.
  time.timeZone = lib.mkDefault "Europe/Copenhagen";
  time.hardwareClockInLocalTime = lib.mkDefault true;

  # Select internationalisation properties.
  i18n.defaultLocale  = lib.mkDefault "en_DK.UTF-8";

  i18n.extraLocaleSettings = lib.mkDefault {
    LC_ADDRESS        = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT    = "da_DK.UTF-8";
    LC_MONETARY       = "da_DK.UTF-8";
    LC_NAME           = "da_DK.UTF-8";
    LC_NUMERIC        = "da_DK.UTF-8";
    LC_PAPER          = "da_DK.UTF-8";
    LC_TELEPHONE      = "da_DK.UTF-8";
    LC_TIME           = "da_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = lib.mkDefault {
    layout = "dk";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = lib.mkDefault "dk-latin1";
}
