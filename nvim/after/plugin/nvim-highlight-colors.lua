-- Ensure termguicolors is enabled if not already
vim.opt.termguicolors = true

require('nvim-highlight-colors').setup({
    render = 'virtual',
    virtual_symbol = '⬤',
    enable_named_colors = true,
    enable_tailwind = true,

})

