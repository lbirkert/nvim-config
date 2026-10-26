return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer or {}, {
        hidden = true,
        ignored = true,
        sort = function(a, b)
          -- Folders first
          if a.dir ~= b.dir then
            return a.dir
          end
          -- Same type, use the custom sort key
          if a.sort and b.sort then
            if a.sort ~= b.sort then
              return a.sort < b.sort
            end
          end
          -- Fallback to name
          local aname = (a.file or ""):match("([^/]+)$") or ""
          local bname = (b.file or ""):match("([^/]+)$") or ""
          return aname:lower() < bname:lower()
        end,
      })
      return opts
    end,
  },
}
