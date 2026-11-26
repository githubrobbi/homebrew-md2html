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
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.5/md2html-macos-arm64.zip"
      sha256 "7cfab2fa5f85a24676f5487660d27a4b665fd7da105fe3d1b5cea957398dbd29"
    end
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.5/md2html-macos-x64.zip"
      sha256 "9a7459aed7f0dc7f926e381dc8d802856b63e1d66acbb9907d441e1c69f4ed73"
    end
  end

  # Linux on x64 only: a release builds no Linux ARM binary, so Homebrew
  # on Linux ARM finds no URL and refuses, rather than install one that
  # cannot run there.
  on_linux do
    on_intel do
      url "https://github.com/githubrobbi/md2html/releases/download/v0.8.5/md2html-linux-x64.zip"
      sha256 "4edb0e139517f5913007f8a5cf657bab784743864447104057ee5f9f1007e198"
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
