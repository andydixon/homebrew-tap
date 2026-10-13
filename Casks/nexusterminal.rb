cask "nexusterminal" do
  arch arm: "arm64", intel: "amd64"

  version "3.0.2"
  sha256 arm:   "87009a7c34e27db7a3fea2667ebfb6e7e23ac796ca3faa34a94c091e448d3b39",
         intel: "3daf9435487405145b7cad08380a933c92b848daee3e61cf6e6f358b88e0f57c"

  url "https://github.com/andydixon/nexus/releases/download/v#{version}/NexusTerminal-darwin-#{arch}.zip"
  name "Nexus Terminal"
  desc "Native client for SSH, SFTP, Telnet, Serial, VNC, RDP, IRC and GitHub"
  homepage "https://dixon.cx/nexus"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "NexusTerminal-darwin-#{arch}.app", target: "Nexus Terminal.app"

  zap trash: [
    "~/Library/Application Support/NexusTerminal",
    "~/Library/Preferences/com.andydixon.nexusterminal.plist",
    "~/Library/Saved Application State/com.andydixon.nexusterminal.savedState",
  ]

  caveats <<~EOS
    Nexus Terminal isn't notarised by Apple yet, so the first launch may be blocked.
    If macOS says it can't be opened, run:
      xattr -dr com.apple.quarantine "/Applications/Nexus Terminal.app"
  EOS
end
