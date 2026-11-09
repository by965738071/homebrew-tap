class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "05e5ed46fd45ef337273376255f73357652d19a5bd7d4fae6807a5ff11d2d5d2" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "afa7997f197c4969666ea179137b253db7a14926b5bc0f9f4dd226e5744d6ad6" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "91b414bee61497f392a29ce55efb7acd9e80ff0be3cc9fbfa29b4f8eef5ead29" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "83e2c56417a5822141c33fd912fa740d5ca199d9594326f4b7f39e41d5e5ff44" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.43+066658e2.tar.xz"
  version "0.18.0-dev.43+066658e2"
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
