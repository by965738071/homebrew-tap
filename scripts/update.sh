#!/usr/bin/env bash
#
# Rewrites the zig-dev / zls-dev formulae with the latest upstream
# version and shasums, then commits any change.
#
# Data sources (the same ones the scoop manifests use):
#   zig: https://ziglang.org/download/index.json            (.master)
#   zls: https://releases.zigtools.org/v1/zls/select-version
#
# usage: update.sh [zig-dev] [zls-dev]   (default: nothing)

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

zig_file="Formula/z/zig-dev.rb"
zls_file="Formula/z/zls-dev.rb"

zig_index_url="https://ziglang.org/download/index.json"
zls_select_url="https://releases.zigtools.org/v1/zls/select-version"

# every formula carries one `sha256 "..." # <target>` line per target;
# add a target here and add the matching sha256 line to the formula
targets=(x86_64-macos aarch64-macos x86_64-linux aarch64-linux)

update_zig=0
update_zls=0
for arg; do
  case "$arg" in
    zig-dev) update_zig=1 ;;
    zls-dev) update_zls=1 ;;
    *) echo "usage: ${0##*/} [zig-dev] [zls-dev]" >&2; exit 2 ;;
  esac
done

fetch() {
  curl --fail --location --show-error --silent \
    --retry 3 --retry-all-errors --max-time 60 "$@"
}

# rewrite_file <file> <formula-name> <json>
# <json> must have .version and .[<target>].shasum
rewrite_file() {
  local file=$1 name=$2 json=$3
  local version target shasum
  local -a exprs=()

  version=$(jq -er '.version' <<<"$json")

  # url "…/<name>-<version>.tar.xz" — the version is the only dash group
  # in the url that starts with a digit, so `-[0-9]` anchors on it while
  # leaving the literal `#{arch}-#{os}` interpolation intact
  exprs+=("s@-[0-9][^\"]*\.tar\.xz\"@-${version}.tar.xz\"@")
  exprs+=("s@^( *version \")[^\"]*(\"[[:space:]]*)\$@\1${version}\2@")

  for target in "${targets[@]}"; do
    shasum=$(jq -er --arg t "$target" '.[$t].shasum' <<<"$json")
    exprs+=("s@(sha256 \")[0-9a-f]*(\" # ${target}\$)@\1${shasum}\2@")
  done

  local tmp
  tmp=$(mktemp)
  sed -E "${exprs[@]/#/-e}" "$file" >"$tmp"
  mv "$tmp" "$file"
}

# commit_if_changed <file> <version>
commit_if_changed() {
  local file=$1 version=$2
  local name=${1##*/}
  name=${name%.*}

  if git diff --quiet -- "$file"; then
    echo "${name}: already at ${version}"
  else
    git commit --quiet --message="${name} ${version}" -- "$file"
    echo "${name}: updated to ${version}"
  fi
}

if [ "$update_zig" = 1 ]; then
  zig_json=$(fetch "$zig_index_url" | jq -e '.master')
  rewrite_file "$zig_file" zig "$zig_json"
  commit_if_changed "$zig_file" "$(jq -r '.version' <<<"$zig_json")"
fi

if [ "$update_zls" = 1 ]; then
  # pin zls to the newest dev build that runs on the zig version
  # currently recorded in the zig-dev formula
  zig_version=$(sed -nE 's@^ *version "([^"]*)".*@\1@p' "$zig_file" | head -n1)
  if [ -z "$zig_version" ]; then
    echo "could not read zig version from ${zig_file}" >&2
    exit 1
  fi

  zls_json=$(fetch -G "$zls_select_url" \
    --data-urlencode "zig_version=${zig_version}" \
    --data-urlencode "compatibility=only-runtime" |
    jq -e '.')

  rewrite_file "$zls_file" zls "$zls_json"
  commit_if_changed "$zls_file" "$(jq -r '.version' <<<"$zls_json")"
fi
