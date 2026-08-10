class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.7.0/umbragate_Darwin_arm64.tar.gz"
      sha256 "72d71d476482b8f98a8dcc9dba973a8bad92b18f2d7362cbea87fab865ae6660"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.7.0/umbragate_Darwin_x86_64.tar.gz"
      sha256 "e3f6fb6e733caa64eb6e7f2c50205e1cf4d0d1a4693c18d661e4f66240b27cc0"
    end
  end

  def install
    bin.install "umbragate"
    pkgshare.install "config.yaml"
  end

  service do
    run [opt_bin/"umbragate"]
    keep_alive true
    log_path var/"log/umbragate.log"
    error_log_path var/"log/umbragate.log"
  end

  def caveats
    <<~EOS
      Example config installed to:
        ~/.umbragate/config.yaml (created on first launch)

      Homebrew install stores config and database in:
        ~/.umbragate/

      Quick start:
        umbragate
        umbragate

      Background mode:
        brew services start umbragate
        # or
        umbragate -d
    EOS
  end

  test do
    output = shell_output("#{bin}/umbragate --help")
    assert_match "Usage: umbragate", output
  end
end
