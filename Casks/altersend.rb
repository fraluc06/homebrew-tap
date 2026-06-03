cask "altersend" do
  version "1.1.0"

  on_macos do
    arch arm: "-arm64", intel: ""

    sha256 arm:   "e0dbe5d3cf30ddac924bc5d70351a5e156f15b2d047c9f776593a8c9faed1cb9",
           intel: "120d9f51fbe91f0f829e077823b46519d04b9504c4b7cb77f8872c00ba2c3c62"

    url "https://github.com/denislupookov/altersend/releases/download/v#{version}/AlterSend-#{version}#{arch}.dmg",
        verified: "github.com/denislupookov/altersend/"
  end

  name "AlterSend"
  desc "Secure, peer-to-peer file transfer app"
  homepage "https://altersend.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "AlterSend.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AlterSend.app"]
  end

  zap trash: [
    "~/Library/Application Support/AlterSend",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.altersend.desktop.sfl*",
    "~/Library/Preferences/com.altersend.desktop.plist",
    "~/Library/Saved Application State/com.altersend.desktop.savedState",
  ]
end
