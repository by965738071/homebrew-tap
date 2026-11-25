class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "a215f621a9e988fd9a75dd151796321149170339fc7ef82087c8b1171b5e7fc7" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "ae31d5cba7295f29fef6955d1b8e8aadc6dbd2134508e3ad1105367e8fd13164" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "4240633e8f0b30ac10f82ca82db751723b7445269b2e235cb4471aea99fcbac0" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "ccb3edb7c3c8baa60e648460cc99aed23431324c2c92d5f00f238618f9c95964" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1295+1fb0e6330.tar.xz"
  version "0.18.0-dev.1295+1fb0e6330"
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
