return {
  -- Using community fork (actively maintained, supports blink.cmp)
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/vaults/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/vaults/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/vaults/notes",
      },
    },

    -- Daily notes config (great for D&D session logs)
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      template = "daily.md",
    },

    -- How new note IDs are generated
    note_id_func = function(title)
      -- Use title as filename, or timestamp if no title
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        return tostring(os.time())
      end
    end,

    -- Where new notes go by default
    new_notes_location = "current_dir",

    -- Wiki link style [[note]] instead of [note](note.md)
    preferred_link_style = "wiki",

    -- Completion (auto-detects blink.cmp)
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },

    -- Templates
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Don't manage frontmatter automatically (keep notes clean)
    disable_frontmatter = true,

    -- Open URLs in browser
    follow_url_func = function(url)
      vim.fn.jobstart({ "xdg-open", url })
    end,
  },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Open note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
    { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links in note" },
    { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Search tags" },
    { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
    { "<leader>oi", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    -- Visual mode: create link from selection
    { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Create link", mode = "v" },
    { "<leader>oe", "<cmd>ObsidianExtractNote<cr>", desc = "Extract to note", mode = "v" },
  },
}
