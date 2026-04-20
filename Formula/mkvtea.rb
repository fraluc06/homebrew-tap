class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "67c9a0b83577047ab1848d4c04490500ba817a23850c5c2ee13cc21482c2f660"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a53cd268ef04f14c640d3ef5377eba42cb558e98ea9a7f70d67de9dd12a3433a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1ba7f0f66048362cf48f441ad91ee9f09a6104c8d4da6549ec286d114b839266"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "273cc6efd158efb2e2317f4bcf4d77a34399de8cc2c4b97249298eeb0c5af438"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eebc8ee78cc97b2a803a1a91758aefbe949ca25beae1cf3fe88c8b71054d43a1"
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
