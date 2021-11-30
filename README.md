## nvim-git-link
Easily open remote repository links from your local buffer files

### Roadmap

- Add flag to specify if url is saved to clipboard or open in browser
- Add flag to specify if url should open with blame
- Add function to open url of commit history of a given file
- Add function top open url of all PR's for a given file
- Add ability to open url of dependency files e.g. a `node_modules` file (not
  tracked in git)

### Disclaimer

I'm not a lua developer, so feel free to open a PR to improve / extend 
the plugin code 😅. See the [Development](#development) section for further info.

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

## Development

If you are keen to contribute to the plugin, please follow these steps to
get setup locally:

1. `cd ~` to your desired root project directory
2. `mkdir -r lua-plugins/lua`
3. `cd lua-plugins/lua`
4. `git clone git@github.com:jltwheeler/nvim-git-link.git`
5. To test this, go to any other project directory and open vim with the following
command:
```sh
vim --cmd "set rtp+=./path/to/lua-plugin/"
```
This will load the `nvim-git-link` plugin into the nvim run time path, and 
load the locally cloned plugin.
6. Start adding your code and testing in the other vim session. 

> NB: every time you save new code to the plugin, you will need to re-load 
`nvim` with the command in step 5.
