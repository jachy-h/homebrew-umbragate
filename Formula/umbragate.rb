class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.3/umbragate_Darwin_arm64.tar.gz"
      sha256 "e6c40db5deb6b5b9e0517adaf157e3a5aab042507a24a46eb91a2aa495bc0772"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.3/umbragate_Darwin_x86_64.tar.gz"
      sha256 "7c4cb812852a16795c75b9e560086b14a24a752e618cd16fe9fbbb7e494bb593"
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
