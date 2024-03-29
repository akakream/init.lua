local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf',
    function()
        builtin.find_files({
            file_ignore_patterns = {"vendor"},
        })
    end,
{})

vim.keymap.set('n', '<C-p>',
    function()
        builtin.git_files({
            file_ignore_patterns = {"vendor"},
        })
    end,
{})

vim.keymap.set('n', '<leader>ps',
    function()
        builtin.grep_string({
            search = vim.fn.input("Grep > "),
            file_ignore_patterns = {"vendor"},
        })
    end
)

vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
