if [ "$COLORSUPPORT" -eq 1 ]; then
    for grpcmd in grep egrep fgrep zgrep zegrep zfgrep bzgrep bzegrep bzfgrep; do
        if [ -n "$(command -v $grpcmd)" ]; then
            eval "alias $grpcmd=\"$grpcmd --color=auto\""
            info "colors enabled for $grpcmd"
        fi
    done
fi
