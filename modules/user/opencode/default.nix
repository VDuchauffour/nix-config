{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "github";
      plugin = [
        "oh-my-opencode"
        "@slkiser/opencode-quota"
        "@simonwjackson/opencode-direnv"
        "opencode-scheduler"
      ];
      mcp = {
        browsermcp = {
          enabled = true;
          command = "npx";
          args = ["@browsermcp/mcp@latest"];
        };
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
