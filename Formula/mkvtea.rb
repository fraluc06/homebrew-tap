class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "16d2af6dd20f823fd1b0f0d11c696ff8f463a5fb3fe77c14e76aaf10b450ca98"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.1.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "eb042336f40593d03d0b6b0c3818ac206ca63715b11aa4c294f4cfe03fcc6fb1"
    sha256 cellar: :any,                 x86_64_linux: "d50aa371b89ba95aa7233a71b3c465d599fca90abf92a6a81117953dbb7033c4"
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
