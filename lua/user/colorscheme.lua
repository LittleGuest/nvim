-- 主题颜色配置
-- :help colorscheme


-- 设置默认主题
local colorscheme = "darkplus"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- if colorscheme == "onedark" then
--   require "user.themes.onedark"
-- elseif colorscheme == "catppuccin" then
--   require "user.themes.catppuccin"
-- end
