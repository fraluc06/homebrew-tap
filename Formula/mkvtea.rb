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
