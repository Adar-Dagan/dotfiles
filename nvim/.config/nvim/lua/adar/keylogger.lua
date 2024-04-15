Path = "/home/adar/.keylogger"
local logFile = io.open(Path, "a")
if logFile == nil then
    print("Error opening file")
    return
end

vim.api.nvim_create_autocmd(
    { "InsertCharPre" },
    {
        pattern = { "*" },
        callback = function()
            local char = vim.api.nvim_get_vvar("char")
            logFile:write(char)
            logFile:flush()
        end,
    }
)

vim.api.nvim_create_autocmd(
    { "VimLeavePre" },
    {
        pattern = { "*" },
        callback = function()
            logFile:close()
        end,
    }
)
