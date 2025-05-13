{ config, lib, pkgs, ... }: {
  # Clear any conflicting boot loader settings
  boot.loader.grub.enable = lib.mkForce false;
  
  # Configure systemd-boot
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
  
  # Fix permissions on /boot to address the warnings
  fileSystems."/boot".options = [ "umask=0077" ];
}