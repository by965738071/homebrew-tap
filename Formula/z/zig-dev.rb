class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "2bdd4b5d34bf3c237d3d623427231bc27712520d33c0b87c76ba0e29615c58d4" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "d15f636b3675c4fb4f973bfcae8118927367676f7aa7b3be20e09a4490b0c59f" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "eb83250a397ee08a0bec3e03d41fbba94d6f7b5307d131f2acfd083989766489" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "6b2232405d06ce0a6cf0e1fb908ac4fb1ec4150fe19cdc93cc86bbc6bd090b4a" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1153+c62948217.tar.xz"
  version "0.18.0-dev.1153+c62948217"
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
