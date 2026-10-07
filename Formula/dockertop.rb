class Dockertop < Formula
  desc "Htop-style view of Docker containers and the processes inside them"
  homepage "https://github.com/andydixon/dockertop"
  url "https://github.com/andydixon/dockertop/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "ed657dd374fdda49d78f74ba56d3803a5d3ddf04fde578483e4aa8c14ace601b"
  license "GPL-3.0-or-later"
  head "https://github.com/andydixon/dockertop.git", branch: "master"

  depends_on "go" => :build
  depends_on :linux

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
    man1.install "docs/dockertop.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dockertop --version")
  end
end
