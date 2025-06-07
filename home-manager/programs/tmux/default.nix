{ pkgs, ... }:

{
  programs.tmux = {
    package = pkgs.tmux;
    enable = true;
    shell = "$SHELL";
    baseIndex = 1;
    keyMode = "vi";
    terminal = "tmux-256color";
    prefix = "C-a";
    focusEvents = true;

    extraConfig = ''
      ## TMUX config - these settings come from the example presented in the
      ## Pragmatic Programmer's tmux 2 book

      # set the delay between prefix and command
      set -s escape-time 1

      # splitting panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # New window
      bind c command-prompt -p "window name:" "new-window; rename-window '%%'"

      # moving between panes with Prefix h,j,k,l
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # quick window selection
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # mouse support - set to on if you want to use the mouse
      set -g mouse off

      # set the default terminal mode to 256 color mode, then enable TrueColor
      set -g default-terminal "tmux-256color"
      set-option -ga terminal-overrides ",*:RGB"

      # set colors for pane borders
      setw -g pane-border-style fg=green,bg=black
      setw -g pane-active-border-style fg=white,bg=yellow

      # active pane normal, others shaded out
      setw -g window-style fg=colour240,bg=colour235
      setw -g window-active-style fg=colour253,bg=color233

      # command/message line
      set -g message-style fg=white,bold,bg=black

      # enable activity alerts
      setw -g monitor-activity on
      set -g visual-activity on

      # Use vim keybindings in copy mode
      setw -g mode-keys vi

      bind Escape copy-mode
      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel
      unbind p
      bind p paste-buffer

      # Use powerline for the status line
      run-shell "powerline-daemon -q"
      run-shell "powerline-config tmux setup"

      # create a custom command killing direnv in case it hangs
      set -s command-alias[100] 'kill-direnv=run-shell "killall direnv"'

      # ensure we open new windows with default shell
      set -gu default-command
    '';
  };
}
