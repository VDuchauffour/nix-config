{pkgs, ...}: {
  programs.gh = {
    enable = true;
  };
  programs.gh-dash = {
    enable = true;
  };
  # run gh extension install dlvhdr/gh-enhance
  # see https://www.gh-dash.dev/companions/enhance/getting-started/
}
