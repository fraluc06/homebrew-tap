class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "58bfcd3678d6a2e56e29c06608a45f074860588258fe5835b9f78d3e8205135f"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "44e5afccfb0c94b540f03c4acdd30cb04474b997d759bccd440efc2f168a19bd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5270cb476c40954a38074c399506eb431cbc2129b6e6632c10a337f36f36f55d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "27cd0d86dbaee66479d839a23394a8b856c405b8e7f489c52c4679bfcafdc3fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df665d1716f386c6be916ee727edb705083b401932f16b580ddb0ce8c8d62f8c"
  end
  depends_on "go" => :build
  depends_on "mkvtoolnix"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "mkvtea", shell_output("#{bin}/mkvtea --version")
  end
end
