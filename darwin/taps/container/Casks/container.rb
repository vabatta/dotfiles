cask "container" do
  version "1.3.0"
  sha256 "bd156250cb84061367ed4b0eeef52211b6a825c6e0728a9426e57602ddb089c1"

  url "https://github.com/apple/container/releases/download/#{version}/container-#{version}-installer-signed.pkg"
  name "container"
  desc "Run Linux containers as lightweight virtual machines on Apple silicon"
  homepage "https://github.com/apple/container"

  pkg "container-#{version}-installer-signed.pkg"

  uninstall pkgutil: "com.apple.container-installer"
end
