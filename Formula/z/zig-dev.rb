class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "5e16a1eeb6eb704285f00403108bdd5533b2d3265b3278369b1c7537f443e700" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "d9779ff22c32a27d86b737f0e4c1837e0b365658942e1ec904dff80f2688fdbf" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "e26ec590ef667bf24471e954d572508f847f5f2eb96b44319de37dd313487133" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "bdf1de8873db23ead93571f9f69a68d24ea673f581e2313a9db6bd1290041a2c" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1273+1ba843088.tar.xz"
  version "0.18.0-dev.1273+1ba843088"
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
