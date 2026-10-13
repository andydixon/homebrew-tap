class Apex < Formula
  desc "Native, high-performance text editor"
  homepage "https://dixon.cx/apex"
  url "https://github.com/andydixon/apex/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d2b570522ece1d9184c3158238654f79ed3cd799532912a7f731a1eebb2565a0"
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
