{
  config,
  pkgs,
  ...
}: {
  # Enable MongoDB service
  services.mongodb = {
    enable = true;
    bind_ip = "0.0.0.0"; # Or whatever IP you want to use
    enableAuth = true;
    # dbpath = "/var/db/mongodb"; # Default path for MongoDB data in nixos
    initialRootPasswordFile = "${pkgs.writeText "mongopasswordfile" "123"}";
    package = pkgs.mongodb; # Or specify a specific version if needed
    extraConfig = ''
      # net:
      #   tls:
      #     mode: requireTLS
      #     certificateKeyFile: /var/db/mongodb/mongodb.pem
      #     CAFile: /var/db/mongodb/ca.pem
      #     allowConnectionsWithoutCertificates: false
      #     disabledProtocols: TLS1_0,TLS1_1
    '';
  };

  # Create the data directory with proper permissions
  systemd.services.mongodb.serviceConfig = {
    # Add any additional service configurations if needed
  };

  # Open firewall port if necessary (only if you need remote connections)
  # networking.firewall.allowedTCPPorts = [ 27017 ];
}
#
#
# mongosh --host localhost --port 27017 --authenticationDatabase admin -u root -p 123
# cd packages/mongo
# ./setup_mongo_user.sh
# cd ../..
# mongosh --host localhost --port 27017 --authenticationDatabase admin -u nilesh -p thatrandompassword
#
#
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

