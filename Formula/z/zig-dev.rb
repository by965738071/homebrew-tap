class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "b402150495e123e5f767baf18af0d29a247fa465c0752deb2eb7dda8c2b4d1c4" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "be25e30e530c1a97e5bf334d6be7741d26d5098f6bb4ba611d53b0099adf4c82" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "ad9810a64e57dbfe857c34ac430a4e80db3764f0d23b4df72bb64dbc9899ded3" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "b179afe7f89b58bd89d04e6cb5bb87871bdfe88d081f417bda6dea11fa136083" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1301+ef2d38a82.tar.xz"
  version "0.18.0-dev.1301+ef2d38a82"
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
