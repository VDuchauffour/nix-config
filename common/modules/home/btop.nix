{ pkgs, ... }: {
  enable = true;
  settings = {
    presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
    update_ms = 1000;
  };
}
