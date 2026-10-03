class Mapsize < Formula
  desc "Interactive terminal disk usage analyser with a navigable treemap"
  homepage "https://github.com/andydixon/mapsize"
  url "https://github.com/andydixon/mapsize/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "659bd10fa7dc3781994bd7b2b187c7bc33a87134794332179bfead228485bb89"
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
