#!/usr/bin/env bash
set -eu
root=$(cd -- "$(dirname -- "$0")" && pwd -P)
source_dir="$root/skills/eli5x"
targets=("$HOME/.claude/skills" "${CODEX_HOME:-$HOME/.codex}/skills" "${HERMES_HOME:-$HOME/.hermes}/skills")
for dir in "${targets[@]}"; do
  path="$dir/eli5x"
  if [[ -e "$path" || -L "$path" ]]; then
    [[ "$path" -ef "$source_dir" ]] || { echo "Existing installation at $path. Move it aside first." >&2; exit 1; }
  fi
done
for dir in "${targets[@]}"; do
  mkdir -p "$dir"
  [[ "$dir/eli5x" -ef "$source_dir" ]] || ln -s "$source_dir" "$dir/eli5x"
done
