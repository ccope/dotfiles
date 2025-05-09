-- ~/.config/nvim/lua/config/commands.lua

-- Diff current buffer with saved version
vim.api.nvim_create_user_command("DiffSaved", function()
  local ft = vim.bo.filetype
  vim.cmd("diffthis")
  vim.cmd("vnew | r # | normal! 1Gdd")
  vim.cmd("diffthis")
  vim.cmd(("setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile readonly filetype=%s"):format(ft))
end, {})

-- Define the PrettyXML function in Vimscript
vim.cmd([[
  function! s:DoPrettyXML()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
  endfunction
]])

-- Register the command (Lua-style)
vim.api.nvim_create_user_command("PrettyXML", function()
  vim.cmd("call s:DoPrettyXML()")
end, {})
