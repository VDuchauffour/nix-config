{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "github";
      plugin = [
        "oh-my-opencode"
      ];
      mcp = {
      };
      permission = {
        edit = "allow";
        bash = "allow";
      };
      formatter = {
        ruff.disabled = false;
        uv.disabled = false;
      };
      keybinds = {
        "input_newline" = "shift+return,ctrl+return,alt+return,ctrl+j";
      };
    };
  };
}
