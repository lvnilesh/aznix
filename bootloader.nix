{ config, lib, pkgs, ... }:
{
  # Configure systemd-boot
  boot.loader = {
    # Disable GRUB completely
    grub.enable = lib.mkForce false;
    
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
  fileSystems."/boot".options = lib.mkDefault [ "umask=0077" ];
}
