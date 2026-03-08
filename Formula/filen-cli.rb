class FilenCli < Formula
  desc "Command-line interface for Filen encrypted cloud storage"
  homepage "https://github.com/FilenCloudDienste/filen-rs/tree/main/filen-cli"
  url "https://github.com/FilenCloudDienste/filen-rs/archive/refs/tags/filen-cli@v0.2.5.tar.gz"
  sha256 "ff3ffb65fea1af416eb7c56d0df62cb00df168ac44482c72dff0f78d96128fa2"
  license "AGPL-3.0"
  head "https://github.com/FilenCloudDienste/filen-rs.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_tag
    regex(/^filen-cli@v?(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/filen-cli-0.2.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "efe1c85a5db658520cfa83019f74b7096b9cbbb537cc7e93495e52f9dbaf3c32"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "da0dff4b3ec62a72c8baca14b8bc22652b211a83b8a1be93afa715662707892e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a0bdda67295967b8ef304987d866616d723ee9e3fcc66b59b500f8f36f63ab2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c89e9930e13f90a67a2423d69e4b2fc78fc000caf7b7ac1adf269d39d658fdd3"
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
    toolchain = Utils.safe_popen_read("grep", "channel", "rust-toolchain.toml").strip.split('"')[1]
    toolchain = "nightly" if toolchain.blank?

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
    assert_match "Email or password wrong",
      shell_output("#{bin}/filen-cli --email lol@lol.com --password lol --skip-update 2>&1", 1)
  end
end
