class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "dbc7df4f2d1727f94eee0b02b61b8fe39d9348b6db1939c165e30049bb798d5b"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
