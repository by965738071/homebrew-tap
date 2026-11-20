class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "0af811868cd871b4156beeb94cc03952476e3fd98c318397e732ffe8184b4a3e" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "78920b65f541929534bc84dedd70071c14c51664b5551f36ac09e696effedca9" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "3dc27cb8f0369ce029b47c6df3f2d1ac2c1a53eb0033550f463ff60917b3587e" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "599367c048fc016c1b8b43aa2c43cb84a33c7abbc1f2160ddccf779d9c83c2b6" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1240+74f654a72.tar.xz"
  version "0.18.0-dev.1240+74f654a72"
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
