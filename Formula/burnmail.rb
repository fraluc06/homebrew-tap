class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "dbc7df4f2d1727f94eee0b02b61b8fe39d9348b6db1939c165e30049bb798d5b"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/burnmail-1.2.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d411b459850d66aa64f03e4e41303f3850e9f6f38143f76fdd91b03a34c082fd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f3fca99633129666db3b53dca56b39b4df3eae306ba238e5ae88b622c2e38473"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f18fca0e9699d4f2c6aaaeed8101e55ba850488e8b1d853c744dbc752e336084"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36f45bebf390be2850e77eb7ac7a69e1d48952b86123ecada91d9a820fe95e67"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
