class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "dbc7df4f2d1727f94eee0b02b61b8fe39d9348b6db1939c165e30049bb798d5b"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/burnmail-1.2.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7b0cd470bc97f8ed46181a1fc175684d9663f9f26269af63fc6c264de4055560"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "607dba5251145ac4cccb4f08a9b8cb94eac509ccc14cff3492f57cbe74708640"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a3c8160686790a7ca69759339900a68dad63691d2536d2cd43d800b177bc1b6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f62c9e7b99b1d21581f52db21418553856c5566dfb3ba7a3772a23c74939496"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"burnmail"
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
