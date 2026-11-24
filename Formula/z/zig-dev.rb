class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "f1b12ed2112404b404fbc0440b1e5b96feb296f831246f85ad27be379732f1c7" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "ca1df96eda43f342597e65b02a64abfb810c43fa6611a4c84dadaa0003437800" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "939b3e2bd4b6896e5de75c86fa3e5bc7e44e31a540dbf769372748e848a05b19" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "ef9ca7f0cfa2dceee2dff2dcc48eb51c6b8b55094f1f8395af9ca6b8a26d0c98" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1279+81de6a1c6.tar.xz"
  version "0.18.0-dev.1279+81de6a1c6"
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
