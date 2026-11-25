class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "c4798d13b870a74f67b9f817aa94bf24a885216686759bf4c2e7e3a0a6316c9a" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "ee48c47f49d461ab5f78d76c3390ed20220408c3bbd4026e169eda74c57ca60c" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "eb927a77c4123a3bcc8d52141bc9e0b236abc3020328a7f0e65ab61bab1fd469" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "78a1a99dd846a60947d1a97fb62bf7b835fe67312f75c9c712bc51dbc19f2591" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1284+2385a0153.tar.xz"
  version "0.18.0-dev.1284+2385a0153"
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
