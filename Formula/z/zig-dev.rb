class ZigDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "4c0edcad4cda1c4dbd2b54fb6bf4fc9d4661ef31b65d8e2e5ef5321818dd04c2" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "a554790fb1ce2945c4d606a3fbb40e86fc9cbb4845c6a8f56d156190d60e5d8f" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "c373b28bf1fb56e1b0f5e706b5a984c35503ea4f0fd36638bdd81ea8c4c47095" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "5e0ef3eb6f8d5d479ed97ea51b100dcb6e61ff65ccf8034299f6c8e3dad4ab65" # aarch64-linux
    end
  end

  desc "Development build of the Zig programming language"
  homepage "https://ziglang.org/"
  url "https://ziglang.org/builds/zig-#{arch}-#{os}-0.18.0-dev.828+9da287565.tar.xz"
  version "0.18.0-dev.828+9da287565"
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
