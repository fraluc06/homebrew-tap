class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f2ac6d8ba5567b169c28ab3b847a4d8b6fbba48c6d0217fedaa337a15fa82b83"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail --version")
  end
end
