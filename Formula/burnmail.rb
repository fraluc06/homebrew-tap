class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "184ef2c1990c6b4dcabebaac650ae9dc5d6a1bbbd6084e1247f274681fdc2fb5"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
