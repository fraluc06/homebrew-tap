class FilenCli < Formula
  desc "Command-line interface for Filen encrypted cloud storage"
  homepage "https://github.com/FilenCloudDienste/filen-rs/tree/main/filen-cli"
  url "https://github.com/FilenCloudDienste/filen-rs/archive/refs/tags/filen-cli@v0.2.4.tar.gz"
  sha256 "a3d6a5df4f7a4f01b21c622d75b6c2f965d6d9126ece29a891f5b425930a484d"
  license "AGPL-3.0"
  head "https://github.com/FilenCloudDienste/filen-rs.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_tag
    regex(/^filen-cli@v?(\d+\.\d+\.\d+)$/i)
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
