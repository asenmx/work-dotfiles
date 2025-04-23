local rainbow_colors = {
    "#F28B82",
    "#FBBC04",
    "#CCFF90",
    "#A7FFEB",
    "#D7AEFB",
    "#FDCFE8",
    "#FFD6A5",
}


for i, color in ipairs(rainbow_colors) do
    vim.api.nvim_set_hl(0, "SnacksIndent" .. i, { fg = color, bold = true })
end
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
            .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            formats = {
                key = function(item)
                    return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
                end,
            },
            sections = {
                { section = "header" },
                { pane = 2, section = "terminal", cmd = "fortune -os | cowsay", ttl = 0, hl = "header", height = 17, padding = 1 },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                },
                { section = "startup" },

            },
        },
        indent = {
            indent = {
                enabled = true,       -- enable indent guides
                only_scope = false,   -- only show indent guides of the scope
                only_current = false, -- only show indent guides in the current window
                hl = {
                    "SnacksIndent1",
                    "SnacksIndent2",
                    "SnacksIndent3",
                    "SnacksIndent4",
                    "SnacksIndent5",
                    "SnacksIndent6",
                    "SnacksIndent7",
                    "SnacksIndent8",
                },
            },
            scope = {
                enabled = true, -- enable highlighting the current scope
                char = "▍",
            },
        },
        input = { enabled = true },
        picker = { enabled = true },
        notify = { enabled = true },
        git = { enabled = true },
        explorer = { enabled = true },
        image = { enabled = true },
        terminal = { enabled = true },
        notifier = {
            enabled = true,
            style = "fancy",
            timeout = 500,
        },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        toggle = { enabled = true },
        words = { enabled = true },
        scope = { enabled = true },

    },
    keys = {
        { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },

        { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
        { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
        { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
        -- { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
        { "<leader>gbl",     function() Snacks.git.blame_line() end,                                 desc = "Git Blame Line" },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "<c-CR>",          function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
        -- find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
        -- git
        { "<leader>gc",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
        { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
        { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
        { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
        { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
        { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
        { "<leader>qp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
    },
}
