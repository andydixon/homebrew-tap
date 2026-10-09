class Mapsize < Formula
  desc "Interactive terminal disk usage analyser with a navigable treemap"
  homepage "https://github.com/andydixon/mapsize"
  url "https://github.com/andydixon/mapsize/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "cf9e68b5f57959e5768d2dff4fc38d26f108fcbf9d43081f3719f2b917d64f5e"
  license "GPL-3.0-or-later"
  head "https://github.com/andydixon/mapsize.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    man1.install "docs/mapsize.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mapsize --version")
    (testpath/"data/file.txt").write "hello"
    assert_match "Files", shell_output("#{bin}/mapsize --no-ui #{testpath}/data")
  end
end
