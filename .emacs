(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 83 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;; show the column number in status
(column-number-mode t)

;; syntax highlighting related
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; match parantheses
(show-paren-mode t)

;; save minibuffer history
(savehist-mode t)

;; When running on Unix and X handle correct clipboard functionality
(setq x-select-enable-clipboard t)

(set-scroll-bar-mode 'right)

;; disable the tool bar
(tool-bar-mode nil)

;; disable the menu bar
(menu-bar-mode nil)

;; display the time in status line
(display-time-mode t)

;; alias y to yes and n to no
(defalias 'yes-or-no-p 'y-or-n-p)

;; set the fill column
(setq-default fill-column 80)

;; disable the scroll bar
(scroll-bar-mode nil)

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

;; move the mouse pointer out of cursor's way
(mouse-avoidance-mode t)
