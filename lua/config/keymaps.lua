-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Make going forward and backward have the cursor at the center
-- vim.keymap.set("n", "<C-f>", "<C-f>zz")
-- vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Keymap for Undotree
vim.keymap.set("n", "<leader>y", "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undotree" })

-- Copy filepaths to clipboard
vim.keymap.set("n", "<leader>fy", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%"))
end, { desc = "Copy relative file path to clipboard" })

vim.keymap.set("n", "<leader>fY", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%:p"))
end, { desc = "Copy absolute file path to clipboard" })

-- vim.keymap.set("n", "Z", function()
--   local hovercraft = require("hovercraft")
--
--   if hovercraft.is_visible() then
--     hovercraft.enter_popup()
--   else
--     hovercraft.hover()
--   end
-- end, { desc = "Better Hover" })
--
-- -- Neogit
-- vim.keymap.set("n", "<leader>G", function()
--   require("neogit").open()
-- end, { desc = "Neogit" })
--

-- Adele workspace keymaps
-- Longass keymap to filter adl_ls_co output and show files in fzf-lua
vim.keymap.set("n", "<leader>as", function()
  local paths = {}
  local succeeded, result = pcall(function()
    return vim.system({ "adl_ls_co" }, { text = true }):wait()
  end)
  if not succeeded then
    vim.notify("Failed to invoke adl_ls_co command", vim.log.levels.WARN)
    return
  end

  if result.stdout then
    local path_strings = result.stdout:match("^[^\n]*\n?(.*)")

    if not string.match(path_strings, "\\") then
      vim.notify("No files are checked out in current workspace", vim.log.levels.INFO)
      return
    end

    path_strings = string.gsub(path_strings, "%s*%(private%)%.", "")
    path_strings = string.gsub(path_strings, "%s*%(public%)%.", "")
    for str in path_strings:gmatch("[^\n]+") do
      string.gsub(str, "\n", "")
      table.insert(paths, str)
    end
  end

  local fzf = require("fzf-lua")
  fzf.fzf_exec(paths, {
    prompt = "Checked Out Files> ",
    actions = {
      ["default"] = function(selected)
        for _, file in ipairs(selected) do
          vim.cmd("edit " .. vim.fn.fnameescape(file))
        end
      end,
    },
    multi = true,
  })
end, { desc = "Show all checked out files" })

-- vim.keymap.set("n", "<leader>av", "<cmd>!adl_mk_priv %:p<cr>", { desc = "Privately check out" })
vim.keymap.set("n", "<leader>av", function()
  local succeeded, result = pcall(function()
    return vim.system({ "adl_mk_priv", vim.api.nvim_buf_get_name(0) }, { text = true }):wait()
  end)
  if succeeded and result.code == 0 then
    vim.notify("File has been privately checked out", vim.log.levels.INFO)
    vim.cmd("edit")
  else
    vim.notify("Failed to invoke adl_mk_priv command", vim.log.levels.WARN)
    if result and result.stdout then
      vim.notify(result.stdout, vim.log.levels.WARN)
    end
  end
end, { desc = "Privately check out" })

-- vim.keymap.set("n", "<leader>af", "<cmd>!adl_rm_priv %:p<cr>", { desc = "Privately uncheck out" })
vim.keymap.set("n", "<leader>af", function()
  local succeeded, result = pcall(function()
    return vim.system({ "adl_rm_priv", vim.api.nvim_buf_get_name(0) }, { text = true }):wait()
  end)
  if succeeded and result.code == 0 then
    vim.notify("File has been privately unchecked out", vim.log.levels.INFO)
    vim.cmd("edit")
  else
    vim.notify("Failed to invoke adl_rm_priv command", vim.log.levels.WARN)
    if result and result.stdout then
      vim.notify(result.stdout, vim.log.levels.WARN)
    end
  end
end, { desc = "Privately uncheck out" })

-- vim.keymap.set("n", "<leader>ac", "<cmd>!adl_co %:p<cr>", { desc = "Publicly check out" })
vim.keymap.set("n", "<leader>ac", function()
  local succeeded, result = pcall(function()
    return vim.system({ "adl_co", vim.api.nvim_buf_get_name(0) }, { text = true }):wait()
  end)
  if succeeded and result.code == 0 then
    vim.notify("File has been publicly checked out", vim.log.levels.INFO)
    vim.cmd("edit")
  else
    vim.notify("Failed to invoke adl_co command", vim.log.levels.WARN)
    if result and result.stdout then
      vim.notify(result.stdout, vim.log.levels.WARN)
    end
  end
end, { desc = "Publicly check out" })

-- vim.keymap.set("n", "<leader>ad", "<cmd>!adl_unco %:p<cr>", { desc = "Publicly uncheck out" })
vim.keymap.set("n", "<leader>ad", function()
  local succeeded, result = pcall(function()
    return vim.system({ "adl_unco", vim.api.nvim_buf_get_name(0) }, { text = true }):wait()
  end)
  if succeeded and result.code == 0 then
    vim.notify("File has been publicly unchecked out", vim.log.levels.INFO)
    vim.cmd("edit")
  else
    vim.notify("Failed to invoke adl_unco command", vim.log.levels.WARN)
    if result and result.stdout then
      vim.notify(result.stdout, vim.log.levels.WARN)
    end
  end
end, { desc = "Publicly uncheck out" })
