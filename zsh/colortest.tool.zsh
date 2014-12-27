#!/bin/zsh
# outputs all of the colors and a description on how to use those colors.

_print_color () {
    local num=$1 name_normal=$2 name_light=$3

    local code_normal="\033[0;${num}m" code_light="\033[1;${num}m"

    printf "%4i:\t$code_normal%-12s\t$code_light%-12s\033[0m\n" $num "$name_normal" "$name_light"
}

printf "Color Table\n"
printf "%4s \t%-12s\t%-12s\n" '' "Normal (0;xx)" "Light (1;xx)"
_print_color 30 "Black" "Dark Gray"
_print_color 31 "Red" "Light Red"
_print_color 32 "Green" "Light Green"
_print_color 33 "Brown" "Yellow"
_print_color 34 "Blue" "Light Blue"
_print_color 35 "Purple" "Light Purple"
_print_color 36 "Cyan" "Light Cyan"
_print_color 37 "Light Gray" "White"
printf "Note: the actual colors you see may differ from the titles based on your configuration.\nMost modern terminal apps allow you to change these 16 colors anyway you want (which is\nwhy this function is useful).\n"
printf "\nColor Usage\n"
printf "  \\\\033[<color code>m - to set active foreground color to the specified color code\n"
printf "  \\\\033[0m - reset active foreground color to the default\n"
printf "When color codes are specified inside a string, and you want to use printf to output\nthe string - do not forget to use %%b format specifier instead of %%s.\n"
