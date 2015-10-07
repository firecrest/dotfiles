;; ~/.emacs.d/my-customisations.el

;; Disable the splash screen (to enable it again, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Enable 'y' or 'n' instead of 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Line Numbers
;; display line numbers to the right of the window
(global-linum-mode t)
;; show the current line and column numbers in the stats bar as well
(line-number-mode t)
(column-number-mode t)

;; Rebind C-x # to C-x k when opening a file from emacsclient
(add-hook 'server-switch-hook 
  (lambda ()
    (local-set-key (kbd "C-x k") '(lambda ()
                                    (interactive)
                                    (if server-buffer-clients
                                        (server-edit)
                                      (ido-kill-buffer))))))

;; Set to mail/Message mode when loaded from Mutt
;; Mutt support.
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))
;; set auto-fill-mode and abbrev-mode when editing a new mail in mail-mode
(defun my-mail-mode-hook ()
     (auto-fill-mode 1)
     (abbrev-mode 1)
;; Rebind c-x k to be server-edit when in mail-mode
     (local-set-key "\C-Xk" 'server-edit))
(add-hook 'mail-mode-hook 'my-mail-mode-hook)

;; Transparancy
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))
;; Assign toggle to C-c t to toggle transparency
 (eval-when-compile (require 'cl))
 (defun toggle-transparency ()
   (interactive)
   (if (/=
        (cadr (frame-parameter nil 'alpha))
        100)
       (set-frame-parameter nil 'alpha '(100 100))
     (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

