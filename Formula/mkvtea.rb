class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "4c71bd3d6ce708d154114135f1eba9d4623cbc917cceaf1d6423b2b9cf7936a4"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "996b19c0798c90b1100699f6c3bbc058eecf778409e9c9cc85c447ace7256534"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "061e98b3e51e475172eb5619f66c5bb841e7bdb266e4f10fc70006da8a99c428"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f6dabc5bf9d84682fdbb4c7753fbe3cb691184fc43754943ebbe5965f2fef827"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04e4aa170dd5b57e2cc023561023c3b8a5fba0194bbecd4b690d9eeeac35c3fb"
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
