{pkgs, ...}: {
  boot.kernel.sysctl = {
    "net.core.rmem_max" = 7500000;
    "net.core.wmem_max" = 7500000;
  };

  # Create a custom systemd service
  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate --config /home/cloudgenius/coursebook/cloudflared/config.yaml run backend";
      # ExecStop = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate --config /home/cloudgenius/coursebook/cloudflared/config.yaml cleanup backend";
      Restart = "always";
      RestartSec = 5;
      User = "cloudgenius"; # Use appropriate user
      Group = "users"; # Use appropriate group
    };
  };
}
# # Start the service
# sudo systemctl start cloudflared-tunnel
# # Enable it to start at boot
# sudo systemctl enable cloudflared-tunnel
# # Check status
# sudo systemctl status cloudflared-tunnel
# # View logs
# sudo journalctl -u cloudflared-tunnel
#
# # config.yaml
# # tunnel: backend
# tunnel: 563f6d5c-4867-404c-9293-506697172ed1
# credentials-file: /home/cloudgenius/coursebook/cloudflared/563f6d5c-4867-404c-9293-506697172ed1.json
# origincert: /home/cloudgenius/coursebook/cloudflared/cert.pem
# ingress:
#   - hostname: backend.cloudgenius.app
#     service: http://coursebook:3003
#   # - hostname: hls.cloudgenius.app
#   #   service: http://multistream:1935
#   - service: http_status:404

