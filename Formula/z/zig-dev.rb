class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "67995ef75ca3467c95bf8749ffeeef65d02dc5561df54f4691cc8eb95aed388e" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "0dd59d354e357bd1fb73803ea0150c6df2fe0397293d314ec7b8130032c71ffa" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "e9a2ca22a64f89be010442fd18edbab647256684a395685279b13de02e7528f7" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "f0e908d14af3cf72559f9a9eb1c9779a1d303d32a2550e220d0746143a978cfc" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1298+4a0817482.tar.xz"
  version "0.18.0-dev.1298+4a0817482"
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
