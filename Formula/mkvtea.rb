class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "edff215f2196ddeb3552afac14c0ec38c08a2bfc41eed4af9f9bc92a5a99fb4c"
  license "AGPL-3.0-or-later"
  revision 1
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  depends_on "go" => :build
  depends_on "mkvtoolnix"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X mkvtea/internal/config.Version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mkvtea --version")

    # Full pipeline without the TUI: dependency validation and directory scan
    # run for real, and an MKV-free folder must exit 0 with a clear report.
    (testpath/"library").mkdir
    assert_match "No MKV files found", shell_output("#{bin}/mkvtea extract #{testpath}/library")
  end
end
