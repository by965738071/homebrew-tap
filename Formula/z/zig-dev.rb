class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "3ec49b3bfc5754c68898928ab8186af8c950fff9f8925f951be6cd052efedcd2" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "9613d643a16e9f42e9e1ead921a0a854e6086ed4158def7d606c83350e8c587f" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "86802acd1c2ae5d1c6ab4be84fb207bdeedb19c8d4493813e0d00a70a4613b12" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "23453a8e1d5a97aab31ebf1f55a07deb64e0b303cbc41fef38ae2565e862e706" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1311+3a0e028c5.tar.xz"
  version "0.18.0-dev.1311+3a0e028c5"
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
