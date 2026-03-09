class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "96e55b94eda5521f53058fd495d520af837c675cecc508a975371204b3df436a"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/burnmail-1.4.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1617703f4a069927649d1bf721760500210abf99eb70af97663deaa9439a988a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "90c4c789d7035daef24abd19fa179e8b307f7ce8998a848043331f4fb8b45b8b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bdb7b0dc4204757844d96cfab941d073b8696ad1e588ab3151c7139b7cc1c80f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "035a0a9325964e1f189b5d9ff9d11daebf39875eb46d3a5c6695421e9f90f301"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
