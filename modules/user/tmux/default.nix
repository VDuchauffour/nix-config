{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    baseIndex = 1;
    terminal = "xterm-256color";
    mouse = true;
    historyLimit = 10000;
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.better-mouse-mode
    ];
    extraConfig = ''
      set -g allow-rename on
      set -g automatic-rename on
      set -g set-clipboard on
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-style bg=default

      # VIM mode
      set-window-option -g mode-keys vi
      # Setup 'v' to begin selection, just like Vim
      bind-key -T copy-mode-vi v send-keys -X begin-selection

      if-shell -b 'echo $XDG_SESSION_TYPE | grep -q x11' "\
          bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard > /dev/null'; \
          bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard > /dev/null'; \
          bind-key C-p run 'xclip -out -selection clipboard | tmux load-buffer - ; tmux paste-buffer'"

      if-shell -b 'echo $XDG_SESSION_TYPE | grep -q wayland' "\
          bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel 'wl-copy'; \
          bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'wl-copy'; \
          bind-key C-p run 'wl-paste --no-newline | tmux load-buffer - ; tmux paste-buffer'" "\
          \
          bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel 'cat - >/dev/clipboard'; \
          bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'cat - >/dev/clipboard'; \
          bind-key C-p run 'cat /dev/clipboard | tmux load-buffer - ; tmux paste-buffer'"

      # notifications
      set -g monitor-activity off
      setw -g monitor-activity off
      set -g visual-activity off
      set -g visual-silence off
      set -g visual-bell off
      set -g bell-action none

      # panes
      set -g pane-border-style fg='#44475a',bg=default
      set -g pane-active-border-style fg='#bd93f9',bg=default

      # status Bar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style fg='#f8f8f2',bg=default,dim
      set -g status-left ' '
      set -g status-right '#[bold] %a %d %b at %H:%M '
      set -g status-right-length 50
      set -g status-left-length 20

      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{?#{==:#{pane_current_command},nvim},nvim #{b:pane_current_path},#{b:pane_current_command}}'

      setw -g window-status-style fg='#f8f8f2',bg=default
      setw -g window-status-current-style fg='#f8f8f2',bg=default,bold
      setw -g window-status-format ' #I:#{?pane_title,#{=25:pane_title}#{?#{>:#{len:pane_title},25},…,},#{pane_current_command}} '
      setw -g window-status-current-format ' #I:#{?pane_title,#{=25:pane_title}#{?#{>:#{len:pane_title},25},…,},#{pane_current_command}} '
      setw -g window-status-bell-style fg='#f8f8f2',bg=default,bold

      # messages
      set -g message-style fg='#f8f8f2',bg=default,bold

      set -sg escape-time 0

      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
    '';
  };
}
