--[[

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- TODO:
-- consider also removing the buffer line???
--
--

vim.opt.expandtab = true

lvim.builtin.nvimtree.setup.view.width = 79;

lvim.builtin.telescope.defaults.path_display = { "truncate" }

-- general
lvim.log.level = "warn"
lvim.format_on_save = false

-- lvim.colorscheme = "kanagawa-dragon"
-- lvim.colorscheme = "tokyonight-night"
-- lvim.colorscheme = "nordic"
lvim.colorscheme = "kanagawa"

-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- vim.keymap.set('n', ',', "'")
vim.keymap.set('n', ',', function()
  local char = vim.fn.nr2char(vim.fn.getchar())
  if char:match('%l') then
    vim.cmd.normal("'" .. char:upper())
  else
    vim.cmd.normal("'" .. char)
  end
end)

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.layout_strategy = "vertical"
lvim.builtin.telescope.defaults.layout_config = {
	vertical = { width = 0.8, height = 0.8, prompt_position = "top", preview_height = 0.6 }
}

-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

vim.api.nvim_create_user_command('ToggleInlayHint', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end, {})

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings.g.h = { desc = "Open in github" }

lvim.builtin.which_key.mappings.l.h = { "<cmd>ToggleInlayHint<CR>", "Inlay Hints" }

lvim.builtin.which_key.mappings["m"] = { "<cmd>Telescope marks<CR>", "Marks" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.sync_root_with_cwd = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.update_focused_file = {
	enable = true,
	update_root = true
}
-- lvim.builtin.project.patterns = { ".git", "project.json", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" }
lvim.builtin.project.patterns = { ".git" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"sql",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"elixir",
	"gleam",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "<CR>",
		node_incremental = "<CR>",
		scope_incremental = "<TAB>",
		node_decremental = "<BS>",
	},
}
lvim.builtin.treesitter.textobjects.swap = {
	enable = true,
	swap_next = {
		["<leader>z"] = "@parameter.inner",
	},
	swap_previous = {
		["<leader>Z"] = "@parameter.inner",
	},
}

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
	"biome",
	"denols",
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }
--

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
	return server ~= "biome" and server ~= "denols"
end, lvim.lsp.automatic_configuration.skipped_servers)


local nvim_lsp = require('lspconfig')
nvim_lsp.denols.setup {
	root_dir = nvim_lsp.util.root_pattern("deno.json"),
}
nvim_lsp.tsserver.setup {
	root_dir = nvim_lsp.util.root_pattern("tsconfig.json"),
	single_file_support = false
}
nvim_lsp.postgres_lsp.setup {
	cmd = { "postgrestools", "lsp-proxy" },
	filetypes = { "sql" },
	root_dir = function(fname)
		return vim.fs.root(fname, { 'postgrestools.jsonc' })
	end,
	single_file_support = true,
}


-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- Not quite as nice as just starting based on root pattern
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local _nvim_lsp = require("lspconfig")
--   if _nvim_lsp.util.root_pattern("deno.json")(vim.fn.getcwd()) then
--       if client.name == "tsserver" then
--           client.stop()
--           return
--       end
--   end
-- end

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint_d",
--     filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
-- }
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{ command = "black", filetypes = { "python" } },
	{
		command = "prettier",
		filetypes = { "typescript", "html", "typescriptreact", "javascriptreact" }
	},
	-- {
	-- 	command = "biome",
	-- 	filetypes = { "typescript", "javascript" }
	-- },
	-- {
	--   command = "dprint",
	--   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact"  }
	-- },
	{
		command = "ocamlformat",
		filetypes = { "ocaml" }
	}
}

-- local null_ls = require("null-ls")
-- local protogetter = {
-- 	name = "protogetter",
-- 	method = null_ls.methods.DIAGNOSTICS,
-- 	filetypes = { "go" },
-- 	generator = {
-- 		async = true,
-- 		fn = function(_params, done)
-- 			if vim.fn.expand("%:t") ~= "service.go" then
-- 				done()
-- 				return
-- 			end

-- 			local stdout = vim.loop.new_pipe(false)
-- 			local stderr = vim.loop.new_pipe(false)
-- 			local diagnostics = {}

-- 			local handle
-- 			handle = vim.loop.spawn("protogetter", {
-- 				args = { "./..." },
-- 				stdio = { nil, stdout, stderr },
-- 			}, function()
-- 				if stdout then
-- 					stdout:close()
-- 				end
-- 				if stderr then
-- 					stderr:close()
-- 				end
-- 				if handle then
-- 					handle:close()
-- 				end
-- 				done(diagnostics)
-- 			end)

-- 			if stderr then
-- 				stderr:read_start(function(_, data)
-- 					if data then
-- 						for _, line in ipairs(vim.split(data, "\n", { trimempty = true })) do
-- 							local _, lnum, col, msg = line:match("([^:]+):(%d+):(%d+):%s*(.+)")
-- 							if lnum and col and msg then
-- 								table.insert(diagnostics, {
-- 									row = tonumber(lnum),
-- 									col = tonumber(col),
-- 									message = msg,
-- 									severity = vim.diagnostic.severity.WARN,
-- 									source = "protogetter",
-- 								})
-- 							end
-- 						end
-- 					end
-- 				end)
-- 			end
-- 		end,
-- 	},
-- }
-- null_ls.register(protogetter)

-- local go_new = {
-- 	name = "carl-test",
-- 	method = null_ls.methods.DIAGNOSTICS,
-- 	filetypes = { "go" },
-- 	generator = {
-- 		fn = function(params)
-- 			local bufnr = params.bufnr

-- 			local parser = vim.treesitter.get_parser(bufnr)
-- 			if not parser then
-- 				vim.lsp.log.error("No treesitter parser found")
-- 				return {}
-- 			end

-- 			local tree = parser:trees()[1]
-- 			if not tree then
-- 				vim.lsp.log.error("No syntax tree found")
-- 				return {}
-- 			end

-- 			local root = tree:root()
-- 			print("Root node type:", root:type())


-- 			local diagnostics = {}

-- 			local function check_node(node)
-- 				if node:type() == "identifier" then
-- 					local text = vim.treesitter.get_node_text(node, bufnr)
-- 					if text:find("Id") then
-- 						local start_row, start_col, end_row, end_col = node:range()
-- 						table.insert(diagnostics, {
-- 							row = start_row + 1,
-- 							col = start_col,
-- 							end_row = end_row + 1,
-- 							end_col = end_col,
-- 							source = "IdVariableCheck",
-- 							message = "Variable name contains 'Id', consider renaming",
-- 							severity = vim.diagnostic.severity.INFO
-- 						})
-- 					end
-- 				end

-- 				for child in node:iter_children() do
-- 					check_node(child)
-- 				end
-- 			end

-- 			check_node(root)

-- 			return diagnostics
-- 		end
-- 	}
-- }

-- if not null_ls.is_registered(go_new)
-- then
-- 	null_ls.register(go_new)
-- end

lvim.builtin.which_key.mappings["o"] = {
	name = "open ai",
}
lvim.builtin.which_key.vmappings["o"] = {
	name = "open ai",
}
local existing_o_mappings = lvim.builtin.which_key.mappings["o"]

-- Additional Plugins
lvim.plugins = {
	{ "lunarvim/colorschemes" },
	{ "rebelot/kanagawa.nvim" },
	{ "jbyuki/venn.nvim" },
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "AlexvZyl/nordic.nvim" },
	{ "shaunsingh/nord.nvim" },
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require('tsc').setup()
		end
	},
	{ "ruanyl/vim-gh-line" },
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				menu = {
					width = math.min(vim.api.nvim_win_get_width(0) - 4, 120),
				},
			})

			lvim.builtin.which_key.mappings["a"] = { function() harpoon:list():add() end, "Harpoon mark" }

			vim.keymap.set("n", "<M-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
			vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
		end,
	},
	{
		dir = '/home/carl/.config/lvim',
		name = 'llm',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local system_prompt =
			'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
			local helpful_prompt =
			'You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful.'

			local llm = require('llm')

			local function claude_replace()
				llm.invoke_llm_and_stream_into_editor(
					{
						url = 'https://api.anthropic.com/v1/messages',
						model = 'claude-3-5-sonnet-20241022', -- TODO: use 3.7
						api_key_name = 'CLAUDE_API_KEY',
						system_prompt = system_prompt,
						replace = true,
					},
					llm.make_anthropic_spec_curl_args,
					llm.handle_anthropic_spec_data
				)
			end

			local function openai_replace()
				llm.invoke_llm_and_stream_into_editor({
					url = 'https://api.openai.com/v1/chat/completions',
					model = 'o4-mini',
					api_key_name = 'OPENAI_API_KEY',
					system_prompt = system_prompt,
					replace = true,
				}, llm.make_openai_spec_curl_args, llm.handle_openai_spec_data)
			end

			local function openai_help()
				llm.invoke_llm_and_stream_into_editor({
					url = 'https://api.openai.com/v1/chat/completions',
					model = 'o4-mini',
					api_key_name = 'OPENAI_API_KEY',
					system_prompt = helpful_prompt,
					replace = false,
				}, llm.make_openai_spec_curl_args, llm.handle_openai_spec_data)
			end

			existing_o_mappings.h = { function() openai_help() end, "help" }
			existing_o_mappings.r = { function() openai_replace() end, "openai-replace" }
			existing_o_mappings.c = { function() claude_replace() end, "claude-replace" }

			for k, v in pairs(existing_o_mappings) do
				lvim.builtin.which_key.vmappings["o"][k] = v
				lvim.builtin.which_key.mappings["o"][k] = v
			end
		end,
	},
	-- {
	-- 	dir = '~/oss/otter.nvim',
	-- 	dependencies = {
	-- 		'nvim-treesitter/nvim-treesitter',
	-- 	},
	-- 	opts = {
	-- 		lsp = {
	-- 			diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
	-- 			root_dir = function(_, bufnr)
	-- 				return vim.fs.root(bufnr or 0, {
	-- 					".git",
	-- 					"_quarto.yml",
	-- 					"package.json",
	-- 				}) or vim.fn.getcwd(0)
	-- 			end,
	-- 		},
	-- 		debug = false,
	-- 		buffers = {
	-- 			-- if  to true, the filetype of the otterbuffers will be set.
	-- 			-- otherwise only the autocommand of lspconfig that attaches
	-- 			-- the language server will be executed without setting the filetype
	-- 			set_filetype = true,
	-- 			-- write <path>.otter.<embedded language extension> files
	-- 			-- to disk on save of main buffer.
	-- 			-- usefule for some linters that require actual files.
	-- 			-- otter files are deleted on quit or main buffer close
	-- 			write_to_disk = true,
	-- 			-- a table of preambles for each language. The key is the language and the value is a table of strings that will be written to the otter buffer starting on the first line.
	-- 			preambles = {},
	-- 			-- a table of postambles for each language. The key is the language and the value is a table of strings that will be written to the end of the otter buffer.
	-- 			postambles = {},
	-- 			-- A table of patterns to ignore for each language. The key is the language and the value is a lua match pattern to ignore.
	-- 			-- lua patterns: https://www.lua.org/pil/20.2.html
	-- 			ignore_pattern = {
	-- 				-- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
	-- 				python = "^(%s*[%%!].*)",
	-- 			},
	-- 		},
	-- 	}
	-- },
}

local otter_enabled = false;
vim.api.nvim_create_autocmd("InsertEnter", {
	group = vim.api.nvim_create_augroup("otter-autostart", { clear = true }),
	pattern = { "*.go" },
	callback = function(opts)
		if not otter_enabled then
			return
		end

		local bufnr = opts.buf

		local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
		if not ok then
			vim.notify("No treesitter parser available for buffer")
			return
		end

		vim.notify("Have parser, checking language")

		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		line = line - 1

		local lang_tree = parser:language_for_range({ line, col, line, col + 1 })
		vim.notify(vim.inspect(lang_tree:lang()))
		if not lang_tree then
			vim.notify("No language tree at cursor position")
			return
		end

		local lang = lang_tree:lang()
		vim.notify("Language detected: " .. lang)

		local otter = require("otter")
		local extensions = require("otter.tools.extensions")

		if extensions[lang] then
			otter.activate()
		end
	end
})

existing_o_mappings.a = { "<cmd>lua require('otter').activate()<CR>", "Otter Activate" }

for k, v in pairs(existing_o_mappings) do
	lvim.builtin.which_key.vmappings["o"][k] = v
	lvim.builtin.which_key.mappings["o"][k] = v
end

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

lvim.builtin.cmp.formatting.source_names["uuid"] = "(Uuid)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "uuid" })
local cmp = require "cmp"
local uuid = require "uuid"
cmp.register_source("uuid", uuid)
