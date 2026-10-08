class Vault < Formula
  desc "Post-quantum encrypted file vault with a decoy passphrase"
  homepage "https://dixon.cx/vault"
  url "https://github.com/andydixon/vault/archive/refs/tags/0.6.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "GPL-3.0-or-later"
  head "https://github.com/andydixon/vault.git", branch: "master"

  depends_on "rust" => :build

  conflicts_with "hashicorp/tap/vault", because: "both install a `vault` binary"

  def install
    system "cargo", "install", *std_cargo_args
    man1.install Dir["docs/*.1"]
  end

  test do
    ENV["VAULT_PASSPHRASE"] = "brew test passphrase"
    ENV["VAULT_KEY"] = (testpath/"key").to_s
    ENV["VAULT_DIR"] = (testpath/"store").to_s
    system bin/"vault", "genkey"
    system bin/"vault", "init"
    (testpath/"hello.txt").write "hello"
    system bin/"vault", "add", testpath/"hello.txt"
    assert_match "hello.txt", shell_output("#{bin}/vault list")
    system bin/"vault", "get", "hello.txt", "-o", testpath/"out.txt"
    assert_equal "hello", (testpath/"out.txt").read
  end
end
