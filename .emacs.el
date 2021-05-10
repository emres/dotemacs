;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Emre Sevinç")
(setq user-mail-address "emre.sevinc@gmail.com")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(display-time-mode t)
(setq column-number-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq calendar-week-start-day 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Only spaces, no tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indicate-empty-lines t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scrolling settings
(set-scroll-bar-mode nil)
(setq scroll-step 1
      scroll-conservatively 10000)

;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; PgUp/Dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; do not show start-up message
(setq inhibit-startup-message t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight incremental search
(setq search-highlight t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; save minibuffer history
(savehist-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; replace highlighted text with what is typed rather than just inserting at a
;; point
(delete-selection-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme settings
(load-theme 'wombat)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global line number mode
(global-display-line-numbers-mode)
(set-face-foreground 'line-number "DarkOrange4")
(set-face-foreground 'line-number-current-line "DarkOrange1")
(defun display-line-numbers-equalize ()
  "Equalize the width. For more information, 
see: https://emacs.stackexchange.com/a/55166/8887"
  (setq display-line-numbers-width
        (length (number-to-string (line-number-at-pos (point-max))))))
(add-hook 'find-file-hook 'display-line-numbers-equalize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b - %f")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remember recently opened files
(recentf-mode t)
;; set F7 to open a list of recently opened file
(global-set-key (kbd "<f7>") 'recentf-open-files)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; When you visit a file, point goes to the last place
;; where it was when you previously visited the same file.
(save-place-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set the fill column
(setq-default fill-column 80)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keep the backup files (files ending in ~) in a central place
;; and keep previous versions of backup files, just in case
(setq backup-directory-alist `(("." . "~/.emacs-backup-files")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For details, see the following web page:
;; http://oremacs.com/2015/01/17/setting-up-ediff/
(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default)
            ',variable ,value))

(csetq ediff-window-setup-function 'ediff-setup-windows-plain)
(csetq ediff-split-window-function 'split-window-horizontally)
(csetq ediff-diff-options "-w")

(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'misc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;see https://emacs.stackexchange.com/a/48943/8887 for more details
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up use-package
;;
;; This is only needed once, near the top of the file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;;(add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fringe settings
(defun my-tone-down-fringes ()
  (set-face-attribute 'fringe nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Show which key combinations are available
(use-package which-key
  :ensure t
  :config (which-key-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set up windmove so that you can jump to windows using Shift+<Arrow Keys>
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Or you can use M-1, M-2, M-3 to go to a window
(use-package window-numbering
  :ensure t
  :config (window-numbering-mode t))

(use-package switch-window
  :ensure t
  :bind ("C-x o" . 'switch-window))

(use-package windresize
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For more details, please see:
;; https://github.com/abo-abo/swiper
(use-package counsel
  :ensure t
  :bind (("C-s" . 'swiper)
         ("M-x" . 'counsel-M-x)
         ("C-x C-f" . 'counsel-find-file)
         (:map ivy-minibuffer-map
               ("M-j" . 'bjm/ivy-yank-whole-word)))
  :init
  (setq ivy-display-style 'fancy)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 10)
  (setq ivy-display-style 'fancy)
  (setq ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode t)
  (defun bjm/ivy-yank-whole-word ()
    "Pull next word from buffer into search string."
    (interactive)
    (let (amend)
      (with-ivy-window
        ;;move to last word boundary
        (re-search-backward "\\b")
        (let ((pt (point))
              (le (line-end-position)))
          (forward-word 1)
          (if (> (point) le)
              (goto-char pt)
            (setq amend (buffer-substring-no-properties pt (point))))))
      (when amend
        (insert (replace-regexp-in-string "  +" " " amend))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Company Mode related settings (COMPlete ANYthing)
(use-package company-statistics
  :ensure t
  :config
  (company-statistics-mode))

(use-package company
  :ensure t
  :requires company-statistics
  :config
  (global-company-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use uniquify to distinguish between two identically named files as the
;; default, appending a <n> extension, is rubbish. This tip is from Trey Jackson
;; http://curiousprogrammer.wordpress.com/2009/04/28/emacs-hacks/
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(electric-pair-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turkish Mode for converting ASCII to proper Turkish characters
(use-package turkish
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The workaround for preventing underlined highlighted lines in dark themes
;; such as wombat. For more information, please see:
;; https://github.com/syl20bnr/spacemacs/issues/2786#issuecomment-268814650
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'color)

(defun set-hl-line-color-based-on-theme ()
  "This is required as a workaround to prevent underlined
    highlighted lines."
  (set-face-attribute 'hl-line nil
                      :underline nil
                      :background (color-darken-name
                                   (face-background 'default)
                                   10)))

(set-face-foreground 'highlight nil)
(add-hook 'global-hl-line-mode-hook 'set-hl-line-color-based-on-theme)
(global-hl-line-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-cursor-color "LightBlue")
(my-tone-down-fringes)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package powerline
  :config
  (powerline-default-theme))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; spaceline modeline theme and separator related
;; https://www.reddit.com/r/spacemacs/comments/4lqzfk/setq_powerlinedefaultseparator_arrow_not_working/?st=j4f8kih8&sh=6e7eaef8
;; https://github.com/TheBB/spaceline
;; https://github.com/dbordak/telephone-line
;;
;; https://github.com/domtronn/all-the-icons.el
;;
;; In order for the icons to work it is very important that you
;; install the Resource Fonts included in this package, they are
;; available in the fonts directory. You can also install the
;; latest fonts for this package in the (guessed?) based on the OS
;; by calling the following function
;;
;;     M-x all-the-icons-install-fonts
;;
;; Bear in mind, this will also run fc-cache -f -v on MacOS and
;; Linux which can take some time to complete. For Windows, this
;; function will prompt for a download directory for you to install
;; them manually. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package all-the-icons
  :ensure t)

(use-package spaceline
  :config
  (spaceline-spacemacs-theme))

;; I've disabled this for now, because it seems like it's consuming too much CPU
;; (use-package spaceline-all-the-icons 
;;   :after spaceline
;;   :config (spaceline-all-the-icons-theme))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :config
  (use-package all-the-icons-dired
    ;; M-x all-the-icons-install-fonts
    :ensure t
    :commands (all-the-icons-dired-mode))
  (add-hook 'dired-mode-hook (lambda () (display-line-numbers-mode 0)))
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x k") 'kill-this-buffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package info-colors
  :ensure t
  :config
  (add-hook 'Info-selection-hook 'info-colors-fontify-node))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package expand-region
  :ensure t
  :bind ("C-=" . 'er/expand-region))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;avy jump mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package avy
  :ensure t
  :bind (("C-:" . 'avy-goto-char)
         ("C-'" . 'avy-goto-char-2)
         ("M-g f".  'avy-goto-line)
         ("M-g w" . 'avy-goto-word-1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Advanced Help mode: Helpful
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(use-package helpful
  :ensure t
  :bind (("C-h f" . #'helpful-callable)
         ("C-h v" . #'helpful-variable)
         ("C-h k" . #'helpful-key)
         ;; Lookup the current symbol at point. C-c C-d is a common keybinding
         ;; for this in lisp modes.
         ("C-c C-d" . #'helpful-at-point)

         ;; Look up *F*unctions (excludes macros).
         ;;
         ;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
         ;; already links to the manual, if a function is referenced there.
         ("C-h F" . #'helpful-function)

         ;; Look up *C*ommands.
         ;;
         ;; By default, C-h C is bound to describe `describe-coding-system'. I
         ;; don't find this very useful, but it's frequently useful to only
         ;; look at interactive functions.
         ("C-h C" . #'helpful-command)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq dired-listing-switches "-lahvF  --group-directories-first")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For documentation, see https://github.com/alezost/mwim.el
(use-package mwim
  :ensure t
  :bind (("C-a" . 'mwim-beginning-of-code-or-line)
         ("C-e" . 'mwim-end-of-code-or-line)
         ("<home>" . 'mwim-beginning-of-line-or-code)
         ("<end>" . 'mwim-end-of-line-or-code)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For documentation, see https://github.com/DarthFennec/highlight-indent-guides
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package highlight-indent-guides
  :ensure t
  :init
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive 'stack)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For documentation, see https://github.com/zenozeng/yafolding.el
;; see also https://github.com/tarsius/bicycle as an alternative
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yafolding
  :ensure t
  :bind ("s-d y" . 'yafolding-discover)
  :config
  (defvar yafolding-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
      (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
      (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
      map))

  (add-hook 'prog-mode-hook
          (lambda () (yafolding-mode))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; When you try to kill a buffer that you modified, Emacs warns you that the
;; buffer is changed, and asks if you really want to kill it. The following
;; settings let you easily see what changed since your last save.
;;
;; By default, we set the visibility of highlighted changes to nil.
;; If you want to see them, please run:
;;
;;     M-x highlight-changes-visible-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil) ; initially hide
(set-face-foreground 'highlight-changes nil)
(set-face-background 'highlight-changes "blue")
(set-face-foreground 'highlight-changes-delete nil)
(set-face-background 'highlight-changes-delete "#916868")

;; Remove the highlighted changes after the buffer is saved
(add-hook 'after-save-hook
          (lambda ()
            (when highlight-changes-mode
              (save-restriction
                (widen)
                (highlight-changes-remove-highlight (point-min) (point-max))))))

;; Put a little square box on the left fring to indicate changed lines.
(eval-after-load "hilit-chg"
  '(progn
     (defvar highlight-fringe-mark 'filled-square
       "The fringe bitmap name marked at changed line. Should be
selected from `fringe-bitmaps'.")
     (defadvice hilit-chg-make-ov (after hilit-chg-add-fringe activate)
       (mapc (lambda (ov)
           (if (overlay-get ov 'hilit-chg)
           (let ((fringe-anchor (make-string 1 ?x)))
             (put-text-property 0 1 'display
                    (list 'left-fringe highlight-fringe-mark)
                    fringe-anchor)
             (overlay-put ov 'before-string fringe-anchor))))
         (overlays-at (ad-get-arg 1))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up `pdf-tools', and enable automatic refresh when PDF changes. This is
;; useful in workflows where PDF is generated by another program such as LaTeX,
;; `asciidoc', etc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; initialise
(use-package pdf-tools
  :ensure t
  
  :bind ((:map pdf-view-mode-map
               ("C-s" . 'isearch-forward) ;; use isearch instead of swiper
               ("h" . 'pdf-annot-add-highlight-markup-annotation)
               ("t" . 'pdf-annot-add-text-annotation)
               ("D" . 'pdf-annot-delete)))
  
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)

  ;; more fine-grained zooming
  (setq pdf-view-resize-factor 1.1)

  ;; wrapper for save-buffer ignoring arguments
  (defun bjm/save-buffer-no-args ()
    "Save buffer ignoring arguments"
    (save-buffer))

  ;; wait until map is available
  (with-eval-after-load "pdf-annot"
    (define-key
      pdf-annot-edit-contents-minor-mode-map
      (kbd "<return>") 'pdf-annot-edit-contents-commit)
    (define-key
      pdf-annot-edit-contents-minor-mode-map
      (kbd "<S-return>") 'newline)
    ;; save after adding comment
    (advice-add 'pdf-annot-edit-contents-commit
                :after 'bjm/save-buffer-no-args))

  ;; auto refresh pdf-view when file changes
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
  (add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This is for setting up `adoc-mode' and automatically generating the PDF file
;; for the current AsciiDoc that you are editing. It adds a new hook (function)
;; to be automatically run after each save action in `adoc-mode'.
;; 
;; If you enable `auto-revert-mode' in your PDF viewing mode, then you'll be
;; to have Live Preview functionality for your AsciiDoc document.
;;
;; The following code assumes the existence of `asciidoc' package. For more
;; details, please see `http://asciidoc.org/'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package adoc-mode
  :ensure t
  :config
  ;; setup files ending in ".adoc" to open in `adoc-mode'
  (add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))

  (defun run-a2x-to-generate-pdf ()
    "Generate the PDF representation of the current file."
    (shell-command-to-string (format "a2x -f pdf %s" buffer-file-name)))

  (add-hook 'adoc-mode-hook
            (lambda () 
              (add-hook 'after-save-hook
                        'run-a2x-to-generate-pdf
                        nil
                        'make-it-local))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up MS Windows specific configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Check if system is Microsoft Windows
(defun my-system-type-is-windows ()
  "Return true if system is Windows-based (at least up to Win7)"
  (string-equal system-type "windows-nt"))

(when (my-system-type-is-windows)
  (setq ispell-program-name "aspell")
  ;; Set default font
  (set-face-attribute 'default nil
                      :family "Consolas"
                      :height 100
                      :weight 'normal
                      :width 'normal))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up default font
;; See also:
;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
;; https://github.com/mickeynp/ligature.el
;; https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 100
                    :weight 'normal
                    :width 'normal)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit configuration
;; https://magit.vc/
;; https://magit.vc/manual/magit-refcard.pdf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package magit
  :ensure t)

(use-package magit-annex
  :ensure t)

(use-package magit-filenotify
  :ensure t)

(use-package magit-find-file
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modern package management with paradox
;; https://github.com/Malabarba/paradox
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package paradox
  :ensure t
  :init
  ;;(setq paradox-github-token t)
  (setq paradox-display-download-count t)
  (setq paradox-display-star-count t)
  :config
  (paradox-enable))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ripgrep configuration
;; https://rgel.readthedocs.io/en/2.0.3/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings)
  ;;If you prefer to use a magit like interface as a complement to regular key
  ;;maps, replace (rg-enable-default-bindings) with (rg-enable-menu). The menus
  ;;are built with transient, which means that the menus can be modified in the
  ;;same way as in magit.
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; counsel-tramp and ssh configuration
;; https://github.com/masasam/emacs-counsel-tramp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package counsel-tramp
  :ensure t
  :init
  (setq tramp-default-method "ssh")
  :bind
  ("C-c C-c s" . 'counsel-tramp)
  :config
  (add-hook 'counsel-tramp-pre-command-hook
            '(lambda () (global-aggressive-indent-mode 0)
				       (projectile-mode 0)
				       (editorconfig-mode 0)))
  (add-hook 'counsel-tramp-quit-hook
            '(lambda () (global-aggressive-indent-mode 1)
			         (projectile-mode 1)
			         (editorconfig-mode 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
