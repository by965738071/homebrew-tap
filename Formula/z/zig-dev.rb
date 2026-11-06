class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "3ed4a0cb582964dd60986b1b8ecd89548cae01b18ed65ed1666f455df211f76e" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "3ceb2105a34729183b82ec553e72603ff52862b1eabc8c2b782ae4fd2f51f0cf" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "21ebe61ed1ea090cc3b0a1af400812fe4f5303b52238314d1b9264f356591065" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "44176d559c8fa9cd15362b8e5e57bdcdb1b3da9148fb4237395fa6c2255f3faf" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.897+117fd40fb.tar.xz"
  version "0.18.0-dev.897+117fd40fb"
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
