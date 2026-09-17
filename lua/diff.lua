local map = vim.keymap.set
local sessions = {}

local function close_session(tabpage)
  local session = sessions[tabpage]
  if not session then
    return false
  end

  sessions[tabpage] = nil

  local source_valid = vim.api.nvim_win_is_valid(session.source_win)
  local compared_valid = vim.api.nvim_win_is_valid(session.compared_win)

  if source_valid then
    vim.wo[session.source_win].diff = false
  end
  if compared_valid then
    vim.wo[session.compared_win].diff = false
  end

  if compared_valid and #vim.api.nvim_tabpage_list_wins(tabpage) > 1 then
    vim.api.nvim_win_close(session.compared_win, false)
  end

  if source_valid and vim.api.nvim_get_current_tabpage() == tabpage then
    vim.api.nvim_set_current_win(session.source_win)
  end

  return true
end

-- Diff current buffer with another open buffer
map("n", "<leader>db", function()
  local tabpage = vim.api.nvim_get_current_tabpage()
  close_session(tabpage)

  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()

  local buffers = vim.tbl_filter(function(buf)
    return buf ~= current_buf
      and vim.api.nvim_buf_is_loaded(buf)
      and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if #buffers == 0 then
    vim.notify("No other listed buffers to diff", vim.log.levels.INFO)
    return
  end

  vim.ui.select(buffers, {
    prompt = "Diff with buffer",
    format_item = function(buf)
      local name = vim.api.nvim_buf_get_name(buf)
      return vim.fn.fnamemodify(name ~= "" and name or "[No Name]", ":~:.")
    end,
  }, function(buf)
    if not buf then
      return
    end
    if not vim.api.nvim_win_is_valid(current_win) or not vim.api.nvim_buf_is_valid(buf) then
      vim.notify("The selected diff window or buffer is no longer available", vim.log.levels.WARN)
      return
    end

    vim.api.nvim_set_current_win(current_win)
    vim.cmd("vertical sbuffer " .. buf)
    local diff_win = vim.api.nvim_get_current_win()

    vim.api.nvim_set_current_win(current_win)
    vim.cmd("diffthis")
    vim.wo.wrap = true

    vim.api.nvim_set_current_win(diff_win)
    vim.cmd("diffthis")
    vim.wo.wrap = true

    sessions[tabpage] = {
      source_win = current_win,
      compared_win = diff_win,
    }
  end)
end, { desc = "Diff with buffer -- use :q to close diff" })

-- Turn off diff mode and close the compared split
map("n", "<leader>do", function()
  if not close_session(vim.api.nvim_get_current_tabpage()) then
    vim.cmd("diffoff")
  end
end, { desc = "Diff off" })
