if exists("g:loaded_p4_nvim")
    finish
endif
let g:loaded_p4_nvim = 1

command! -nargs=0 P4Checkout lua require("p4-nvim").checkout()
command! -nargs=0 P4Changelists lua require("p4-nvim").changelists()
command! -nargs=0 P4Add lua require("p4-nvim").add()
