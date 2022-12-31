#!/usr/bin/sh

mappings_file='lua/filetype/mappings.lua'
[ ! -d "$(dirname "$mappings_file")" ] && mkdir -pv "$(dirname "$mappings_file")"

script_path=$(dirname "$(readlink -f "$0")")
output="$("$script_path/generate.lua" | stylua -f stylua.toml --column-width 500 -)"

# fix mapping output
output="$(printf '%s\n' "$output" | sed -E -e 's/\t\{ /\t[/' -e 's/(]=*])? },$/,/' -e "s/(\t\['.*'), (\[=*\[)?/\1] = /")"

printf '%s' "$output" > "$mappings_file"
