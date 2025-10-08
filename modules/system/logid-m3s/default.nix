{pkgs, ...}: {
  environment.systemPackages = [pkgs.logiops];
  systemd.services.logiops = {
    description = "An unofficial userspace driver for HID++ Logitech devices";
    startLimitIntervalSec = 0;
    after = ["graphical.target"];
    wantedBy = ["graphical.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops}/bin/logid";
      User = "root";
    };
  };
  # Add a `udev` rule to restart `logiops` when the mouse is connected
  # https://github.com/PixlOne/logiops/issues/239#issuecomment-1044122412
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{manufacturer}=="Logitech", ATTRS{model_name}=="Wireless Mouse MX Master 3", RUN{program}="${pkgs.systemd}/bin/systemctl --no-block try-restart logiops.service"
  '';

  environment.etc."logid.cfg".source = ./logid.cfg;
}
