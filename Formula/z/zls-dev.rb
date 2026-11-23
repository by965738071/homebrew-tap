class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "7513fd6c572025a032c38b2482850d963232ad20c02fa5de0fd6207cc45fb4ce" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "cafa237596f559a0c6bbf4d8b5932694639820cdee6aebbca71beba075af0c69" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "9dd9ab6cddab01769917a72b35277a54ff9e589bbfdf9309cc4ab36d89764e2e" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "2a9ae4c549c6139a745a4d1a5c07772a19061f57e9409b0783e72942f1632f8f" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.71+37a0d598.tar.xz"
  version "0.18.0-dev.71+37a0d598"
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
