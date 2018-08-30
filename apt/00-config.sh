# add apt update commands
if [ -n "$(which apt)" ]; then
    UPDATE_COMMANDS+=(
        "sudo apt -y update"
        "sudo apt -y upgrade"
        "sudo apt -y autoremove"
    )
fi
