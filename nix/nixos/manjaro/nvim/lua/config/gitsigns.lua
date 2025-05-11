local M = {}

-- Only use after update to neovim 0.7
local function gitsigns_on_attach(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "GitSigns Stage Hunk" })
	map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "GitSigns Reset Hunk" })
	map("n", "<leader>hb", function()
		gs.blame_line({ full = true })
	end, { desc = "GitSigns Git Blame" })
	map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "GitSigns Toggle current blame line" })
	map("n", "<leader>hd", gs.diffthis, { desc = "GitSigns Git Diff" })
	map("n", "<leader>hD", function()
		gs.diffthis("~")
	end, { desc = "GitSigns Git Diff This" })
	map("n", "<leader>td", gs.toggle_deleted, { desc = "GitSigns Toggle deleted" })

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns select hunk" })
end

function M.setup()
	local gitsigns = require("gitsigns")
	gitsigns.setup({
		on_attach = gitsigns_on_attach,
	})
end
return M
