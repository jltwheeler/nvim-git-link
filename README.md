## nvim-git-link
Easily open remote repository links from your local buffer files

### Disclaimer

I'm not a lua developer, so feel free to open a PR to improve / extend 
the plugin code 😅

## Installation

Requirements: [Neovim](https://neovim.io/) >= 0.5.

For [vim-plug](https://github.com/junegunn/vim-plug):
```
Plug 'jltwheeler/nvim-git-link'
```
For [packer](https://github.com/wbthomason/packer.nvim):
```
use 'jltwheeler/nvim-git-link'
```

## Usage

### Get link to remote repo at current cursor line

```
:lua require"nvim-git-link".get_remote_link()
```

