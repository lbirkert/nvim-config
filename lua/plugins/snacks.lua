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
      -- Set sort at picker level too
      opts.picker.sort = function(a, b)
        if a.dir ~= b.dir then
          return a.dir
        end
        if a.sort and b.sort and a.sort ~= b.sort then
          return a.sort < b.sort
        end
        local aname = (a.file or a.text or ""):match("([^/]+)$") or ""
        local bname = (b.file or b.text or ""):match("([^/]+)$") or ""
        local adot = aname:sub(1,1) == "."
        local bdot = bname:sub(1,1) == "."
        if adot ~= bdot then
          return not adot
        end
        return aname:lower() < bname:lower()
      end
      return opts
    end,
  },
}
