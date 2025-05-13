#!/usr/bin/env bash
set -e

echo "Updating hardware configuration..."
sudo nixos-generate-config --show-hardware-config > ~/aznix/hardware-configuration.nix
echo "Hardware configuration updated."

echo "Forcibly installing systemd-boot...the operation to find bootctl in nix store takes some time"
sudo "$(find /nix/store -name bootctl | head -1)" install --path=/boot

echo "Rebuilding NixOS..."
sudo nixos-rebuild switch --flake ~/aznix#aznix "$@"
# sudo nixos-rebuild switch --flake github:lvnilesh/aznix#aznix "$@"
