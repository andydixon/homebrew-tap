class Swaptop < Formula
  desc "Htop-style view of which processes are using swap, and how"
  homepage "https://github.com/andydixon/swaptop"
  url "https://github.com/andydixon/swaptop/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a6da1237452ad97435a7a9f9c95151069d3b7cf601de489d050103458ea19a1b"
  license "GPL-3.0-or-later"
  head "https://github.com/andydixon/swaptop.git", branch: "master"

  depends_on "go" => :build
  depends_on :linux

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
    man1.install "docs/swaptop.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swaptop --version")
  end
end
