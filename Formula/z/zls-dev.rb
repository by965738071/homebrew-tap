class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "ee78a489fc9873f71df9cd21aeb5ed33c7adb0a369729548004e37693c96060b" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "3ed9287605f27ce6d8f38242faf8a57a0fb67d3995915a27128a76dc708a3544" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "39df9356b3bace81ccf53b398cae8a5c6d0d0b5f601c587c057add05d0566e2a" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "aef0f7a4e81ceeb5f5a3580c2b499c15f285cec97723fc30152ed2fdaec3e8e4" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.69+e0911cd1.tar.xz"
  version "0.18.0-dev.69+e0911cd1"
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
