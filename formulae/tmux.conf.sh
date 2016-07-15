# tmux.conf.sh - ~/.tmux.conf
#
# ctrl-b reference
#   basics
#     ?        help
#
#   session management
#     s        list sessions
#     $        rename the current session
#     d        detach from the current session
#
#   windows
#     c        create a new window
#     ,        rename the current window
#     w        list windows
#     %        split horizontally
#     "        split vertically
#     n        change to the next window
#     p        change to the previous window
#     0 to 9   select windows 0 through 9
#
#   panes
#     %        create a horizontal pane
#     "        create a vertical pane
#     h        move to the left pane. *
#     j        move to the pane below *
#     l        move to the right pane *
#     k        move to the pane above *
#     k        move to the pane above *
#     q        show pane numbers
#     o        toggle between panes
#     }        swap with next pane
#     {        swap with previous pane
#     !        break the pane out of the window
#     x        kill the current pane
#
#   misc
#     t        show the time in current pane

# a 'ctl-b' for reloading tmux config on the fly 
bind r source-file ~/.tmux.conf

# turn off terminal title
set -g set-titles off

# status bar
set-window-option -g status-left ""
set-window-option -g status-left-fg black
set-window-option -g status-left-bg white

set-window-option -g status-right "\ #(whoami)[#S] %b-%d %l:%M %p\ "
set-window-option -g status-right-fg black
set-window-option -g status-right-bg white

set-window-option -g window-status-format "#I:#W"

set-window-option -g window-status-current-format "[#I:#W]"
set-window-option -g window-status-current-fg green
set-window-option -g window-status-current-bg black

# remap window navigation to mimic vim
unbind-key j
bind-key j select-pane -D
unbind-key k
bind-key k select-pane -U
unbind-key h
bind-key h select-pane -L
unbind-key l
bind-key l select-pane -R
