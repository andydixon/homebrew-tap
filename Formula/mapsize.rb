class Mapsize < Formula
  desc "Interactive terminal disk usage analyser with a navigable treemap"
  homepage "https://github.com/andydixon/mapsize"
  url "https://github.com/andydixon/mapsize/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "2fdd3746b4bdf194b02de17fc3c8582160e810e07c40a924b68bdb04f5f522d4"
  license "GPL-3.0-or-later"
  head "https://github.com/andydixon/mapsize.git", branch: "master"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/andydixon/mapsize/internal/brand.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/mapsize"
    man1.install "docs/mapsize.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mapsize --version")
    (testpath/"data/file.txt").write "hello"
    assert_match "Files", shell_output("#{bin}/mapsize --no-ui #{testpath}/data")
  end
end
