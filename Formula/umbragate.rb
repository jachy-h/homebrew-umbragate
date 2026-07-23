class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.0/umbragate_Darwin_arm64.tar.gz"
      sha256 "5c351df52bfb3faf09441bff29c3fa08bbc81e01b5a4abedbbc3e51b5b95d4b0"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.0/umbragate_Darwin_x86_64.tar.gz"
      sha256 "c9f89182cad30691bb83aa0f0791a4b97edfb773458c6af7c231ba4319259fed"
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
