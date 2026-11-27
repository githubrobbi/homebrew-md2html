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
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.6/md2html-macos-arm64.zip"
      sha256 "daf5f8745348d320533718ea97966e4573f5c1d8768038cb4cc108327b8bd50b"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.6/md2html-macos-x64.zip"
      sha256 "4708eb2f073e7fe03512e234855f013d5d293b4d9a10cc0bf9998e66a3a4784a"
    end
  end

  # Linux on x64 only: a release builds no Linux ARM binary, so Homebrew
  # on Linux ARM finds no URL and refuses, rather than install one that
  # cannot run there.
  on_linux do
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.6/md2html-linux-x64.zip"
      sha256 "db95d16fb32141c194630519c8fa9c57e5a489e9f31e1b01cdaae5f01d4ee99d"
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
