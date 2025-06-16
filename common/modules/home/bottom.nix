{ pkgs, ... }: {
  enable = true;
  settings = {
    flags = {
      hide_avg_cpu = true;
      rate = 500;
    };
    color = "nord";
    rows = [
      {
        ratio = 40;
        child = [
          {
            type = "cpu";
          }
        ];
      }
      {
        ratio = 30;
        child = [
          {
            type = "mem";
          }
          {
            type = "net";
          }
        ];
      }
      {
        ratio = 30;
        child = [
          {
            type = "temp";
          }
          {
            type = "disk";
          }
        ];
      }
    ];
  };
}
