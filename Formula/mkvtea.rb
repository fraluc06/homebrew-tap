class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "ed992905dbc0698351a15567c332b20e490404bf8b49c9dc77d8d3a5e331ded8"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3a7d8bfdb3ccf03b30bdab4b95a7cfeb8309066f53bf142fe0b0ba9a4c244db7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e4a5ea7ec81bdfc516df358b38a8e4c7d10947127f86e208770b0bf30613a05"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "05d1b14bd64808af28e0f7ae247ed76a982f50e998893f6535af0539e4ac01b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15339aaa1c375f9e0a4a03449ebe9839869ac608cb91872e55bb11d3d98793db"
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
