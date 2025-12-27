{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "github";
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
    };
  };
}
