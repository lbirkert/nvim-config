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
      })
      -- Override the default sort for all pickers? Or specifically for explorer
      local orig_sort = opts.picker.sort
      opts.picker.sort = function(a, b)
        -- Check if this is explorer items
        if (a.dir ~= nil or b.dir ~= nil) and (a.file or b.file) then
          if a.dir ~= b.dir then
            return a.dir
          end
          local function is_dot(item)
            local name = ""
            if item.file then
              name = item.file:match("([^/]+)$") or ""
            elseif item.text then
              name = item.text:match("([^/]+)$") or ""
            end
            return name ~= "" and name:sub(1, 1) == "."
          end
          local ad, bd = is_dot(a), is_dot(b)
          if ad ~= bd then
            return not ad
          end
        end
        if orig_sort then
          return orig_sort(a, b)
        end
        if a.sort and b.sort and a.sort ~= b.sort then
          return a.sort < b.sort
        end
        local name_a = (a.file or a.text or ""):match("([^/]+)$") or ""
        local name_b = (b.file or b.text or ""):match("([^/]+)$") or ""
        return name_a:lower() < name_b:lower()
      end
      return opts
    end,
  },
}
