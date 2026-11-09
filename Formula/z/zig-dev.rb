class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "a913dd0da38d9ebc12219aec6c36ac77aa466ffc1b41121f7710f7e8b39136ec" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "305865b679c7a67096e36055ca2dccd555f0eadc2a335605df5a227094a4b584" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "eae031cf003551d7bd7c6b9ae5e2b594667f91388ec70ef3fdd2ac160f4d3dcf" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "b82f231d59ec23b7f1130e618a0867305c3b468c76c0a972340d4209c702a629" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.954+60635c2bd.tar.xz"
  version "0.18.0-dev.954+60635c2bd"
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
