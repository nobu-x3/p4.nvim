# What is this?
This is a neovim plugin that is supposed to make working with Perforce easier. Neovim refuses to write to readonly buffers without `!` and having to find the file you're working with in P4V/P4 may become tedious. The plugin aims to alleviate some pain points.

# Install
Packer:
```
require('packer').startup(function(use)
	use 'nobu-x3/p4.nvim'
end)

require("p4-nvim").setup()
```


# Dependencies
P4 must be installed and added to the path. To test, run `p4 help` in terminal.

# Commands
Currently supported commands:
* `P4Changelists` - prints currently pending changelists
* `P4Checkout` - checks out the current buffer (prompts changelist number). Run this before editing your buffer. Could potentially add it to pre-save-buffer.
* `P4Add` - marks current buffer for add (prompts changelist number)
