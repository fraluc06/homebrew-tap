cask "altersend" do
  version "1.2.0"

  on_macos do
    arch arm: "-arm64", intel: ""

    sha256 arm:   "f4fdf6b86147f6f6f04da884478c070cf90d214382ad72588caca9da13de80e4",
           intel: "bd135617983d3c3d30787f1748807a80372727ccc9736684f63715b90503b233"

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
