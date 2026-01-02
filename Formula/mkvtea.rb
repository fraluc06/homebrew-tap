class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4c71bd3d6ce708d154114135f1eba9d4623cbc917cceaf1d6423b2b9cf7936a4"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
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
