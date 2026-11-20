class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "a11c24ddc337964903e9efe0dc97acdd3e9f5d5b9e6c0b24e50244aadbb28e43" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "bc1d1d1ae784402ae649b4f2fc97a521d5bd04ba1f3f1ad427aeeef974dfeb3d" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "f578eb9e0f87a4be6935f7954ffce06de716a60aeca3cba8b7ff876e5d86b7d2" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "0379da329872eecbbbe461940a00f562766eb3ef95872cb9cb17aa17f7cf31b0" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1244+b5ffcbd70.tar.xz"
  version "0.18.0-dev.1244+b5ffcbd70"
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
