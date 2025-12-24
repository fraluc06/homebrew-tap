class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4c71bd3d6ce708d154114135f1eba9d4623cbc917cceaf1d6423b2b9cf7936a4"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "73e6a6a1a05af71bb3553cf0b4c396382e5a31c416bfb93b1fcde743c8a4e765"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "79744db2debadd7aa95c5528e9c29987b8d1b8c1f89f8715aba29d120314126e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b2daaa958f1a128227c0fb9365710eaa511f0aac7d091f7afb7c25956f42572b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9b6e00c4fc010965a27034a2becb80dd265d93ec556f38a4e9cbfc59f6a01d3"
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
