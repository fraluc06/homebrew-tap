class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "184ef2c1990c6b4dcabebaac650ae9dc5d6a1bbbd6084e1247f274681fdc2fb5"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/burnmail-1.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5c4a4e32a78da3756fcb65d7794985c0af146da5bb1bc11722ed5c6d3e123099"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e240aefab34569effaf987427fb7cce8677df7801e2826ee21adc00dc7c6eb19"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4f664f349d628589f43635d2dcbadfd1c3ab91371b0c46b681085769cd51aa56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "993356124da1e74bde92edd6f0308f7c940d3fc740b844267cd7e358e686ad93"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
