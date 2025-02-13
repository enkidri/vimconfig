# vimconfig

Just run setup.sh

coc.nvim will likely require dependencies that needs to be updated. Also, you
need to install each language specific parser for it to work as 'TSInstall cpp'
for instance.

You might need to add a .clangd to your project with this line.
CompileFlags:
Add: -ferror-limit=0

TODO: Add automatic installation of plugins that requires specific lanuage installs
Example: -- coc-nvim : coc-clangd, coc-pretty
treesitter
