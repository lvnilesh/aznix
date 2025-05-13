{ config, lib, pkgs, ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 20;  # Limit the number of generations shown in the boot menu
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";  # This should match your EFI system partition mount point
    };
    # Explicitly disable GRUB
    grub.enable = false;
  };
}