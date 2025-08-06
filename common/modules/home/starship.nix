{
  enable = true;
  enableZshIntegration = true;
  settings = {
    add_newline = false;
    # format = "$directory$git_branch$git_status$git_metrics$character";
    directory.style = "bold blue";
    git_branch = {
      format = "[$branch(:$remote_branch)]($style) ";
      style = "green";
    };
    git_metrics = {
      format = "(+$added($added_style) )(-$deleted($deleted_style) )";
    };
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "yellow";
    };
  };
}
