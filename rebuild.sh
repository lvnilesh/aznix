#!/usr/bin/env bash
set -e

echo "Updating hardware configuration..."
sudo nixos-generate-config --show-hardware-config > ~/aznix/hardware-configuration.nix
echo "Hardware configuration updated."

echo "Finding bootctl binary...the operation to find bootctl in nix store takes some time"
# sudo "$(find /nix/store -name bootctl | head -1)" install --path=/boot

# Find the bootctl binary, not the bash completion file
BOOTCTL=$(find /nix/store -path "*/bin/bootctl" | head -1)
if [ -z "$BOOTCTL" ]; then
  echo "ERROR: bootctl binary not found!"
  exit 1
fi

echo "Found bootctl at: $BOOTCTL"
echo "Forcibly installing systemd-boot..."
sudo "$BOOTCTL" install --path=/boot

echo "Rebuilding NixOS..."
sudo nixos-rebuild switch --flake ~/aznix#aznix "$@"
# sudo nixos-rebuild switch --flake github:lvnilesh/aznix#aznix "$@"
