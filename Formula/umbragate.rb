class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.6.0/umbragate_Darwin_arm64.tar.gz"
      sha256 "da0ba3ad33450c0d42e2c58aee9ea05ef73f36c323e91c2fd4fe41d82ca2ed1f"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.6.0/umbragate_Darwin_x86_64.tar.gz"
      sha256 "dc5ee5560cdbb0b5f0e1047a70b1c3909d703c0af3f6abd75dfe9e7d03d3b8e0"
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
