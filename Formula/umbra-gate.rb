class UmbraGate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.2/umbra-gate_Darwin_arm64.tar.gz"
      sha256 "1bf6885fa63840acca24e67af5e0715dfce712379678a65855a94f2fbd3968bb"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.2/umbra-gate_Darwin_x86_64.tar.gz"
      sha256 "3562f0eed6d37046bedbc6ee49ad25ff98dcbcfe4fcdb198a57e4d2ef1a1aca5"
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
    output = shell_output("#{bin}/umbra-gate --help", 1)
    assert_match "flag provided but not defined", output
  end
end
