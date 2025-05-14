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

      # Core Rust toolchain
      rustup
      rustc
      cargo
      gcc
      (rustPlatform.rustLibSrc) # Add the source component

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
