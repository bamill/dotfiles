(cond ((eq system-type 'gnu/linux)
       ;; GNU/Linux configuration

       (custom-set-variables
        ;; custom-set-variables was added by Custom.
        ;; If you edit it by hand, you could mess it up, so be careful.
        ;; Your init file should contain only one such instance.
        ;; If there is more than one, they won't work right.
        '(custom-safe-themes
          (quote
           ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
        '(package-selected-packages
          (quote
           (zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))

       (require 'package)
       (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
       (package-initialize)

       (load-file "~/.emacs.d/init.el")

       (custom-set-faces
        ;; custom-set-faces was added by Custom.
        ;; If you edit it by hand, you could mess it up, so be careful.
        ;; Your init file should contain only one such instance.
        ;; If there is more than one, they won't work right.
        )

       ;; These two lines are just examples
       ;; (setq powerline-arrow-shape 'curve)
       ;; (setq powerline-default-separator-dir '(right . left))
       ;; These two lines you really need.

       ;; magit keybind
       (global-set-key (kbd "C-x g") 'magit-status)

       ;; helm-gtags

       (require 'helm)
       (require 'helm-config)


       ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
       ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
       ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
       (global-set-key (kbd "C-c h") 'helm-command-prefix)
       (global-unset-key (kbd "C-x c"))

       ;; helm-M-x
       (global-set-key (kbd "M-x") 'helm-M-x)
       (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

       ;; helm-show-kill-ring
       (global-set-key (kbd "M-y") 'helm-show-kill-ring)

       ;; helm-mini
       (global-set-key (kbd "C-x b") 'helm-mini)
       (setq helm-buffers-fuzzy-matching t
             helm-recentf-fuzzy-match    t)

       ;; helm-find-files
       (global-set-key (kbd "C-x C-f") 'helm-find-files)

       ;; use ack-grep instead of grep, if available
       (when (executable-find "ack")
         (setq helm-grep-default-command "ack -Hn --nogroup --nocolor %e %p %f"
               helm-grep-default-recurse-command "ack -H --nogroup --nocolor %e %p %f"))

       ;; semantic mode
       (semantic-mode 1)
       (setq helm-semantic-fuzzy-match t
             helm-imenu-fuzzy-match    t)

       ;; helm man page at point
       (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

       ;; fuzzy matching for helm-locate
       (setq helm-locate-fuzzy-match t)

       ;; fuzzy matching for apropos
       (setq helm-apropos-fuzzy-match t)

       ;; fuzzy match for elisp
       (setq helm-lisp-fuzzy-completion t)

       ;; rebind helm-all-mark-rings
       (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

       ;; rebind helm-register
       (global-set-key (kbd "C-c h x") 'helm-register)

       ;; helm-google-suggest
       (global-set-key (kbd "C-c h g") 'helm-google-suggest)

       ;; rebind helm-eval-expression-with-eldoc
       (global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)

       ;; helm eshell history
       (require 'helm-eshell)

       (add-hook 'eshell-mode-hook
                 #'(lambda ()
                     (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

       ;; helm shell history
       (define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

       ;; minibuffer history
       (define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)

       ;; helm-info keybinds
       (global-set-key (kbd "C-c h h d") 'helm-info-gdb)
       (global-set-key (kbd "C-c h h f") 'helm-info-find)
       (global-set-key (kbd "C-c h h s") 'helm-info-sicp)
       (global-set-key (kbd "C-c h h e") 'helm-info-elisp)

       (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
       (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
       (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

       (when (executable-find "curl")
         (setq helm-net-prefer-curl t))

       (when (executable-find "firefox")
         (setq browse-url-generic-program "firefox"))

       (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
             helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
             helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
             helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
             helm-ff-file-name-history-use-recentf t
             helm-echo-input-in-header-line t)

       (defun spacemacs//helm-hide-minibuffer-maybe ()
         "Hide minibuffer in Helm session if we use the header line as input field."
         (when (with-helm-buffer helm-echo-input-in-header-line)
           (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
             (overlay-put ov 'window (selected-window))
             (overlay-put ov 'face
                          (let ((bg-color (face-background 'default nil)))
                            `(:background ,bg-color :foreground ,bg-color)))
             (setq-local cursor-type nil))))


       (add-hook 'helm-minibuffer-set-up-hook
                 'spacemacs//helm-hide-minibuffer-maybe)

       (setq helm-autoresize-max-height 0)
       (setq helm-autoresize-min-height 20)
       (helm-autoresize-mode 1)

       (helm-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       ;; PACKAGE: helm-descbinds                      ;;
       ;;                                              ;;
       ;; GROUP: Convenience -> Helm -> Helm Descbinds ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       (require 'helm-descbinds)
       (helm-descbinds-mode)

       ;; projectile
       (projectile-global-mode)
       (setq projectile-completion-system 'helm)
       (helm-projectile-on)
       (setq projectile-switch-project-action 'helm-projectile)


       ;; (require 'color-theme)
       ;; (color-theme-solarized)
       (when (window-system)
	 (progn
	      (load-theme 'solarized-dark)
	      (scroll-bar-mode 0)
	      (menu-bar-mode 0)
          (cond ((>= (x-display-pixel-height) 1080)
                 (set-face-attribute 'default nil :family "Inconsolata" :height 125))
                (t
                 (set-face-attribute 'default nil :family "Inconsolata" :height 105)))
	      (if (functionp 'tool-bar-mode) (tool-bar-mode 0))))

       (column-number-mode 0)


       ;; mew
       ;; (autoload 'mew "mew" nil t)
       ;; (autoload 'mew-send "mew" nil t)

       ;; Optional setup (Read Mail menu):
       ;; (setq read-mail-command 'mew)

       ;; Optional setup (e.g. C-xm for sending a message):
       ;; (autoload 'mew-user-agent-compose "mew" nil t)
       ;; (if (boundp 'mail-user-agent)
       ;;    (setq mail-user-agent 'mew-user-agent))
       ;; (if (fboundp 'define-mail-user-agent)
       ;;    (define-mail-user-agent
       ;;      'mew-user-agent
       ;;      'mew-user-agent-compose
       ;;      'mew-draft-send-message
       ;;      'mew-draft-kill
       ;;      'mew-send-hook))

       (cond ((file-readable-p "~/.emacs.d/.erc-auth")
              (load "~/.emacs.d/.erc-auth")))


       (require 'emms-setup)
       (emms-standard)
       (emms-default-players)

       (setq  emms-player-mplayer-parameters '("-slave" "-quiet")
              emms-player-mplayer-playlist-parameters '("-slave" "-quiet" "-playlist"))

       (defun mplayer-stream-start-listening ()
         "This emms-player-started-hook checks if the current track is a
url and the process playing it is mplayer. If it is then the
output filter mplayer-steam-filter is added to the process"
         (let ((type (emms-track-type (emms-playlist-current-selected-track))))
           (if (or (eq  type 'url) (eq  type 'streamlist))
               (let ((process (get-process emms-player-simple-process-name)))
                 (if (string= (car (process-command process)) "mplayer")
                     (set-process-filter process 'mplayer-stream-filter))
                 ))
           ))

       (add-hook 'emms-player-started-hook 'mplayer-stream-start-listening)
       (defvar emms-mplayer-info-coding-system 'cp1251)
       (defmacro emms-mplayer-info-defreg (symname regexp)
         "Set SYMNAME to be the match for REGEXP."
         `(if (string-match ,regexp string)
              (progn
                (setq ,symname (decode-coding-string (match-string 1 string) emms-mplayer-info-coding-system))
                (if (> (length ,symname) 40)
                    (setq ,symname (concat (substring ,symname 0 37) "..."))))
            ))


       (defun mplayer-stream-filter (proc string)
         "Checks mplayer output for ICY Info data. If any is found then the StreamTitle
option is extracted and written to the track's 'info-title property. Because
emms-info-track-description -- the function that creates the track name -- needs a
title *and* an artist 'info-artist is set to the stream title (the one you see in
emms-streams)."
         (let ((name "")
               (Title "")
               (Artist "")
               (Album "")
               (genre "")
               (bitrate "")
               (nowplaying "")
               (track (emms-playlist-current-selected-track))
               )
           (emms-mplayer-info-defreg name "^Name[ ]*:[ ]*\\(.*\\)\\b[ ]*$") ;;;;describe station
           (emms-mplayer-info-defreg genre "^Genre[ ]*:[ ]*\\(.*\\)\\b[ ]*$") ;;;;describe station
           (emms-mplayer-info-defreg bitrate "^Bitrate[ ]*:[ ]*\\(.*\\)\\b[ ]*$") ;;;;describe station
           (emms-mplayer-info-defreg nowplaying "^ICY Info: StreamTitle='\\(.*\\)'")
           (emms-mplayer-info-defreg Artist "Artist:[ ]*\\(.*\\)\\b[ ]*$\\|^author:[ ]*\\(.*\\)\\b[ ]*$") ;;;;describe artist
           (emms-mplayer-info-defreg Album "Album:[ ]*\\(.*\\)\\b[ ]*$") ;;;;describe artist
           (emms-mplayer-info-defreg Title "Title:[ ]*\\(.*\\)\\b[ ]*$") ;;;;describe artist
           (if (> (length (concat nowplaying Title)) 0)
               (emms-track-set track 'info-title (concat nowplaying Title)))
           (if (> (length (concat name Album)) 0)
               (emms-track-set track 'info-album (concat name Album)))
           (if (> (length Artist) 0)
               (emms-track-set track 'info-artist Artist))
           (if (not (or (emms-track-get track 'info-artist)
                        (emms-track-get track 'info-album)
                        (emms-track-get track 'info-title)))
               (emms-track-set track 'info-album
                               (if (listp (emms-track-get track 'metadata))
                                   (car (emms-track-get track 'metadata))
                                 "")))
;    Updated: 2017/05/23 20:34:20 by bmiller          ###   ########.fr        ;
           ))

       ;; bbdb
       (require 'bbdb)
       (bbdb-initialize)

       ;; function-args
       (require 'function-args)
       (fa-config-default)
       (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
       (set-default 'semantic-case-fold t)
       (require 'semantic/bovine/c)
       (add-to-list 'semantic-lex-c-preprocessor-symbol-file
                    "/usr/lib/gcc/x86_64-linux-gnu/4.8/include/stddef.h")

       ;; sr-speedbar
       (require 'sr-speedbar)
       (global-set-key (kbd "M-s") 'sr-speedbar-toggle)
       (setq sr-speedbar-skip-other-window-p t)
       (setq sr-speedbar-right-side nil)

       ;; company mode
       (setq company-backends (delete 'company-semantic company-backends))
       (define-key c-mode-map  [(tab)] 'company-complete)
       (define-key c++-mode-map  [(tab)] 'company-complete)
       (require 'company-c-headers)
       (add-to-list 'company-backends 'company-c-headers)
       (autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
       (eval-after-load 'company
         '(progn
            (define-key company-mode-map (kbd "C-:") 'helm-company)
            (define-key company-active-map (kbd "C-:") 'helm-company)))

       ;; hs-minor-mode for c
       (add-hook 'c-mode-common-hook   'hs-minor-mode)

       ;; semantic
       (require 'cc-mode)
       (require 'semantic)
       (global-semanticdb-minor-mode 1)
       (global-semantic-idle-scheduler-mode 1)
       (semantic-mode 1)

       ;; company-readline
       (require 'readline-complete)
       (setq explicit-shell-file-name "bash")
       (setq explicit-bash-args '("-c" "export EMACS=; stty echo; bash"))
       (setq comint-process-echoes t)
       (push 'company-readline company-backends)
       (add-hook 'rlc-no-readline-hook (lambda () (company-mode -1)))

       ;; company-emoji
       (require 'company-emoji)
       (add-to-list 'company-backends 'company-emoji)
       (defun --set-emoji-font (frame)
         "Adjust the font settings of FRAME so Emacs can display emoji properly."
         (if (eq system-type 'darwin)
             ;; For NS/Cocoa
             (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
           ;; For Linux
           (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))
       ;; For when Emacs is started in GUI mode:
       (--set-emoji-font nil)
       ;; Hook for when a frame is created with emacsclient
       ;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
       (add-hook 'after-make-frame-functions '--set-emoji-font)

       ;; semantic system include
       (semantic-add-system-include "/usr/include")

       ;; ede
       (require 'ede)
       (global-ede-mode)
       (load-file "~/.emacs.d/ede-projects.el")

       ;; semantic refactor
       (require 'srefactor)
       (require 'srefactor-lisp)

       (define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
       (define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
       (global-set-key (kbd "M-RET o") 'srefactor-lisp-one-line)
       (global-set-key (kbd "M-RET m") 'srefactor-lisp-format-sexp)
       (global-set-key (kbd "M-RET d") 'srefactor-lisp-format-defun)
       (global-set-key (kbd "M-RET b") 'srefactor-lisp-format-buffer)

       ;; global semantic idle summary mode
       (global-semantic-idle-summary-mode 1)

       ;; global semantic stickyfunc mode
       (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

       ;; stickyfunc-enhance
       (require 'stickyfunc-enhance)

       ;; yasnippet
       (require 'yasnippet)
       (yas-global-mode 1)

       ;; Package: smartparens
       (require 'smartparens-config)
       (show-smartparens-global-mode +1)
       (smartparens-global-mode 1)

       ;; when you press RET, the curly braces automatically
       ;; add another newline
       (sp-with-modes '(c-mode c++-mode)
         (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
         (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                                   ("* ||\n[i]" "RET"))))

       (put 'narrow-to-region 'disabled nil)

;;       (load-theme 'solarized-dark t)
       (setq sml/no-confirm-load-theme t)
       (setq sml/theme 'automatic)
       (sml/setup)
       )
      ((eq system-type 'darwin)

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

       (setq helm-locate-fuzzy-match nil)
       (setq helm-locate-command "mdfind -name %s %s")
       (setq helm-man-format-switches "%s")

       (setq python-shell-exec-path '("/nfs/2016/b/bmiller/goinfre/homebrew/bin"))
       (setq python-shell-interpreter "python3")
       (defun python-shell-completion-native-try ()
         "Return non-nil if can trigger native completion."
         (let ((python-shell-completion-native-enable t)
               (python-shell-completion-native-output-timeout
                python-shell-completion-native-try-output-timeout))
           (python-shell-completion-native-get-completions
            (get-buffer-process (current-buffer))
            nil "_")))

       (split-window-right)
       (other-window 1)
       (split-window-below)
       (other-window 1)
       (ansi-term "zsh")
       (other-window 1)
       )
      )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
