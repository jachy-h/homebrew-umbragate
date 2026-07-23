class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.4.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.4/umbragate_Darwin_arm64.tar.gz"
      sha256 "8dd0d4f1803ff1047bf757b1983e8752f749518a018416714018131c99aca3fa"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.4/umbragate_Darwin_x86_64.tar.gz"
      sha256 "8130bcb57cb9a8099c1bb6fd5cd225dddaa37eb48602d62f3b4e1046d05442aa"
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
