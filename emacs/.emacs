;; .emacs

;; Load the separate customisation files to break up the .emacs file a bit
(load "~/.emacs.d/my-loadpackages.el")
(load "~/.emacs.d/my-customisations.el")
;; custom file for all amendments using M-x customize-set-variable
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
