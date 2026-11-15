class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "251b7a5115c328f499d888da2e8223e41b40a1417a18d810a2bcbe6370c6693a" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "8491a8470c5a1b6c4af866548c1031b214de99503d52f57ed3290a3f471bd094" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "07a8889c65fb0ca6ac76e1c11d0ba9e4aeeeba4f0c9c0bd75005e372f82b665f" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "2187ceafbefa2b04121749e398e2bf5cbc8fb64ed348d948a2e1c5b018f716c9" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1124+2ecf4b5e2.tar.xz"
  version "0.18.0-dev.1124+2ecf4b5e2"
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
