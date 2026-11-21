class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "5962a8472d44e22f5b082b50b0a64bd9fb24c85db182d4fed2ed39c2bd5172f0" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "cfebc697e8b650f20317a174d777d7c9f150efc688b3714686ba649de3db7804" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "053b20c3c7dc97d8c0d576ebf19e6db78f8bdff1aa4d95f660c037cd3b94b9f7" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "886cd9c1b752838c7c87fb33c9fe82199b2f082c9668e74ffa540409c9ec30db" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.1260+833623422.tar.xz"
  version "0.18.0-dev.1260+833623422"
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
