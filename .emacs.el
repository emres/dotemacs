
;; disable menu-bar-mode
(menu-bar-mode -1)

;; disable tool-bar-mode
(tool-bar-mode -1)

;; show the size of the file in kb, mb, etc.
(size-indication-mode t)

;; show line numbers on the left
(global-linum-mode 1)

;; show the column number in status
(column-number-mode t)

;; syntax highlighting related
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; set default font face to Source Code Pro 9
(set-default-font "Source Code Pro-9")

;; match parentheses
(show-paren-mode t)

;; save minibuffer history
(savehist-mode t)

;; When running on Unix and X handle correct clipboard functionality
(setq x-select-enable-clipboard t)

(set-scroll-bar-mode 'right)

;; display the time in status line
(display-time-mode t)

;; alias y to yes and n to no
(defalias 'yes-or-no-p 'y-or-n-p)

;; set the fill column
(setq-default fill-column 80)

;; disable the scroll bar
(scroll-bar-mode -1)

;; indicate empty lines
(setq indicate-empty-lines t)

;; do not show start-up message
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; package manager related settings
;; packages installed via package.el to should be
;; initialized before we start tweaking them.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End package manager related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; highlight the line that cursor is on
;; (global-hl-line-mode t)

;; Move between windows using shift + arrow keys
(windmove-default-keybindings)

;; replace highlighted text with what I type rather than just inserting at a
;; point
(delete-selection-mode t)

;; Pgup/dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)

;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b - %f")

;; highlight incremental search
(setq search-highlight t)

;; iswitchb-mode activation
(iswitchb-mode 1)

;; remember recently opened files
(recentf-mode t)

;; keep the backup files (files ending in ~) in a central place
;; and keep previous versions of backup files, just in case
(setq backup-directory-alist `(("." . "~/.emacs-backup-files")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; set winner-mode on, which helps to do
;; some quick window configuration
(winner-mode 1)

;; I use uniquify to distinguish between two identically named files as the
;; default, appending a <n> extension, is rubbish. This tip is from Trey
;; Jackson.
;; http://curiousprogrammer.wordpress.com/2009/04/28/emacs-hacks/
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Assign ibuffer to C-x C-b
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; enable full-screen mode and assign it to F11
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
       (set-frame-parameter nil 'fullscreen
                            (if (equal 'fullboth current-value)
                                (if (boundp 'old-fullscreen) old-fullscreen nil)
                                (progn (setq old-fullscreen current-value)
                                       'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)


;; auto-install
(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'auto-install)
(add-to-list 'load-path "~/.emacs.d/auto-install/")


;; js2 mode by Yegge http://code.google.com/p/js2-mode/
(setq load-path (append
				 (list (expand-file-name "~/.emacs.d/js2"))
				 load-path))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; sunrise-commander file manager
(require 'sunrise-commander)

;; use MS Windows file associations for dired
;; (load "w32-browser")

;; Enable current line highlighting when dired is loaded
(defun my-dired-hook-mode ()
  (hl-line-mode))
(add-hook 'dired-mode-hook 'my-dired-hook-mode)

;; Enable dired-x when dired is invoked
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    ;; (setq dired-omit-files-p t)
	    ))

;; Sort directories first, dired related modes
(defun mydired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (mydired-sort))

;; Setup dired to let you nicely copy stuff inbetween two dired
;; windows.
(setq dired-dwim-target t)

;; recursive copy without prompt
(setq dired-recursive-copies 'always)

;; dired-aux
(require 'dired-aux)

;; dired-x
;;(require 'dired-x)
;; (require 'dired-single)

;; multiple major modes in a buffer
(setq mumamo-global-mode t)

;; When you visit a file, point goes to the last place
;; where it was when you previously visited the same file.
(require 'saveplace)
(setq-default save-place t)

;; ido-mode enabled: interactively do things
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ; flexibly match names
(setq ido-everywhere t)           ; use ido-mode everywhere
(setq ido-use-filename-at-point 'guess) ; for find-file-at-point

;; move the mouse pointer out of cursor's way
(mouse-avoidance-mode t)

;; automatically type matching (, [, {, ", etc. and place the cursor inside
(require 'autopair)
(autopair-global-mode t) ;; enable autopair in all buffers
(setq autopair-autowrap t)

;; turkish-mode
(load "~/elisp/turkish.el")

;; tab width setup
(setq indicate-empty-lines t)
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq c-basic-indent 4)

;; auto-load mode setup
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin python-mode related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(add-hook 'python-mode-hook 'imenu-add-menubar-index)
(global-set-key [mouse-3] 'imenu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End python-mode related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'auto-complete)
(global-auto-complete-mode t)


;; mic-paren mode for advanced parantheses matching
(require 'mic-paren) ; loading
(paren-activate)     ; activating

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin whitespace-mode related setttings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nuke trailing whitespaces when writing to a file
(add-hook 'before-save-hook 'whitespace-cleanup)


;; display only tails of lines longer than 80 columns, tabs and
;; trailing white spaces
(setq whitespace-line-column 80
      whitespace-style '(tabs trailing lines-tail))

;; face for long lines' tails
;; (set-face-attribute 'whitespace-line nil
;;                     :background "red1"
;;                     :foreground "yellow"
;;                     :weight 'bold)

;; face for Tabs
;; (set-face-attribute 'whitespace-tab nil
;;                     :background "red1"
;;                     :foreground "yellow"
;;                     :weight 'bold)

;; activate minor whitespace mode when in python mode
(add-hook 'python-mode-hook 'whitespace-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End whitespace-mode related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; CEDET related settings
(load-file "~/elisp/cedet-1.0/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; ECB related settings - Emacs Code Browser
(add-to-list 'load-path "~/elisp/ecb-2.40")
(require 'ecb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin scala-mode related setttings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path
             "~/Documents/programming/scala/scala-2.9.0.1/misc/scala-tool-support/emacs/")

(require 'scala-mode-auto)

(defun scala-turnoff-indent-tabs-mode ()
  (setq indent-tabs-mode nil))

;; scala mode hooks
(add-hook 'scala-mode-hook 'scala-turnoff-indent-tabs-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End scala-mode related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin automatic white-space insertion after comma
;; For more information see:
;; http://ericscrosson.wordpress.com/2013/04/05/minimizing-keystrokes-required-by-punctuation/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd ",")
                (lambda() (interactive) (insert ", ")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End automatic white-space insertion after comma
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin ess-mode related setttings (R project)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "~/.emacs.d/ess-13.05/lisp/ess-site")
(require 'ess-site)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End ess-mode related setttings (R project)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin yasnippet
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End yasnippet
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Begin AUCTeX related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; End AUCTeX related settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
