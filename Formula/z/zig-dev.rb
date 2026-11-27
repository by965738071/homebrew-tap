class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "95cb64f1cfd45f076cbdeb00764b6db3f3be955704053ead68098da031df6905" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "a8ece7f8e2cbd429134adb1387cd96c5da7cdf24a241360cb0bebf1579d49944" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "26bd4ab8263e268b45c00ed92eb678b1efef8fec50e148c6dd22821152cda522" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "8871fa804924dc7e81ecfd4f8ad4b9c820f0f6a87e503424526fb539bf71f9a2" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1327+c851a1daa.tar.xz"
  version "0.18.0-dev.1327+c851a1daa"
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
