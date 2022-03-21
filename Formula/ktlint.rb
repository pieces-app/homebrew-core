class Ktlint < Formula
  desc "Anti-bikeshedding Kotlin linter with built-in formatter"
  homepage "https://ktlint.github.io/"
  url "https://github.com/pinterest/ktlint/releases/download/0.45.1/ktlint"
  sha256 "7c430b67c955d5134595fe40a5f24e1bd8c8f09ba6a603faef7f9748e5a0b0a2"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "c84b5bc772ed74e03f82c4ccf2180bfee4db7ca8120d9df3da20213e74fefa1c"
  end

  depends_on "openjdk@11"

  def install
    libexec.install "ktlint"
    (libexec/"ktlint").chmod 0755
    (bin/"ktlint").write_env_script libexec/"ktlint",
                                    Language::Java.java_home_env("11").merge(
                                      PATH: "#{Formula["openjdk@11"].opt_bin}:${PATH}",
                                    )
  end

  test do
    (testpath/"In.kt").write <<~EOS
      fun main( )
    EOS
    (testpath/"Out.kt").write <<~EOS
      fun main()
    EOS
    system bin/"ktlint", "-F", "In.kt"
    assert_equal shell_output("cat In.kt"), shell_output("cat Out.kt")
  end
end
