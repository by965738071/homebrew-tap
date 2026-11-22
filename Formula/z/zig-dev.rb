class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "a98f9697111314dd051c41dff3d74ac574cd425bbb974ebf53055ba72b9a62d0" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "76ff8231659358ccc817153ae6ce963b992e1f88bc944be7a540aa5b420151bf" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "767b1ff5bc704fe2c1bc1b4a1bfae3a1237ae0475ba94357c32bcec5f4eddf28" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "63fa9a959a75d59c66497bf96f3e162d2bfffb576d53f8bd08246a01cdb68bbe" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1272+2ff397f75.tar.xz"
  version "0.18.0-dev.1272+2ff397f75"
  license "MIT"

  livecheck do
    skip "Dynamic `url` and `sha256`"
  end

  depends_on macos: :big_sur # https://github.com/ziglang/zig/issues/13313

  uses_from_macos "ncurses" # needed by the prebuilt Linux tarball
  uses_from_macos "zlib"

  conflicts_with "zig", because: "both install a `zig` binary"

  def install
    bin.install "zig"
    lib.install "lib" => "zig"
  end
end
