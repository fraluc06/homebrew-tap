class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "33e26e0824728a7addd1ebe0cfcd21f369e0e1bfb72ddab68c24d18164d6eddf"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/burnmail-1.4.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d0ab12aafac92d9c22450eadc499e96d89b2746f403564288b212bf11664c22a"
    sha256 cellar: :any,                 x86_64_linux: "023fedfb1bb7b250ebe4cb4054227e5eae73ff6e74b558421e4f14ab942f19c2"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "burnmail", shell_output("#{bin}/burnmail version")
  end
end
