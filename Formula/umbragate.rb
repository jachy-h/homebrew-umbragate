class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.7.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.7.2/umbragate_Darwin_arm64.tar.gz"
      sha256 "8df21df5ed76a899ecb74c5e8aeab6e813f473c79a3c5e881f387d05a36cd2ed"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.7.2/umbragate_Darwin_x86_64.tar.gz"
      sha256 "4ad82c550b223d361418ad8b0c9086b9479d0f2cf5fa2d7c471a8ac08ae2fc29"
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
