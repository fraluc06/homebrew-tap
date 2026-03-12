cask "proton-bridge-nightly" do
  version :latest
  sha256 :no_check

  on_macos do
    on_arm do
      url "https://nightly.link/mnixry/proton-bridge/workflows/build-multi-platform/master/build-macos-latest.zip",
          verified: "nightly.link/mnixry/proton-bridge/"
    end
    on_intel do
      url "https://nightly.link/mnixry/proton-bridge/workflows/build-multi-platform/master/build-macos-15-intel.zip",
          verified: "nightly.link/mnixry/proton-bridge/"
    end
  end

  on_linux do
    url "https://nightly.link/mnixry/proton-bridge/workflows/build-multi-platform/master/build-ubuntu-latest.zip",
        verified: "nightly.link/mnixry/proton-bridge/"
  end

  name "Proton Mail Bridge (nightly)"
  desc "Proton Mail Bridge fork for free use — nightly CI build"
  homepage "https://github.com/mnixry/proton-bridge"

  livecheck do
    skip "Rolling nightly CI build — no versioned releases available"
  end

  # The ZIP contains a .tgz which brew auto-extracts; contents are at root of staged_path.
  container type: :zip

  on_macos do
    app "proton-bridge.app", target: "Proton Mail Bridge.app"

    postflight do
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{appdir}/Proton Mail Bridge.app"]
    end
  end

  on_linux do
    binary "proton-bridge"
    binary "bridge"
  end

  zap trash: [
    "~/.cache/protonmail/bridge-v3",
    "~/.config/protonmail/bridge-v3",
    "~/.local/share/protonmail/bridge-v3",
    "~/Library/Application Support/protonmail/bridge-v3",
    "~/Library/Caches/protonmail/bridge-v3",
    "~/Library/Logs/protonmail/bridge-v3",
  ]
end
