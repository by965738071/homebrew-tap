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
    if Hardware::CPU.intel?
      sha256 "3bde2ce9e0d1db5ca76e306bd5bf0c7ab2a9c3290facc0990c5f7fccac11c699" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "0856842d4e9e50cb01a9828984136caf5b413f7fdc759f87c06acc816159e0dd" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.27+25df3a30.tar.xz"
  version "0.18.0-dev.27+25df3a30"
  license "MIT"

  livecheck do
    skip "Dynamic `url` and `sha256`"
  end

  depends_on "zig-dev"

  conflicts_with "zls", because: "both install a `zls` binary"

  def install
    bin.install "zls"
  end
end
