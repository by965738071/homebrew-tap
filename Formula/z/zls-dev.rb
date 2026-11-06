class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "a9457a9c223df8d64948cd84443110d11afd7c83f1488c57c005f28c699bf59a" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "c08d12e433dbb6dc7609dea915a954b316f0290ee485d2498dd1294395bda738" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "5482fac5ec26b78a325ac0e7fbd45e5f9a51ee76b2029b02d7e5e19c8ef17d98" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "3f2a61e9911b5dad2f13660efdcfd6c14463cdb428f5be5406d211f2b0873018" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.32+c275dd2e.tar.xz"
  version "0.18.0-dev.32+c275dd2e"
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
