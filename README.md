This trivial extension makes `<tag>content</tag>` look like ` tag content      ` (with different colors) in NXML buffers in Emacs.

In order to install using el-get, save `https://raw.github.com/orivej/nxml-hide-end-tags.el/master/nxml-hide-end-tags.rcp` in `~/.emacs.d/el-get/el-get/recipes/` and do `M-x el-get-install RET nxml-hide-end-tags RET`.

Put `(add-hook 'nxml-mode-hook 'nxml-hide-tags)` in the Emacs init file and evaluate it to activate.

`nxml-tidy` is another extension which pretty prints XML in two different ways (canonical and lispy).
