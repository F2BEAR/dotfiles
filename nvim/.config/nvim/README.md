# NVIM Config

This is the repo for my nvim configuration files; just a LazyVim conf with some basic changes to the starting repo template.

If you are using Windows as I do, you should place this into ~/AppData/Local/nvim folder.

I got a custom configuration to atuomatically shown hiden files in the neo-tree file explorer, and I would probably add configurations to use github's copilot, toggle-term, some theming, etc.

Also, to run this properly you need:

1. A C compiler such as Zig, GCC or somethign like that.
2. This is not really needed as the previous point but if you want the icons to work you need to get [Nerd fonts](https://www.nerdfonts.com/font-downloads) and set it up in your terminal; I use the RobotoMono Nerd Font but I guess you can use whichever suits you better.

This is just for me but it can be handy for you as well:

- If you need Zig do:

```shell
winget install -e --id zig.Zig
```

- To install nvim just run:

```shell
winget install Neovim.Neovim
```

Let's see where this get us.
