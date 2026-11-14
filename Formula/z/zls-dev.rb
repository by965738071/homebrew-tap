class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "6653f217a2cab13761b4e86838330868a4f0611476ad7993f5ebb62cd8c7183f" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "9dfb7a12ca11aa44af29f62eaf4ea46a7eb556a9a7473a6e0b7fd78169c1d5f0" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "22bbc1ae443e901a87971ec60496710aac6f847d976a7a5c998ae028c1ffbb73" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "163882afcb6625f802d07024dae726df05f98590778ab91d9b557295b9d05103" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.57+9d9c9d2c.tar.xz"
  version "0.18.0-dev.57+9d9c9d2c"
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
