{ pkgs, ... }: {
  enable = true;
  settings = {
    general = {
      live_config_reload = true;
    };

    window = {
      dynamic_padding = true;
      padding = {
        x = 0;
        y = 0;
      };
      dimensions = {
        columns = 0;
        lines = 0;
      };
    };

    selection = {
      save_to_clipboard = true;
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
    };

    scrolling = {
      history = 10000;
    };

    font = {
      size = 12;
      offset = {
        x = 0;
        y = 0;
      };
      normal = {
        family = "MesloLGS NF";
        style = "Regular";
      };
      bold = {
        family = "MesloLGS NF";
        style = "Bold";
      };
      italic = {
        family = "MesloLGS NF";
        style = "Italic";
      };
      bold_italic = {
        family = "MesloLGS NF";
        style = "Bold Italic";
      };
    };

    cursor = {
      style = "Block";
      blinking = "Always";
    };

    env = {
      TERM = "alacritty";
    };
  };
}
