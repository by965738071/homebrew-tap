# Zig dev Homebrew tap

Development (nightly/master) builds of the Zig toolchain and the ZLS
language server, updated automatically by GitHub Actions.

## Install

```sh
brew install by965738071/tap/zig-dev
brew install by965738071/tap/zls-dev
```

Or `brew tap by965738071/tap` and then `brew install zig-dev zls-dev`.

This repository must be named `homebrew-tap` for Homebrew to find it
under the tap name `by965738071/tap`.

## Formulae

| Formula   | Source                                                       |
| --------- | ------------------------------------------------------------ |
| `zig-dev` | latest `master` build from <https://ziglang.org/builds/>     |
| `zls-dev` | latest `zls` dev build compatible with the `zig-dev` version |

`zls-dev` is resolved through the zigtools release API
(`releases.zigtools.org/v1/zls/select-version?zig_version=<zig-dev>&compatibility=only-runtime`),
the same mechanism the scoop manifests use, so `zls` always matches the
Zig version pinned by `zig-dev`.

Supported targets: `x86_64-macos`, `aarch64-macos`, `x86_64-linux`,
`aarch64-linux`. To add another one, add a branch with a tagged
`sha256 "…" # <target>` line in each formula and add the target to the
`targets` array in `scripts/update.sh`.

## How updates work

The upstream tarballs are already compiled binaries, so there is nothing
to bottle: installation is just a file copy. The tap therefore stays
dependency-free of GitHub Releases.

`.github/workflows/update.yml` runs `scripts/update.sh zig-dev zls-dev`
every 6 hours. The script:

1. reads `master.version` and per-target `shasum`s from
   `https://ziglang.org/download/index.json` and rewrites the
   `version`, `url` and `sha256 "…" # <target>` lines in
   `Formula/z/zig-dev.rb`;
2. reads the Zig version just written and queries the zigtools
   `select-version` endpoint for the matching zls dev build, rewriting
   `Formula/z/zls-dev.rb` the same way;
3. commits each changed formula and the workflow pushes to `main`.

The formulae `skip` Homebrew's own livecheck because their `url` and
`sha256` are rewritten in place; the CI run is the update mechanism.
