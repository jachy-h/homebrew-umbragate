class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.2/umbragate_Darwin_arm64.tar.gz"
      sha256 "e57b1769b43afb10b021a153b6f4d0ec4a756b2384b914366aef4a91f1de4775"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.4.2/umbragate_Darwin_x86_64.tar.gz"
      sha256 "d7b326c46e4cece417ee845bdf12b35d47d50c9bfd9d031a02dab3e14e91d0d0"
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
