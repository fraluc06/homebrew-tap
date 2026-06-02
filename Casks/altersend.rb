cask "altersend" do
  arch arm: "-arm64", intel: ""

  version "1.0.0"
  sha256 arm:   "a4c993cd751164bbc69f1c7b6d5438b3a625813fc91c474e978897cb6a36969b",
         intel: "6146334a9e539e7281df9d45138463cc659e5da3b25183818ee18adb2407c644"

  url "https://github.com/denislupookov/altersend/releases/download/v#{version}/AlterSend-#{version}#{arch}.dmg",
      verified: "github.com/denislupookov/altersend/"
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
