{
  # Enable the Azure Linux Agent
  services.waagent.enable = true;

  # Optional: Configure additional settings if needed
  services.waagent.settings = {
    # Example settings (customize as needed)
    Logs.Verbose = true; # Enable verbose logging
    ResourceDisk.Format = true; # Format and mount the resource disk
  };
}
