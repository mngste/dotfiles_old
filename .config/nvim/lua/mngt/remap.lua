local wk = require("which-key")
local builtin = require('telescope.builtin')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    local mappings = {
      g = {
        d = { vim.lsp.buf.definition, "Go to definition" },
        l = { vim.diagnostic.open_float, "Open diagnostic float" },
      },
      K = { vim.lsp.buf.hover, "Show hover information" },
      ["<leader>"] = {
        l = {
          name = "LSP",
          a = { vim.lsp.buf.code_action, "Code action" },
          r = { vim.lsp.buf.references, "References" },
          n = { vim.lsp.buf.rename, "Rename" },
          w = { vim.lsp.buf.workspace_symbol, "Workspace symbol" },
          d = { vim.diagnostic.open_float, "Open diagnostic float" },
        },
      },
      ["[d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
      ["]d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
    }

    which_key.add(mappings, opts)

    -- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    -- vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    -- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    -- vim.keymap.set('n', '<leader>lca', function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set('n', '<leader>lrr', function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set('n', '<leader>lrn', function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

    -- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = event.data.client_id }
      end

    })
  end,
})

local non_lsp_mappings = {
  ["<leader>"] = {
    e = { vim.cmd.Ex, "Open file explorer" },
    p = { "\"_dP", "Paste without overwrite" },
    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
    s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace word under cursor" },
    t = { ":Today<CR>", "Open today's note" },
  },
  J = { "mzJ`z", "Join lines and keep cursor position" },
  ["<C-d>"] = { "<C-d>zz", "Half page down and center" },
  ["<C-u>"] = { "<C-u>zz", "Half page up and center" },
  n = { "nzzzv", "Next search result and center" },
  N = { "Nzzzv", "Previous search result and center" },
  Q = { "<nop>", "Disable Ex mode" },
}

which_key.add(non_lsp_mappings)

-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- vim.keymap.set("n", "J", "mzJ`z")       -- Keep cursor in same position on line join
-- vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Keep cursor in middle on half page jump down
-- vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Keep cursor in middle on half page jump down
-- vim.keymap.set("n", "n", "nzzzv")       -- Keep searched term in middle
-- vim.keymap.set("n", "N", "Nzzzv")       -- Keep reverse searched term in middle
-- vim.keymap.set("n", "Q", "<nop>")       --- Just undo capital Q support
-- vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>t", ":Today<CR>")

wk.add({
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fb", function() print("hello") end, desc = "Foobar" },
  { "<leader>fn", desc = "New File" },
  { "<leader>f1", hidden = true }, -- hide this keymap
  { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  { "<leader>b", group = "buffers", expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})


