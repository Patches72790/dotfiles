
test_lsp_request = function()
    vim.lsp.buf_request(
        0,
        "ExecuteCommand",
        "params" = {
            "vscode.java.startDebugSession"
        },
        ""
    )
end

return test_lsp_request
