{
  services.zfs = {
    autoSnapshot = {
      enable = true;
      frequent = 0;
      hourly = 4;
      daily = 7;
      weekly = 1;
      monthly = 1;
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
