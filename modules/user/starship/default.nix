{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      directory.style = "bold blue";
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        style = "green";
      };
      git_metrics.disabled = false;
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        ahead = "⇡\($count\) ";
        diverged = "⇕⇡\($ahead_count\)⇣\($behind_count\) ";
        behind = "⇣\($count\) ";
        stashed = "*\($count\) ";
        conflicted = "~\($count\) ";
        modified = "!\($count\) ";
        staged = "+\($count\) ";
        untracked = "?\($count\) ";
        deleted = "✘\($count\) ";
        renamed = "»\($count\) ";
      };
      cmd_duration = {
        min_time = 2000;
        format = "[🕓 $duration]($style) ";
        style = "white";
      };
      gcloud = {
        format = "[$symbol$active]($style) ";
      };
    };
  };
}
