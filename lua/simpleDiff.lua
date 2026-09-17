-- Create a command that prompts for input and switches to the chosen buffer
vim.api.nvim_create_user_command("DiffWithBuffer", function()
    vim.cmd("echo '' | ls")

    -- 2. Prompt the user for a buffer number or name with Tab-completion
    local buf = vim.fn.input("Enter buffer number or name: ", "", "buffer")

    -- If the user entered something, execute the buffer switch command and windo diffthis.
    if buf ~= "" then
        vim.cmd("vertical sbuffer " .. buf)
        local diff_win = vim.api.nvim_get_current_win()
        vim.cmd("windo diffthis")
        vim.api.nvim_set_current_win(diff_win)
    end
end, {})

-- Shortcut mapping to trigger the command
vim.keymap.set("n", "<leader>dc", ":DiffWithBuffer<CR>", { desc = "[D]iff with [B]uffer -- use :q to close diff -- not well designed avoid using it!!" })
