# add snap update commands
if [ -n "$(which snap)" ]; then
    UPDATE_COMMANDS+=(
        "sudo snap refresh"
    )
fi
