local M = {}

local function has_other_normal_buffer(current_bufnr)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current_bufnr and vim.fn.buflisted(bufnr) == 1 and vim.bo[bufnr].buftype == "" then
      return bufnr
    end
  end

  return nil
end

function M.close_current(force)
  local bufnr = vim.api.nvim_get_current_buf()

  if not force and vim.bo[bufnr].modified then
    vim.cmd("bdelete")
    return
  end

  local replacement = has_other_normal_buffer(bufnr)

  if replacement then
    vim.api.nvim_set_current_buf(replacement)
    vim.cmd((force and "bdelete! " or "bdelete ") .. bufnr)
    return
  end

  -- Terminal buffers are unlisted, so bdelete would otherwise close the
  -- current window when this is the last listed normal buffer.
  local ok = pcall(vim.cmd, force and "enew!" or "enew")
  if ok then
    vim.cmd((force and "bdelete! " or "bdelete ") .. bufnr)
  end
end

return M
