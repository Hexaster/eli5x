#!/usr/bin/env bash
set -eu
root=$(cd -- "$(dirname -- "$0")" && pwd -P)
source_dir="$root/skills/five-levels"
targets=("$HOME/.claude/skills" "${CODEX_HOME:-$HOME/.codex}/skills" "${HERMES_HOME:-$HOME/.hermes}/skills")
for dir in "${targets[@]}"; do
  path="$dir/five-levels"
  if [[ -e "$path" || -L "$path" ]]; then
    [[ "$path" -ef "$source_dir" ]] || { echo "Existing installation at $path. Move it aside first." >&2; exit 1; }
  fi
done
for dir in "${targets[@]}"; do
  mkdir -p "$dir"
  [[ "$dir/five-levels" -ef "$source_dir" ]] || ln -s "$source_dir" "$dir/five-levels"
done
