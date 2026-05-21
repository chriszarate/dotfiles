-- Statusline

_G.zzz = _G.zzz or {}

function _G.zzz.StatuslineActive()
	local head = vim.fn.FugitiveHead()
	local count = vim.diagnostic.count(0)

	if head ~= "" then
		head = "%#GitStatus# " .. head .. " "
	end

	local msgs = {}
	local diag = ""

	if count[vim.diagnostic.severity.ERROR] then
		table.insert(msgs, "x" .. count[vim.diagnostic.severity.ERROR])
	end
	if count[vim.diagnostic.severity.WARN] then
		table.insert(msgs, "!" .. count[vim.diagnostic.severity.WARN])
	end
	if count[vim.diagnostic.severity.INFO] then
		table.insert(msgs, "*" .. count[vim.diagnostic.severity.INFO])
	end

	if #msgs > 0 then
		diag = "%#IncSearch# " .. table.concat(msgs, " ") .. " "
	end

	return " %f %h%m%=" .. diag .. head .. "%#Position# %p%% %l:%c "
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.zzz.StatuslineActive()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        vim.opt_local.statusline = " %t"
    end,
})

vim.api.nvim_set_hl(0, "GitStatus", { fg = "#928374", bg = "#3c3836" })
vim.api.nvim_set_hl(0, "Position", { fg = "#928374", bg = "#282828" })

vim.opt.laststatus = 2
