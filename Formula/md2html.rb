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
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.0/md2html-macos-arm64.zip"
      sha256 "67c388d48fd6a20ce0d4f00a22bebab04d33c48a4393c73d1ada32f4c43e48f0"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.0/md2html-macos-x64.zip"
      sha256 "454f21bccf4ae6d6dbcf0065b94676759c208d1cb3cfde6428c66a36a5e10eb0"
    end
  end

  # Linux on x64 only: a release builds no Linux ARM binary, so Homebrew
  # on Linux ARM finds no URL and refuses, rather than install one that
  # cannot run there.
  on_linux do
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.0/md2html-linux-x64.zip"
      sha256 "81339a4d5ced29d07e07d2e66a13f2b829c414efe119c9f2534cab43f15e03b2"
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
