(add-to-list 'load-path "~/.emacs.d/lisp")
(load "editorconfig")
(autoload 'scss-mode "scss-mode")
(require 'sws-mode)
(require 'sass-mode)
(require 'jade-mode)
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.jade\\" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\" . coffee-mode))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))