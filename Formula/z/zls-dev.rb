class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "0d4c386ac9e41daeec2fe848da5bab9efd5deea306bda78a92e2ebb67cb1d34b" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "1798f7db7a5bb494a3d92e620aa14c7c3de50104712292b17bf7bbb14f52f2bb" # aarch64-macos
    end
  else
    os = "linux"
    sha256 "3bde2ce9e0d1db5ca76e306bd5bf0c7ab2a9c3290facc0990c5f7fccac11c699" # x86_64-linux
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.27+25df3a30.tar.xz"
  version "0.18.0-dev.27+25df3a30"
  license "MIT"
  head "https://github.com/zigtools/zls.git", branch: "master"

  livecheck do
    skip "Dynamic `url` and `sha256`"
  end

  depends_on "zig-dev"

  conflicts_with "zls", because: "both install a `zls` binary"

  def install
    bin.install "zls"
  end
end
