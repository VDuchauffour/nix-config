{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "xterm-256color";
    mouse = true;
    historyLimit = 10000;
    plugins = [
      pkgs.tmuxPlugins.sensible
    ];
    extraConfig = ''
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-style bg=default

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

      setw -g window-status-current-style fg='#f8f8f2',bg=default,bold
      setw -g window-status-current-format ' #I#[fg=fg]:#[fg=colour255]#W#[fg=fg]#F '

      setw -g window-status-style fg='#f8f8f2',bg=default
      setw -g window-status-format '#I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F'

      setw -g window-status-bell-style fg='#f8f8f2',bg=default,bold

      # messages
      set -g message-style fg='#f8f8f2',bg=default,bold

      set -sg escape-time 0

      # keybindings
      # bind -n M-w confirm-before -p "kill-pane #P? (y/n)" kill-pane
      # bind -n M-t new-window
      # bind -n M-W confirm-before -p "kill-window #W? (y/n)" kill-window
      # bind -n M-H previous-window
      # bind -n M-L next-window
      # bind -n M-D split-window -h
      # bind -n M-d split-window -v
      # bind -n M-h select-pane -L
      # bind -n M-l select-pane -R
      # bind -n M-k select-pane -U
      # bind -n M-j select-pane -D
      # bind -n M-C-h resize-pane -L 5
      # bind -n M-C-j resize-pane -D 5
      # bind -n M-C-k resize-pane -U 5
      # bind -n M-C-l resize-pane -R 5
    '';
  };
}
