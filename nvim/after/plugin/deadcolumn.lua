  require('deadcolumn').setup({
      scope = function()
          local max = 0
          for i = -50, 50 do
              local len = vim.fn.strdisplaywidth(vim.fn.getline(vim.fn.line('.') + i))
              if len > max then
                  max = len
              end
          end
          return max
      end
  })
