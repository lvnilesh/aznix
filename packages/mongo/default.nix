{
  config,
  pkgs,
  ...
}: {
  # Enable MongoDB service
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb; # Or specify a specific version if needed
  };

  # Create the data directory with proper permissions
  systemd.services.mongodb.serviceConfig = {
    # Add any additional service configurations if needed
  };

  # Open firewall port if necessary (only if you need remote connections)
  # networking.firewall.allowedTCPPorts = [ 27017 ];
}
# ls -la /nix/store/*mongodb.conf
# net.bindIp: 127.0.0.1
# systemLog.destination: syslog
# storage.dbPath: /var/db/mongodb
# # Start the service
# sudo systemctl start mongodb
# # Enable it to start at boot
# sudo systemctl enable mongodb
# # Check status
# sudo systemctl status mongodb
# # View logs
# sudo journalctl -u mongodb

