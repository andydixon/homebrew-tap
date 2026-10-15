class Apex < Formula
  desc "Native, high-performance text editor"
  homepage "https://dixon.cx/apex"
  url "https://github.com/andydixon/apex/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c4136f590160a4dbd11048bf192ece42bf8e89d8ee5d5af9f19cc204a2e86ebe"
  license "AGPL-3.0-or-later"
  head "https://github.com/andydixon/apex.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/apex-app")
    if OS.linux?
      (share/"applications").install "packaging/linux/apex.desktop"
      (share/"icons/hicolor/scalable/apps").install "assets/icons/apex.svg"
      [16, 24, 32, 48, 64, 128, 256, 512].each do |s|
        (share/"icons/hicolor/#{s}x#{s}/apps").install "assets/icons/png/apex-#{s}.png" => "apex.png"
      end
    end
  end

  test do
    assert_match "Apex", shell_output("#{bin}/apex --help")
  end
end
