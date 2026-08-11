class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.7.1/umbragate_Darwin_arm64.tar.gz"
      sha256 "b3fed4884d1eb18f1eaa36abb8308c4fcc466f11d447194ab170378d7fdbecf1"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.7.1/umbragate_Darwin_x86_64.tar.gz"
      sha256 "3cd8769640b0234db1d2fd19b5aa756923d5d619bf4089d56f356ec05d9d0bc3"
    end
  end

  def install
    bin.install "umbragate"
    pkgshare.install "config.yaml"
  end

  service do
    run [opt_bin/"umbragate", "run"]
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
        umbragate start

      Foreground mode:
        umbragate run

      Background mode:
        brew services start umbragate
        # or
        umbragate start
    EOS
  end

  test do
    output = shell_output("#{bin}/umbragate --help")
    assert_match "Usage: umbragate", output
  end
end
