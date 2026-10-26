return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer or {}, {
        hidden = true,
        ignored = true,
      })
      return opts
    end,
    init = function()
      local Tree = require("snacks.explorer.tree")
      function Tree:walk(node, fn, opts)
        local abort = false
        abort = fn(node)
        if abort ~= nil then
          return abort
        end
        local children = vim.tbl_values(node.children)
        table.sort(children, function(a, b)
          if a.dir ~= b.dir then
            return a.dir
          end
          local ad = a.name:sub(1, 1) == "."
          local bd = b.name:sub(1, 1) == "."
          if ad ~= bd then
            return not ad
          end
          return a.name < b.name
        end)
        for c, child in ipairs(children) do
          child.last = c == #children
          abort = false
          if child.dir and (child.open or (opts and opts.all)) then
            abort = self:walk(child, fn, opts)
          else
            abort = fn(child)
          end
          if abort then
            return true
          end
        end
        return false
      end
    end,
  },
}
