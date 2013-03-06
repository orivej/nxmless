# Extensions

`nxmless-hide-tags` makes `<tag>content</tag>` look like ` tag content      ` (with types distinguishable by colors) in nXML buffers.

`nxmless-tidy` pretty prints XML in two different ways (canonical and lispy).

# Installation

In order to install using el-get, save `https://raw.github.com/orivej/nxmless/master/nxmless.rcp` in `~/.emacs.d/el-get/el-get/recipes/` and do `M-x el-get-install RET nxmless RET`.

Put `(add-hook 'nxml-mode-hook 'nxmless-hide-tags)` in the Emacs init file and evaluate it to activate `nxmless-hide-tags`.

`(require 'nxmless-tidy)` and bind `nxmless-sexp-tidy` and `nxmless-normal-tidy`.
