{config, ...}: {
  power.ups = {
    users."nut-admin".passwordFile = config.age.secrets.upsPassword.path;
    upsmon.monitor."UPS-1".passwordFile = config.age.secrets.upsPassword.path;
  };
}
