class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "440239f221f2954ebe825087a83bc255007f51e96287e80381189d5e01af3dc7" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "f3f435ff4a2650b2b62fcd799aa5a122b38a9c0db60f2c7a41e9ed03ad17180f" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "49225b4b3151a11346d4c469a308ddf037d316cda234505b8fb34262ae9dd1ae" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "383e69e9e844d5e1ad98fb5ab8bfa54e9c1eb96d9fb5e3c68a28ca40e1b6f2fc" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.861+1a0778dc2.tar.xz"
  version "0.18.0-dev.861+1a0778dc2"
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
