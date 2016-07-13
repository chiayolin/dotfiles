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

# rename the terminals
set -g set-titles on
set -g set-titles-string '#(whoami)::#h::#(curl ipecho.net/plain;echo)'

# status bar customization
 set -g status-utf8 on
 set -g status-bg black
 set -g status-fg white
 set -g status-interval 5
 set -g status-left-length 90
 set -g status-right-length 60
 set -g status-left "#[fg=Green]#(whoami)#[fg=white]::#[fg=blue] \
  (hostname - s)#[fg=white]::##[fg=yellow]#(curl ipecho.net/plain;echo)"
 set -g status-justify left
 set -g status-right '#[fg=Cyan]#S #[fg=white]%a %d %b %R'

 # remap window navigation to mimic vim
 unbind-key j
 bind-key j select-pane -D
 unbind-key k
 bind-key k select-pane -U
 unbind-key h
 bind-key h select-pane -L
 unbind-key l
 bind-key l select-pane -R
