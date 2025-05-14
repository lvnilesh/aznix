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
  # for global user
  users.defaultUserShell = pkgs.zsh;

  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      pubkey
    ];
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "input"
    ];
  };
  programs.zsh.enable = true;
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
