
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq-default c-basic-offset 4
			  c-default-style "bsd"
              tab-width 4
			  indent-tabs-mode t)
(setq c-tab-always-indent t)
;; (ido-mode)
(require 'helm-config)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(fringe-mode 0)

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(color-theme-solarized)

;; powerline
;; (require 'powerline)
;; (powerline-default-theme)

;; Use Emacs terminfo, not system terminfo
(setq system-uses-terminfo nil)

;; load the 42 site-lisp
(load-file "/usr/share/emacs/site-lisp/list.el")
(require 'list)
(load-file "/usr/share/emacs/site-lisp/string.el")
(require 'string)
(defun load-directory (dir)
  (let ((load-it (lambda (f)
				   (load-file (concat (file-name-as-directory dir) f)))
				 ))
	(mapc load-it (directory-files dir nil "\\.el$"))))
(load-directory "/usr/share/emacs/site-lisp")

;; org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   (quote
    (helm-youtube zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file "~/.emacs.d/init.el")

(split-window-right)
(other-window 1)
(split-window-below)
(other-window 1)
(ansi-term "zsh")
(other-window 1)
