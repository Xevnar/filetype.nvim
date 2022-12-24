#!/usr/bin/sh

script_path=$(dirname "$(readlink -f "$0")")
output="$("$script_path/generate.lua" | stylua -f stylua.toml --column-width 500 -)"

# fix mapping output
printf '%s\n' "$output" | sed -E -e 's/\t\{ /\t[/' -e 's/(]=*])? },$/,/' -e "s/(\t\['.*'), (\[=*\[)?/\1] = /"
