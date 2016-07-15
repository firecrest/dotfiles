;; ~/.emacs.d/my-loadpackages.el

;; load the my-packages.el file which loads the package repos (Melpa, etc.)
(load "~/.emacs.d/my-packages.el")

;; Emacs Themes
(load-theme 'zenburn t)

;; Auto complete setup
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; Powerline settings
(require 'powerline)
(powerline-default-theme)

;; jde mode
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(autoload 'jde-mode "jde" "JDE mode" t)
  (setq auto-mode-alist
        (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;; python-mode customisations
(setq display-buffer-alist
  (quote (("\\*Python\\*" display-buffer-below-selected
     (nil)))))
(defun python-shell-send-buffer-no-prompt (&optional arg)
  (python-shell-get-or-create-process "/usr/bin/python2 -i" nil t))

(advice-add 'python-shell-send-buffer :before #'python-shell-send-buffer-no-prompt)

;; org-mode settings - The following lines are always needed.  Choose your own keys.
(require 'org)
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; get nice bullets in org-mode
(require 'org-bullets)
(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)))
(setq org-hide-leading-stars t)

;; Auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)

;; Magit
;; Bind 'C-c m' to 'M-x magit-status'
(define-key global-map (kbd "C-c m") 'magit-status)

;; which-key
(which-key-mode)

;; google-this
(google-this-mode 1)

;; Yasnippet
;;(require 'yasnippet)
;(autoload 'yasnippet "yasnippet" "Yassnippet" t)
;(yas-global-mode 1)
;(setq yas-snippet-dirs
;      '("~/.emacs.d/snippets" ; personal snippets
;        "~/.emacs.d/elpa/yasnippet-20150415.244/snippets" ; default yasnippet collection of ;snippets
;        ))
;(add-hook 'term-mode-hook (lambda()
;                            (setq yas-dont-activate t)))
