class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "c8293aef32606f6baf6b44d8c15cd33f245016dd599d69bb56ee1a2c1fd86aa3"
  license "AGPL-3.0-or-later"
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
