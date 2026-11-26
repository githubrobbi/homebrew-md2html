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
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.1/md2html-macos-arm64.zip"
      sha256 "2d6ef00de21d8c654b8f4dcc97b54705944c90191c144af3bd8a88a3db36c626"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.1/md2html-macos-x64.zip"
      sha256 "3926dd7e63dc5530e80de3e97735854f374d09b96e2d7d85cb2dc9e3c1f613d7"
    end
  end

  # Linux on x64 only: a release builds no Linux ARM binary, so Homebrew
  # on Linux ARM finds no URL and refuses, rather than install one that
  # cannot run there.
  on_linux do
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.1/md2html-linux-x64.zip"
      sha256 "a4344e6e15c09aa8a063c3a3b862f5b8fd0ffda66e5e801a9832635e2869d04c"
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
