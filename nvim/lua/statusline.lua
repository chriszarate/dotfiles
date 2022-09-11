function get_count(name)
	return vim.lsp.diagnostic.get_count(0, name)
end

local statusline = ""
	.. " "
	.. "%f" -- current file relative to working directory
	.. " "
	.. "%h" -- help marker
	.. "%m" -- file modified marker
	.. "%=" -- align right
	.. "%#Search#"            -- change color
	.. "%#StatusLineNC#"      -- change color
	.. " "
	.. "%p%%"                 -- percentage scrolled
	.. " "
	.. "%l:%c"                -- line and column position
	.. " "

return statusline
