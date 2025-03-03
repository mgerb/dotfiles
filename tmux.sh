# Create a new tmux session with windows open in certain directories
tmux new -s mg -n home -d;
tmux send-keys -t mg "cd $HOME; clear" ENTER;

tmux new-window -n dotfiles -t mg;
tmux send-keys -t mg "cd $HOME/git/dotfiles; clear" ENTER;

