if [ "$COLORSUPPORT" -eq 1 ]; then
    for grpp in _ z bz; do
        for grpt in grep egrep fgrep rgrep; do
            _grpcmd="$grpp$grpt"
            _grpcmd="${_grpcmd#_}"
            if [ -n "$(command -v $_grpcmd)" ]; then
                eval "alias $_grpcmd='$_grpcmd --color=auto'"
            fi
        done
    done
fi
