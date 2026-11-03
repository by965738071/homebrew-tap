class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "575c322531bd8d80bb1cdecb569641fc8ebb1a768e57d544bab11ee876897bac" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "ece2f3b0df4c810a04e1daaea113fec41afa04205ba7e11214f1f6a8c798389d" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "d2850db8e6ee91bf2c0f19b3354a8de99fa3f3198b4dea157e95a06800fd0abf" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "d132974d9c9130ef07e2ff190dbe643a8e91a65f5d0f80edc4ee8d5d1cb3e5a8" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.852+efa5bfa9b.tar.xz"
  version "0.18.0-dev.852+efa5bfa9b"
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
