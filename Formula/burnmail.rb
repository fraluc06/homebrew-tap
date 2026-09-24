class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "33e26e0824728a7addd1ebe0cfcd21f369e0e1bfb72ddab68c24d18164d6eddf"
  license "MIT"
  revision 1
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/burnmail version")

    # Command wiring check: shell-completion generation runs the full cobra
    # tree offline (no network, no TUI) and must emit burnmail's functions.
    assert_match "__burnmail", shell_output("#{bin}/burnmail completion bash")
  end
end
