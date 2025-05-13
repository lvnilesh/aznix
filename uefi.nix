{ config, lib, pkgs, ... }:

{
  boot.loader = {
    # Choose one of these two options:
    
    # Option 1: systemd-boot (simpler, recommended for single-boot systems)
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
    
    # Option 2: GRUB with EFI support (better for dual-boot systems)
    # If you want this instead of systemd-boot, comment out the systemd-boot section above
    # and uncomment this section:
    # grub = {
    #   enable = true;
    #   efiSupport = true;
    #   device = "nodev";  # Important for EFI installations
    #   useOSProber = true;
    # };
    
    # EFI settings - these work with either boot loader
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}