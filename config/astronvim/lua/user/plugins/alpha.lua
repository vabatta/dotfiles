return {
  "goolord/alpha-nvim",
  cmd = "Alpha",
  opts = function()
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = {
      " ",
    }
    return dashboard
  end,
  config = require "plugins.configs.alpha",
}