class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/Burnmail/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "fc5df6f438574f7f16d6fc248f97f2cf36893ac9338ad33c79b3f3fbdc851270"
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
