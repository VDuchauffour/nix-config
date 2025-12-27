{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "github";
      mcp = {
      };
      formatter = {
        ruff.disabled = false;
        uv.disabled = false;
      };
    };
  };
}
