class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "4c71bd3d6ce708d154114135f1eba9d4623cbc917cceaf1d6423b2b9cf7936a4"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c97dc2a25fba2bdbcffa394e56f1b00a2a12dea7ba22cd918abd8b5f7e2910be"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3c58155c67678fdb398e5db4760984f91b1f85df9970a7024a753f0525d7332d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b066a87d02a85fe0bee0d2fddec6a1469c3e8d4b512c7a4117a4eb17fee7ce64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5d0701677da16546bd3c2bb4cdb1aa82b70fe2096fee13e1206cd0d06dfaa15"
  end

  depends_on "go" => :build
  depends_on "mkvtoolnix"

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"mkvtea"
  end

  test do
    assert_match "mkvtea", shell_output("#{bin}/mkvtea --version")
  end
end
