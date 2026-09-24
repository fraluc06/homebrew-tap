class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "edff215f2196ddeb3552afac14c0ec38c08a2bfc41eed4af9f9bc92a5a99fb4c"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "106102e93d6d8f9e339ef4fdec8676aeda391593b5e101889de114caacacd481"
    sha256 cellar: :any,                 x86_64_linux: "385a993f51266211082830163c9dd57b1e029609fd2ee52372ae89d64d1a34a0"
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
