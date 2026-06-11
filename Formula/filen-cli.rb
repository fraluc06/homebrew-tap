class FilenCli < Formula
  desc "Command-line interface for Filen encrypted cloud storage"
  homepage "https://github.com/FilenCloudDienste/filen-rs/tree/main/filen-cli"
  url "https://github.com/FilenCloudDienste/filen-rs/archive/refs/tags/filen-cli@v0.2.6.tar.gz"
  sha256 "30f4f3c3c5637f29373c1e23148025948cef7e8f3b560daf01d9e4f2c8437302"
  license "AGPL-3.0-only"
  head "https://github.com/FilenCloudDienste/filen-rs.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_tag
    regex(/^filen-cli@v?(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/filen-cli-0.2.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a84340aea907afaa12dd78042c393eef5294ea433dd23c62f769b050d872fd43"
    sha256 cellar: :any,                 x86_64_linux: "94d5ab02a18477fda7924c831626b8c7c0d9e2540162b1c76141f407da754940"
  end

  # cmake is required by heif-decoder/build.rs to compile libde265 and libheif
  depends_on "cmake" => :build
  # rustup is needed to install the nightly toolchain required by the project
  depends_on "rustup" => :build

  def install
    # Isolate rustup/cargo from the user's home directory
    ENV["RUSTUP_HOME"] = buildpath/".rustup"
    ENV["CARGO_HOME"] = buildpath/".cargo"

    # Read the pinned nightly version from rust-toolchain.toml included in the tarball
    toolchain = File.read("rust-toolchain.toml")[/channel\s*=\s*"([^"]+)"/, 1] || "nightly"

    # Install the toolchain pinned by the project (e.g. nightly-2025-08-14)
    system "rustup", "toolchain", "install", toolchain, "--profile", "minimal", "--component", "rust-src"
    system "rustup", "default", toolchain

    # Add the freshly installed cargo to PATH
    ENV.prepend_path "PATH", buildpath/".cargo/bin"

    # Flag required by the project for the trait solver (see rust-toolchain.toml)
    ENV["RUSTFLAGS"] = "-Zhigher-ranked-assumptions"

    system "cargo", "install", *std_cargo_args(path: "filen-cli")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/filen-cli --version")
    assert_match "Failed to log in",
      shell_output("#{bin}/filen-cli --email lol@lol.com --password lol --skip-update 2>&1", 1)
  end
end
