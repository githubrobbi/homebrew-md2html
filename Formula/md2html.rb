# SPDX-License-Identifier: MIT OR Apache-2.0
# Copyright (c) 2026 Sky, LLC
#
# md2html's Homebrew formula. brew-publish.yml writes it for each release
# from the template packaging/homebrew/md2html.rb in githubrobbi/md2html,
# with the release's URLs and SHA-256s, and pushes it to the tap: change
# it there, not in the tap. The version is read from the URLs (`vX.Y.Z`).
class Md2html < Formula
  desc "Markdown in, one complete web page out"
  homepage "https://github.com/githubrobbi/md2html"
  license all_of: [
    { any_of: ["MIT", "Apache-2.0"] },
    "BSD-3-Clause",
  ]

  on_macos do
    on_arm do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.7/md2html-macos-arm64.zip"
      sha256 "599bbf6b92163bef79d30086e0bc46dde2f718d15081abbda3a03b031fa98434"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.7/md2html-macos-x64.zip"
      sha256 "1586cbfb59ab6fc184688525c3593541b1fa06c6074668030e5f551b5ccf9213"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.7/md2html-linux-arm64.zip"
      sha256 "c37b3e8ffd30c45eed3a169d4f5337ddb210a8ae86f3de5f1e2c1cec87ac410e"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.7/md2html-linux-x64.zip"
      sha256 "d87f83eb8d21276da1bf5ccef61ca494ff8ccf32469059e8a6da7bdaa62de5f2"
    end
  end

  def install
    # The ZIP's single root directory holds the binary plus both licence
    # texts, NOTICE, README and CHANGELOG (release.yml's stage_bundle).
    bin.install "md2html"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/md2html --version")
  end
end
