class ZlsDev < Formula
  os = "macos"

  arch = "x86_64"

  if OS.mac?
    if Hardware::CPU.intel?
      sha256 "550e266d1e1eafb4fda7db82a1ca105ff0ccd012897d749b32a76b7ac60b938b" # x86_64-macos
    else
      arch = "aarch64"
      sha256 "cd0eb4e19e239ecdecd6fbdfc2680ae4dfea64619d25f22eefb19eb99854fceb" # aarch64-macos
    end
  else
    os = "linux"
    if Hardware::CPU.intel?
      sha256 "151b52e9db77d824e1cde4246acf9bc078fca860b94bf8ab255f84433804a9c5" # x86_64-linux
    else
      arch = "aarch64"
      sha256 "2101e47a24f0c612d8160e026df198ec1e42cf03446915530ed84a9128c43de0" # aarch64-linux
    end
  end

  desc "Development build of the ZLS language server for Zig"
  homepage "https://zigtools.org/zls/"
  url "https://builds.zigtools.org/zls-#{arch}-#{os}-0.18.0-dev.31+b3e65123.tar.xz"
  version "0.18.0-dev.31+b3e65123"
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
