let g:vimspector_enable_mappings = 'HUMAN'

let s:jdt_ls_debugger_port = 0
function! s:StartDebugging()
  if s:jdt_ls_debugger_port <= 0
    " Get the DAP port
    let s:jdt_ls_debugger_port = youcompleteme#GetCommandResponse(
      \ 'ExecuteCommand',
      \ 'vscode.java.startDebugSession' )

    if s:jdt_ls_debugger_port == ''
       echom "Unable to get DAP port - is JDT.LS initialized?"
       let s:jdt_ls_debugger_port = 0
       return
     endif
  endif

  " Start debugging with the DAP port
  call vimspector#LaunchWithSettings( { 'DAPPort': s:jdt_ls_debugger_port } )
endfunction

nnoremap <silent> <buffer> <Leader><F5> :call <SID>StartDebugging()<CR>

nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :call vimspector#Reset()<CR>
nmap <leader>ve :call vimspector#Evaluate<CR>
nmap <leader>vw :call vimspector#AddWatch<CR>
nmap <leader>vo :call vimspector#ShowOutput<CR>
nmap <leader>vc :lua require('telescope').extensions.vimspector.configurations()<CR>

let g:vimspector_install_gadgets = ['debugpy', 'CodeLLDB', 'vscode-node-debug2' ]
