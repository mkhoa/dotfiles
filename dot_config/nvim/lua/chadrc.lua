-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "darcula-dark",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = true,
    lazyload = true,
    treeOffsetFt = "NvimTree",
    order = { "treeOffset", "buffers", "tabs" },
    modules = nil,
    bufwidth = 21,
  },

  statusline = {
    enabled = true,
    theme = "vscode", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  telescope = { style = "bordered" },
}

return M
