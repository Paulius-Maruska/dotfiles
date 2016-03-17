tmuxls() {
    echo "Clients:"
    tmux list-clients

    echo "Sessions:"
    tmux list-sessions

    echo "Windows:"
    tmux list-windows

    echo "Panes:"
    tmux list-panes
}
