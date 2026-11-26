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
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.4/md2html-macos-arm64.zip"
      sha256 "a8ae222aa7bf931cc0ddf967aa0ed8004611bbc5aa08a0b12dc2d28c69cae3df"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.4/md2html-macos-x64.zip"
      sha256 "eaa7d398dc44465da9fdfe652620c04a94198a154f6fbb14d81f4f831f8138f7"
    end
  end

  # Linux on x64 only: a release builds no Linux ARM binary, so Homebrew
  # on Linux ARM finds no URL and refuses, rather than install one that
  # cannot run there.
  on_linux do
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.4/md2html-linux-x64.zip"
      sha256 "960117b6debaf43f32195b9e624a91b81dc66c1d5b039b8e5ac40f75a0c8207a"
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
