-- WezTerm 配置
-- 路径: %LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\wezterm.lua
-- 或: $env:USERPROFILE\.config\wezterm\wezterm.lua
-- 对齐: Ghostty 配置（字体/主题/快捷键）

local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

-- ============================================
-- 1. 字体（对齐 Ghostty）
-- ============================================
M.font = wezterm.font("JetBrainsMono Nerd Font Mono")
M.font_size = 14
M.font_features = { "+liga", "+calt" }

-- ============================================
-- 2. 主题（对齐 Ghostty Catppuccin Mocha）
-- ============================================
M.color_scheme = "Catppuccin Mocha"
M.window_decorations = "RESIZE"
M.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- ============================================
-- 3. 行为（对齐 Ghostty）
-- ============================================
M.copy_on_select = "Clipboard"
M.default_cursor_style = "SteadyBlock"
M.cursor_blink_ease_in = "Constant"
M.cursor_blink_ease_out = "Constant"
M.audible_bell = "Disabled"
M.visual_bell = "Disabled"

-- ============================================
-- 4. 快捷键（对齐 Ghostty + 常用操作）
-- ============================================
M.keys = {
  -- 新建标签页
  { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("DefaultDomain") },
  -- 关闭标签页
  { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  -- 分屏
  { key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  -- Pane 导航
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  -- 标签页切换
  { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
  -- 复制/粘贴
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  -- 搜索
  { key = "r", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },
}

-- ============================================
-- 5. 标签页栏
-- ============================================
M.enable_tab_bar = true
M.hide_tab_bar_if_only_one_tab = false
M.use_fancy_tab_bar = false
M.tab_bar_at_bottom = true

-- ============================================
-- 6. 启动配置
# ============================================
M.default_prog = { "pwsh.exe" }
M.default_cwd = "$env:USERPROFILE"

return M
