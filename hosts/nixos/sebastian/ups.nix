{config, ...}: {
  power.ups = {
    users."nut-admin".passwordFile = config.age.secrets.upsPassword.file;
    upsmon.monitor."UPS-1".passwordFile = config.age.secrets.upsPassword.file;
  };
}
