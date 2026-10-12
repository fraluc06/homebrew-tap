class Mkvtea < Formula
  desc "Blazing-fast batch processing tool for managing anime/TV series MKV libraries"
  homepage "https://github.com/fraluc06/mkvtea"
  url "https://github.com/fraluc06/mkvtea/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "f4aac6fdef7da9103f3373b94aa53a89f0bfcd87aa5bdd4fd3a46f3ceb479ad3"
  license "AGPL-3.0-or-later"
  head "https://github.com/fraluc06/mkvtea.git", branch: "main"

  livecheck do
    url :stable
    :github_latest
  end

  bottle do
    root_url "https://github.com/fraluc06/homebrew-tap/releases/download/mkvtea-1.3.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "413285fb940d268f4f5fb9d86766e337e1f6ea77e891a078e09e1b3f59fed82f"
    sha256 cellar: :any,                 x86_64_linux: "8e32e765eb5a69cec9e86490088665c0bd54c12f9c8be11c63964c2bd1e43923"
  end

  depends_on "go" => :build
  depends_on "mkvtoolnix"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X mkvtea/internal/config.Version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mkvtea --version")

    # Offline pipeline check: dependency validation and directory scan run
    # for real, and an MKV-free folder must exit 0 with a clear report.
    (testpath/"library").mkdir
    assert_match "No MKV files found", shell_output("#{bin}/mkvtea extract #{testpath}/library")

    # TUI smoke test (the pty pattern used by nnn/csvlens in homebrew-core):
    # the Bubble Tea processor only renders against a real terminal, and the
    # Ruby-spawned pty is 0x0 unless resized with stty. A garbage .mkv makes
    # the mkvmerge-identify step fail instantly, so the batch completes fully
    # offline; pressing "q" once the header shows ends the run instead of
    # waiting out the 10s auto-close delay.
    require "pty"
    ENV["TERM"] = "xterm-256color"
    (testpath/"tui").mkdir
    (testpath/"tui/broken.mkv").write "not a matroska file"
    PTY.spawn("/bin/sh", "-c",
              "stty rows 40 cols 120; exec #{bin}/mkvtea extract #{testpath}/tui") do |r, w, _pid|
      output = +""
      quit_sent = false
      begin
        loop do
          output << r.readpartial(4096)
          if !quit_sent && output.include?("MKVTEA - EXTRACT")
            w.write "q"
            quit_sent = true
          end
          break if output.include?("FINAL SUMMARY")
        end
      rescue EOFError, Errno::EIO
        # GNU/Linux raises EIO when reading a closed pty
      end
      assert quit_sent, "TUI did not render its header"
      assert_match "FINAL SUMMARY", output
    end
  end
end
