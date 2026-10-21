cask "tableplus" do
  # Do not update: this version is pinned because of licensing constraints.
  version "6.4.2"
  sha256 :no_check

  url "https://files.tableplus.com/macos/642/TablePlus.dmg"
  name "TablePlus"
  desc "Modern, native tool for database management"
  homepage "https://tableplus.com"

  app "TablePlus.app"
end
