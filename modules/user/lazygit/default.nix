{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = {
          pager = "delta --paging=never --color-only --syntax-theme DarkNeon --hyperlinks --line-numbers --side-by-side";
        };
      };
    };
  };
}
