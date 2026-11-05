class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "bf82c60c5121cc7d6c76fdb07442f37f44930192d4c50c3f3ad78746193d9cee" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "63047b5074aa4ea597172568eed3aa89548e7b576791fdb7cf9f4db1d01678b2" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "544bd14a24307a3910530d3310c23f97f56e3aac74afa2f579f9a4443c4f683a" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "cef3b4602e82881b01ee67a524c4b043f8a0777beac31145fde604f47659eb42" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.860+8e8cf3835.tar.xz"
  version "0.18.0-dev.860+8e8cf3835"
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
