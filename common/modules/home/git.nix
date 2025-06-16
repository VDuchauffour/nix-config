{ pkgs, ... }: {
  enable = true;
  userName = "Vincent Duchauffour";
  userEmail = "vincent.duchauffour@proton.me";
  extraConfig = {
    init = {
      defaultBranch = "main";
    };
    pull = {
      rebase = true;
    };
    push = {
      autoSetupRemote = true;
    };
    fetch = {
      prune = true;
    };
    credential = {
      "https://github.com" = {
        helper = "!/usr/bin/gh auth git-credential";
      };
    };
    advice = {
      addIgnoredFile = false;
      mergeConflict = false;
    };
    core = {
      pager = "delta";
    };
    interactive = {
      diffFilter = "delta --color-only";
    };
    delta = {
      navigate = true;
      light = false;
      lineNumbers = true;
      sideBySide = false;
      syntaxTheme = "DarkNeon";
      hyperlinks = true;
      hyperlinksFileLinkFormat = "vscode://file/{path}:{line}";
    };
    merge = {
      conflictstyle = "diff3";
    };
    diff = {
      colorMoved = "default";
    };
    filter = {
      lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
      };
    };
    alias = {
      tree = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(italic dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      branches = "branch -a --sort=-committerdate --format='%(HEAD) %(color:bold blue)%(refname:short)%(color:reset) - %(color:bold green)%(committerdate:short)%(color:reset) %(color:white)%(contents:subject)%(color:reset) %(color:italic dim white)- %(authorname)%(color:reset)'";
      delete-merged-remote-branches = "!gi() { git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D ;}; gi || true";
      pull-and-clean = "!git pull && git delete-merged-remote-branches";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      diff-ignore-space = "diff --ignore-space-change";
    };
    includeIf = {
      "gitdir:~/work/" = {
        path = "~/work/.gitconfig";
      };
    };
  };
}
