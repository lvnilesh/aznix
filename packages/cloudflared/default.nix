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

