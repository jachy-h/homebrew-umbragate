class UmbraGate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.0/umbra-gate_Darwin_arm64.tar.gz"
      sha256 "REPLACE_WITH_DARWIN_ARM64_SHA256"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.0/umbra-gate_Darwin_x86_64.tar.gz"
      sha256 "REPLACE_WITH_DARWIN_AMD64_SHA256"
    end
  end

  def install
    bin.install "personal-ai-router" => "umbra-gate"
    pkgshare.install "config.example.yaml"
  end

  def caveats
    <<~EOS
      Example config installed to:
        #{pkgshare}/config.example.yaml

      Quick start:
        cp #{pkgshare}/config.example.yaml ./config.yaml
        export OPENAI_API_KEY=sk-xxxxx
        umbra-gate
    EOS
  end

  test do
    assert_match "flag provided but not defined", shell_output("#{bin}/umbra-gate --help", 1)
  end
end
