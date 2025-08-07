{
  enable = true;
  enableZshIntegration = true;
  settings = {
    add_newline = true;
    directory.style = "bold blue";
    git_branch = {
      format = "[$branch(:$remote_branch)]($style) ";
      style = "green";
    };
    git_status = {
      # format = "(\[$all_status[$ahead_behind]\]($style) )";
      modified = "!\($count\)";
      staged = "+\($count\)";
      untracked = "?\($count\)";
      ahead = "⇡\($count\)";
      diverged = "⇕⇡\($ahead_count\)⇣\($behind_count\)";
      behind = "⇣\($count\)";
    };
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "yellow";
    };
  };
}
