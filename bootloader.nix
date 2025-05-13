{ config, lib, pkgs, ... }: {
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
  
  # This is the fix - need to run this one time in Azure
  # sudo $(find /nix/store -name bootctl | head -1) install --path=/boot

  # The below activation script forcibly install systemd-boot
  system.activationScripts.installBootLoader = {
    deps = [];
    text = ''
      echo "Forcibly installing systemd-boot to ESP..."
      ${pkgs.systemd}/bin/bootctl install --path=/boot
    '';
  };
  
  # Fix permissions on /boot to address the warnings
  fileSystems."/boot".options = lib.mkDefault [ "umask=0077" ];
}