local ok, telescope = pcall(require, "telescope")
if not ok then
  error("telescope-hrllo.nvim requires nvim-telescope/telescope.nvim")
end

return telescope.register_extension({
  setup = function(ext_config, _)
    local picker = require("telescope_hrllo.picker")
    if ext_config.owner then picker.owner = ext_config.owner end
    if ext_config.dir then picker.dir = ext_config.dir end
  end,
  exports = {
    hrllo = function()
      return require("telescope_hrllo.picker").hrllo()
    end,
  },
})
