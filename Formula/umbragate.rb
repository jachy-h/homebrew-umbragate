class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.1/umbragate_Darwin_arm64.tar.gz"
      sha256 "50b4b88f4e9aecba587155934e04d3a03ec452eb4256161e7c03f763b76cef0e"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.1/umbragate_Darwin_x86_64.tar.gz"
      sha256 "c07c2d9dacbe13b841e8c61890235fffe9dc23ab98f6d6a8dbbabd397234e12c"
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
