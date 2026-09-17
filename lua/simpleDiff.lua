-- Create a command that prompts for input and switches to the chosen buffer
vim.api.nvim_create_user_command("DiffWithBuffer", function()
    vim.cmd("echo '' | ls")

    -- 2. Prompt the user for a buffer number or name with Tab-completion
    local buf = vim.fn.input("Enter buffer number or name: ", "", "buffer")

    -- If the user entered something, execute the buffer switch command and windo diffthis.
    if buf ~= "" then
        vim.cmd("vertical sbuffer " .. buf)
        vim.cmd("windo diffthis")
    end
end, {})

-- Shortcut mapping to trigger the command
vim.keymap.set("n", "<leader>dc", ":DiffWithBuffer<CR>", { desc = "[D]iff with [B]uffer -- avoid not well designed" })
