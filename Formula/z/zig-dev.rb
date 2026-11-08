class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "95f4939ba491970a74001c291b7e88e73ff3505f5a9115e4e9b9af6eb9fec660" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "86917e13b3312d34f0f58d206986a7927dd608ce31f21712cace4758043c80ce" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "76258449f1088b6f80359944f9735a4c96e94246e553111155f0af6457ff8de4" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "37902e91ffbdbaf3e62bf94ba3c7721da13a7d0dbf89a3378d30f5100d3ac0b2" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.935+ead8f5a7a.tar.xz"
  version "0.18.0-dev.935+ead8f5a7a"
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
