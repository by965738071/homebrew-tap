class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "a84e80666ef1a49b12da0560081fe5cda4d234826982db6ee5ca107b8acc4059" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "7b08594ebeba2991c11adb6fb30fd1f261b4f30c5f300fb3bcc9a9f4cacd8a51" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "1f43c1cb2186832446763c326aab178ab8e787c0e942a8d1540c6f9befc59f67" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "2bcb4de9b824e95bf8c8933d10caca8664f7bb8aef735aca2b68a6736dd84581" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1165+ce87507d5.tar.xz"
  version "0.18.0-dev.1165+ce87507d5"
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
