```
git clone 
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
sudo nixos-rebuild switch --flake .#aznix



###

cd /home/cloudgenius/nixos-cloud-deploy




VM_NAME=aznix
VM_USERNAME=cloudgenius
LOCATION=westus
VM_KEYNAME=id_ed25519
GITHUB_KEYNAME=id_ed25519
SIZE=Standard_B4ms
MODE=nixos
IMAGE=Canonical:ubuntu-24_04-lts:server:latest # or ARM64: Canonical:ubuntu-24_04-lts:server-arm64:latest
NIX_CHANNEL=nixos-24.05
NIX_CONFIG_REPO=lvnilesh/nix-config

[ -z "$RESOURCE_GROUP_NAME" ] && RESOURCE_GROUP_NAME="$VM_NAME"

mkdir temp
tempnix=$PWD/temp
echo $tempnix
cp -r ./nix-config/az/* $tempnix

sed -e "s|#PLACEHOLDER_PUBKEY|$VM_PUB_KEY|" \
        -e "s|#PLACEHOLDER_USERNAME|"$VM_USERNAME"|" \
        -e "s|#PLACEHOLDER_HOSTNAME|"$VM_NAME"|" \
        ./nix-config/az/configuration.nix > $tempnix/configuration.nix


fqdn=$(az vm show --show-details -n "$VM_NAME" -g "$RESOURCE_GROUP_NAME" --query fqdns -o tsv | cut -d "," -f 1)

echo $fqdn

# echo "configuring root for seamless SSH access"
# ssh -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' "$VM_USERNAME"@"$fqdn" sudo cp /home/"$VM_USERNAME"/.ssh/authorized_keys /root/.ssh/authorized_keys

# echo "test SSH with root"
# ssh -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' root@"$fqdn" uname -a

# nix run github:nix-community/nixos-anywhere -- --flake $tempnix#aznix --generate-hardware-config nixos-facter $tempnix/facter.json root@"$fqdn"
```
