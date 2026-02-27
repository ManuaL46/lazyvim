return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        vertical = "up:50%",
        layout = "vertical",
      },
    },
    grep = {
      rg_glob = true,
      rg_glob_fn = function(query, opts)
        local regex, flags = query:match("^(.-)%s%-%-(.*)$")
        return (regex or query), flags
      end,
    },
  },
}
