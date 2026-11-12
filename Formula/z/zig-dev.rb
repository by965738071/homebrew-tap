class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "1b9a5d945fe86d6303ea98622f6d144469fa7effc9e8f67c4404a89ce8f16125" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "34154afa153b965b69876b7c7406edfeec6b5530072be164ec9cc52398f7056f" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "a07eee1bbd24dbf34e1609ddc904bec610a216c0b0d99654b5a976a5f650c895" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "84ecf67cf7de78a5f931b6f1333b79e9330f838695b2fde4fa0332c58a59ad69" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1005+75d48dfff.tar.xz"
  version "0.18.0-dev.1005+75d48dfff"
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
