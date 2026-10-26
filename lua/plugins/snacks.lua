return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer or {}, {
        hidden = true,
        ignored = true,
        matcher = { sort_empty = false, fuzzy = false },
        sort = function(a, b)
          -- Always put directories first
          if a.dir and not b.dir then
            return true
          end
          if b.dir and not a.dir then
            return false
          end
          -- For same type (both dirs or both files), check if dotfiles
          local function is_dot(item)
            local name = (item.file or item.text or ""):match("([^/]+)$") or ""
            return name:sub(1, 1) == "."
          end
          local ad, bd = is_dot(a), is_dot(b)
          if ad ~= bd then
            return not ad -- non-dotfiles come first
          end
          local name_a = (a.file or a.text or ""):match("([^/]+)$") or ""
          local name_b = (b.file or b.text or ""):match("([^/]+)$") or ""
          return name_a:lower() < name_b:lower()
        end,
      })
      return opts
    end,
  },
}
