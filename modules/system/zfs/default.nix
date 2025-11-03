{
  services.zfs = {
    autoSnapshot = {
      enable = true;
      frequent = 0;
      hourly = 0;
      daily = 7;
      weekly = 1;
      monthly = 0;
    };
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
    trim = {
      enable = true;
    };
  };
}
