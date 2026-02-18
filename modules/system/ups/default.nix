{
  lib,
  config,
  pkgs,
  ...
}: {
  power.ups = {
    enable = true;
    mode = "standalone";
    ups."UPS-1" = {
      description = "Eaton Ellipse ECO 650 with 12V 7Ah lead-acid Batt";
      driver = "usbhid-ups";
      port = "auto";
      directives = [
        "offdelay = 60"
        "ondelay = 70"
        "lowbatt = 40"
        "ignorelb"
      ];
    };
    upsd = {
      listen = [
        {
          address = "0.0.0.0";
          port = 3493;
        }
        {
          address = "::";
          port = 3493;
        }
      ];
    };
    users."nut-admin" = {
      passwordFile = lib.mkDefault "";
      upsmon = "primary";
    };
    upsmon = {
      monitor."UPS-1" = {
        system = "UPS-1@localhost";
        powerValue = 1;
        user = "nut-admin";
        passwordFile = lib.mkDefault "";
        type = "primary";
      };
      settings = {
        NOTIFYMSG = [
          ["ONLINE" ''"UPS %s: On line power."'']
          ["ONBATT" ''"UPS %s: On battery."'']
          ["LOWBATT" ''"UPS %s: Battery is low."'']
          ["REPLBATT" ''"UPS %s: Battery needs to be replaced."'']
          ["FSD" ''"UPS %s: Forced shutdown in progress."'']
          ["SHUTDOWN" ''"Auto logout and shutdown proceeding."'']
          ["COMMOK" ''"UPS %s: Communications (re-)established."'']
          ["COMMBAD" ''"UPS %s: Communications lost."'']
          ["NOCOMM" ''"UPS %s: Not available."'']
          ["NOPARENT" ''"upsmon parent dead, shutdown impossible."'']
        ];
        NOTIFYFLAG = [
          ["ONLINE" "SYSLOG+WALL"]
          ["ONBATT" "SYSLOG+WALL"]
          ["LOWBATT" "SYSLOG+WALL"]
          ["REPLBATT" "SYSLOG+WALL"]
          ["FSD" "SYSLOG+WALL"]
          ["SHUTDOWN" "SYSLOG+WALL"]
          ["COMMOK" "SYSLOG+WALL"]
          ["COMMBAD" "SYSLOG+WALL"]
          ["NOCOMM" "SYSLOG+WALL"]
          ["NOPARENT" "SYSLOG+WALL"]
        ];
        RBWARNTIME = 216000;
        NOCOMMWARNTIME = 300;
        FINALDELAY = 0;
      };
    };
  };
  systemd.services.nut-delayed-ups-shutdown = {
    enable = true;
    environment = config.systemd.services.upsmon.environment;
    description = "Initiate delayed UPS shutdown";
    before = ["umount.target"];
    wantedBy = ["final.target"];
    serviceConfig = {
      Type = "oneshot";
      # need to use '-u root', or else permission denied
      ExecStart = ''${pkgs.nut}/bin/upsdrvctl -u root shutdown'';
      # must not use slice: if used, upsdrvctl will not run as a late
      # shutdown service
      # Slice = "";
    };
    unitConfig = {
      ConditionPathExists = config.power.ups.upsmon.settings.POWERDOWNFLAG;
      DefaultDependencies = "no";
    };
  };
}
