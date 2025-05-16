{
  config,
  pkgs,
  lib,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      dos2unix
      btop
      htop
      inetutils
      opentofu
      autojump
      coreutils
      pciutils
      usbutils
      dig
      ethtool
      python313Full
      eza
      alejandra
      unrar
      ffmpeg
      lsof
      jq
      fzf
      bash-completion

      # node lts/iron
      nodejs_20
      yarn
      pm2
      # cloudflared
      tldr

      # Core Rust toolchain
      rustup
      rustc
      cargo
      gcc
      (rustPlatform.rustLibSrc) # Add the source component

      mongosh

      # Essential development tools
      rustfmt # Code formatter
      clippy # Linter
      rust-analyzer # Language server for IDEs

      # gpg and tools
      gnupg
      pinentry # For passphrase entry dialogs
      pinentry-curses
      gpgme
      paperkey
      keybase
      pcsclite
      pcsctools
    ];
  };
}
