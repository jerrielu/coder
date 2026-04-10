#!/usr/bin/env bash

set -euo pipefail

REPO_OWNER="${REPO_OWNER:-jerrielu}"
REPO_NAME="${REPO_NAME:-coder}"
REPO_REF="${REPO_REF:-main}"
RAW_BASE_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_REF}"

tmp_coder="$(mktemp)"

cleanup() {
  rm -f "$tmp_coder"
}
trap cleanup EXIT

download_coder() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${RAW_BASE_URL}/coder" -o "$tmp_coder"
    return 0
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "$tmp_coder" "${RAW_BASE_URL}/coder"
    return 0
  fi

  printf 'error: curl or wget is required to install coder\n' >&2
  return 1
}

detect_reload_file() {
  case "${SHELL:-}" in
    */zsh) printf '%s' "$HOME/.zshrc" ;;
    *) printf '%s' "$HOME/.bashrc" ;;
  esac
}

download_coder
chmod +x "$tmp_coder"
"$tmp_coder" --install

reload_file="$(detect_reload_file)"
printf '\nInstalled.\n'
printf 'Run this to reload your shell now:\n'
printf '  source "%s"\n' "$reload_file"
printf 'Then run:\n'
printf '  coder\n'
