{ config, lib, pkgs, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    
    # Use GRUB but with EFI support
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";  # Important for EFI - don't install to a specific device
      useOSProber = true;
    };
  };
}