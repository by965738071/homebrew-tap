class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "68b51db5d6da55c0c4d0b0a47ff597f05ce356fe8d0f485b3705fdff36051344" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "0f961bec6b0512e403260d3b85b9f5abe8649906585209fceaa56597b5388290" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "331b87438f27d76650c9e8526b8460f513d45bbec8e6616349ea30632f2b37a4" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "5c93d84ed31f34d0cf6187500530fa09ec0f79316732735c860f4c69a19cee10" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.753+1420479be.tar.xz"
  version "0.18.0-dev.753+1420479be"
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
