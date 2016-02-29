pr() {
    if [ -z "$1" ]; then
        echo 'Usage: pr <project name>'
        if [ -z "$PROJECTS" ]; then
            echo '$PROJECTS environment variable must be defined.'
        else
            echo "\$PROJECTS is set to '$PROJECTS'."
        fi
        return 1
    fi

    if [ -z "$PROJECTS" ]; then
        echo 'Error: $PROJECTS is not defined.'
        return 2
    fi

    if [ "$1" = "." ]; then
        cd "$DOTFILES"
        return 0
    elif [ -d "$PROJECTS/$1" ]; then
        cd "$PROJECTS/$1"
        return 0
    else
        echo "Error: project not found '$1'."
        return 3
    fi
}

__pr() {
    local ncur=$COMP_CWORD
    local cur=${COMP_WORDS[1]}
    if [ $ncur -eq 1 ]; then
        if [ -n "$PROJECTS" ]; then
            COMPREPLY=()
            if [ -z "$cur" ]; then
                COMPREPLY+=(".")
            fi
            for fn in $(basename -a $PROJECTS/$cur*); do
                if [ -d "$PROJECTS/$fn" ]; then
                    COMPREPLY+=("$fn")
                fi
            done
        fi
    fi
    return 0
}

# autocompletion for bash
complete -F __pr pr


__colors8() {
  local bold=
  local x
  for b in {40..47}; do
      for f in {30..37}; do
          x="0;$b;$f"
          printf "\e[%sm%s\e[0m " "$x" "$x"
      done
      printf "%7s " " "
      for f in {30..37}; do
          x="1;$b;$f"
          printf "\e[%sm%s\e[0m " "$x" "$x"
      done
      printf "\n"
  done
}

__colors16() {
  local bold=
  local x
  for l in {0..1}; do
      for b in {40..47} {100..107}; do
          for f in {30..37} {90..97}; do
              x="$(printf "%i;%03i;%02i" "$l" "$b" "$f")"
              printf "\e[%sm%s\e[0m " "$x" "$x"
          done
          printf "\n"
      done
      printf "\n"
  done
}

__colors256() {
    local x
    for i in {0..15}; do
        for j in {0..15}; do
            x=$(($i*16+$j))
            printf "\e[38;5;%im%03i\e[0m " "$x" "$x"
        done
        printf "%4s " " "
        for j in {0..15}; do
            x=$(($i*16+$j))
            printf "\e[30;48;5;%im%03i\e[0m " "$x" "$x"
        done
        printf "\n"
    done
    printf "\n"
    for i in {0..15}; do
        for j in {0..15}; do
            x=$(($i*16+$j))
            printf "\e[1;38;5;%im%03i\e[0m " "$x" "$x"
        done
        printf "\n"
    done
}

colors() {
    local arg="$1"
    if [ -z "$arg" ]; then
        arg="$TERM"
    fi
    case "$arg" in
        256|*-256col*)
            __colors256
            ;;
        16|*-16col*)
            __colors16
            ;;
        *)
            __colors8
            ;;
    esac
}
