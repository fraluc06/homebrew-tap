class Burnmail < Formula
  desc "Simple CLI tool to generate and manage temporary email addresses with TUI"
  homepage "https://github.com/fraluc06/burnmail"
  url "https://github.com/fraluc06/burnmail/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f2ac6d8ba5567b169c28ab3b847a4d8b6fbba48c6d0217fedaa337a15fa82b83"
  license "MIT"
  head "https://github.com/fraluc06/burnmail.git", branch: "main"

  bottle do
    root_url "https://github.com/fraluc06/homebrew-burnmail/releases/download/burnmail-v1.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "286d32f37e3354adab9506a84d57fc8bea05605eff7a6bec746bfcd7ec9edde3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "286d32f37e3354adab9506a84d57fc8bea05605eff7a6bec746bfcd7ec9edde3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "286d32f37e3354adab9506a84d57fc8bea05605eff7a6bec746bfcd7ec9edde3"
    sha256 cellar: :any_skip_relocation, ventura:       "ad66278f28aa9102204b157b09df46425231b3d63eaf3518733619a36ffb781c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85efb0e4a278736c61b8f5e028fe8d8cd2025d7a2ccc9d70d2c54a3d6f330981"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.Version=#{version}
      -X main.BuildTime=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    output = shell_output("#{bin}/burnmail --version")
    assert_match version.to_s, output
  end
end
