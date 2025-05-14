{
  modulesPath,
  lib,
  pkgs,
  ...
}: let
  username = "cloudgenius";
  hostname = "aznix";
  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWM/PQ1EF0spec86grdfOaT0/G92oV2KxPHPSe4fTp7";
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./packages
  ];

  #  boot.loader.grub = {
  # #    devices = [ "/dev/disk/by-uuid/8973-FC44" ];
  #    efiSupport = true;
  #    efiInstallAsRemovable = true;
  #  };

  networking.hostName = hostname;

  services.openssh = {
    enable = lib.mkForce true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    curl
    dos2unix
    git
    vim
    htop
    btop
    iperf3
  ];

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "";
    openssh.authorizedKeys.keys = [
      pubkey
    ];
    extraGroups = ["wheel"];
  };

  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  system.stateVersion = "24.05";
}
