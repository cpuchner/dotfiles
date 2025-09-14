local Job          = require("plenary.job")
local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local conf         = require("telescope.config").values
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M            = {}
M.owner            = "eucalyptusvc"
M.dir              = "~/dev"

local function build_entries(json)
  local ok, rows = pcall(vim.json.decode, json)
  if not ok or type(rows) ~= "table" then
    return {
      {
        value = {},
        ordinal = json,
        display = "⚠ gh output parse error",
        text = "⚠ gh output parse error",
        lnum = 1,
        col = 1,
      },
    }
  end

  local entries = {}
  for _, item in ipairs(rows) do
    local repo = "?"
    local r = item.repository
    if type(r) == "string" then
      repo = r
    elseif type(r) == "table" then
      repo = r.fullName or r.nameWithOwner or r.name or "?"
    end

    repo = tostring(repo):gsub("^" .. M.owner .. "/", "")

    local frag = nil
    if type(item.textMatches) == "table" and item.textMatches[1] then
      frag = item.textMatches[1].fragment or item.textMatches[1].text
    end
    frag = frag or (item.path or "<no snippet>")
    frag = (frag:gsub("\n", " "))

    local filename = item.path
    local lnum = tonumber(item.lineNumber or item.startLine or item.line) or 1
    local col = tonumber(item.column or item.startColumn or item.col) or 1

    local dir = ""
    local path = item.path
    if path and repo and repo ~= "?" then
      local home = vim.env.HOME or vim.fn.expand("~")
      path = home .. "/dev/" .. repo .. "/" .. path
      dir = home .. "/dev/" .. repo
    end

    table.insert(entries, {
      value    = repo,
      dir      = dir,
      repo     = repo,
      path     = path,
      filename = filename, -- quickfix filename
      lnum     = lnum, -- quickfix line
      col      = col, -- quickfix column
      text     = frag, -- quickfix text
      ordinal  = table.concat({ repo, path or "", frag }, " "),
      display  = string.format("%s — %s", repo, frag), -- repository with textMatches[0] as the display
    })
  end
  return entries
end

function M.hrllo()
  local base_args = { "search", "code", "--owner=" .. M.owner, "--json=" .. "repository,path,textMatches", "--limit=200" }

  local picker
  picker = pickers.new({}, {
    prompt_title = "GitHub Code Search (" .. M.owner .. ")",
    finder = finders.new_table({
      results = {}, -- starts empty; we fill it after <CR>
      entry_maker = function(x) return x end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(bufnr, map)
      local function run_search()
        local query = action_state.get_current_line()
        if not query or query == "" then return end

        local args = vim.deepcopy(base_args)
        table.insert(args, query)

        Job:new({
          command = "gh",
          args = args,
          on_exit = function(j, code)
            vim.schedule(function()
              if code ~= 0 then
                local err = table.concat(j:stderr_result(), "\n")
                picker:refresh(finders.new_table({
                  results = { { value = {}, ordinal = err, display = "gh failed — press q to close" } },
                  entry_maker = function(x) return x end
                }), { reset_prompt = false })
                return
              end
              local out = table.concat(j:result(), "\n")
              local rows = build_entries(out)
              picker:refresh(finders.new_table({ results = rows, entry_maker = function(x) return x end }),
                { reset_prompt = false })
            end)
          end,
        }):start()
      end

      -- Press Enter to call the endpoint with the current prompt text
      map("i", "<C-o>", run_search)
      map("n", "<C-o>", run_search)

      -- Optional: open selected hit in browser with <C-o>
      -- local function open_in_browser()
      --   local entry = action_state.get_selected_entry()
      --   if not entry then return end
      --   local repo = entry.repo or "?"
      --   local path = entry.path or ""
      --   local url = string.format("https://github.com/%s/blob/HEAD/%s", repo, path)
      --   vim.ui.open(url)
      -- end
      -- map("i", "<C-o>", open_in_browser)
      -- map("n", "<C-o>", open_in_browser)

      actions.select_default:replace(function()
        actions.close(bufnr)
        local selection = action_state.get_selected_entry()
        if not selection then
          return
        end
        -- vim.notify(vim.inspect(selection))
        vim.api.nvim_set_current_dir(selection.dir)
        if selection.filename and selection.filename ~= "" then
          vim.cmd("edit " .. vim.fn.fnameescape(selection.filename))
          vim.api.nvim_win_set_cursor(0, { 1, 1 })
          vim.fn.search("\\<query\\>")
        end
      end)

      return true
    end,
  })

  picker:find()
end

return M
