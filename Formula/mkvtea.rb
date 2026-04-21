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
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "646496351bcb073df60ce3cd0b30628c250098077f9bfdd9bfd27306e08cd5bc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "154a06e666c221e6b8440d56ba9f49f54a3511bc247a5056df242cd4efd91415"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "23f00d72d159ecc1f95aa1773f881d449884e01ca536db76646c117a47d69ffb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80b158b4dcf66e74f7f59c76288a2dec71954dcb1cfb843c24eb5dfc7b49229d"
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
