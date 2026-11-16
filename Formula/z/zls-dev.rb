class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "35533d327a63ea650bc05acaec776d3f778f24ce74f481b92af00ac8a976e738" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "cc9db2f7194ccdbbc3639e2c86d926edec8d1c553425724776ac33749d493f42" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "a4610899ea1f43bd770f40f01ccc458fea165cd540b5bcc0f292a3fee68ac2b0" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "b7876e6b200610d60d0caba85da7ff94bdcbd140cbf9cb58b856cc9fa4d0e69d" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.63+37521c98.tar.xz"
  version "0.18.0-dev.63+37521c98"
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
