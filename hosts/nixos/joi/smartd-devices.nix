{
  services.smartd = {
    devices = [
      # LONG tests
      {
        device = "/dev/sda";
        options = "-a -d removable -m root -n never -s L/../(01)/./(05)"; # at 5AM on day 1 of the month
      }
      {
        device = "/dev/sdb";
        options = "-a -d removable -m root -n never -s L/../(01)/./(05)"; # at 5AM on day 1 of the month
      }
      {
        device = "/dev/sdc";
        options = "-a -d removable -m root -n never -s L/../(01)/./(05)"; # at 5AM on day 1 of the month
      }
      {
        device = "/dev/sdd";
        options = "-a -d removable -m root -n never -s L/../(01)/./(05)"; # at 5AM on day 1 of the month
      }
      # SHORT tests
      {
        device = "/dev/nvme1n1";
        options = "-a -d nvme -d removable -m root -n never -s S/../../(7)/(00)"; # at 0AM on sunday
      }
      {
        device = "/dev/nvme1n2";
        options = "-a -d nvme -d removable -m root -n never -s S/../../(7)/(00)"; # at 0AM on sunday
      }
      {
        device = "/dev/sda";
        options = "-a -d removable -m root -n never -s S/../../(7)/(00)"; # at 0AM on sunday
      }
      {
        device = "/dev/sdb";
        options = "-a -d removable -m root -n never -s S/../../(7)/(00)"; # at 0AM on sunday
      }
      {
        device = "/dev/sdc";
        options = "-a -d removable -m root -n never -s S/../../(7)/(00)"; # at 0AM on sunday
      }
      {
        device = "/dev/sdd";
        options = "-a -d removable -m root -n never -s S/../../(7)/(00)"; # at 0AM on sunday
      }
    ];
  };
}
