;;;;;;;;;;;;;;;;;;;;;;;
;; Adjust initial UI ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; Disable startup splash screen
(setq inhibit-startup-screen t)

;; Disable top-level menus, buttons, and scrollbars
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; Add line numbers to all open windows
(global-linum-mode)

;; Indent line numbers to 4 digits with a line separator
(setq linum-format "%4d \u2502 ")

;; Wrap lines at the word border
(global-visual-line-mode t)

;; Show column number in mode line
(column-number-mode 1)

;; Prevent re-centering when going up and down document with arrow-keys
(setq scroll-conservatively 101)

;; Auto close bracket insertion. New in emacs 24. Includes brackets, parenthesis, etc
(electric-pair-mode 1)

;; Enable the display of current time in the mode line
(display-time-mode 1)

;; Disable warning bell
(setq ring-bell-function 'ignore)

;; Minibuffer auto-completion
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;;;;;;;;;;;;;;;;
;; Load themes ;;
;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp/spacemacs-theme")
(require 'spacemacs-common)
(load-theme 'spacemacs-dark t)

;;(add-to-list 'load-path "~/.emacs.d/lisp/emacs-doom-themes")
;;(require 'doom-themes)
;;(load-theme 'doom-one t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load external packages ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; EVIL
(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(require 'evil)
(evil-mode 1)
(setq evil-default-state 'emacs)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/lisp/popup-el")
(add-to-list 'load-path "~/.emacs.d/lisp/auto-complete")
(require 'auto-complete-config)
(require 'auto-complete)
(ac-config-default)
(global-auto-complete-mode t)

;; While we're at it, let's setup flyspell to work in all programming
;; languages and make sure auto-complete is compatible with it
(if (string= system-type "windows-nt")
    (progn
      (add-to-list 'exec-path "~/.emacs.d/windows_binaries/hunspell-1.3.2-3-w32-bin/bin")
      (setq ispell-program-name "hunspell")
      )
  )
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(ac-flyspell-workaround)

;; Htmlize (for some reason Emacs 26.1 is missing this...)
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-htmlize")
(require 'htmlize)

;; And let's also setup ditaa
(setq org-ditaa-jar-path "~/.emacs.d/windows_binaries/ditaa/service/web/lib/ditaa0_10.jar")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)))

;; which-key
(add-to-list 'load-path "~/.emacs.d/lisp/which-key")
(require 'which-key)
(which-key-mode)

;; multiple-cursors
(add-to-list 'load-path "~/.emacs.d/lisp/multiple-cursors.el")
(require 'multiple-cursors)

;; expand-region
(add-to-list 'load-path "~/.emacs.d/lisp/expand-region.el")
(require 'expand-region)

;; key-chord
(add-to-list 'load-path "~/.emacs.d/lisp/key-chord")
(require 'key-chord)
(setq key-chord-one-key-delay 0.3)
(setq key-chord-two-keys-delay 0.3)
(key-chord-mode 1)

;; key-seq
(add-to-list 'load-path "~/.emacs.d/lisp/key-seq.el")
(require 'key-seq)

;;;;;;;;;;;;;
;; Backups ;;
;;;;;;;;;;;;;

;; Save all locally generated backups in one place
(setq backup-directory-alist '(("." . "~/emacsFileBackups")))

;; DON'T backup any files on the SERVER if accessed through TRAMP
;; (these will still get saved locally in the ~/emacsFileBackups folder)
(setq tramp-backup-directory-alist nil)

;; Disk space is cheap. Backup the same file(s) very often!
(setq version-control t)      ;; Use version numbers for backups
(setq delete-old-versions 1)  ;; Don't ask, and never delete excess backup versions
(setq backup-by-copying t)    ;; Copy all files, don't rename them
(setq vc-make-backup-files t) ;; Backup versioned files

;; Backup on every save, not just on a new buffer session
(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))
(add-hook 'before-save-hook 'force-backup-of-buffer)

;; Save various histories (i.e. minibuffer, kill ring, searches, etc)
(setq kill-ring-max 100)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(savehist-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Abbreviations and skeletons ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use abbreviations in all modes and ask before saving any new ones
(setq abbrev-file-name "~/.emacs.d/custom_abbrevs.el")
(setq save-abbrevs t)
(setq-default abbrev-mode t)

(defun insert-org-header(title author email)
  "Use to prompt and insert title, author, and email"
  (interactive "sTitle: 
sAuthor: 
sEmail: ")
  (insert "#+TITLE: " title "\n")
  (insert "#+AUTHOR: " author "\n")
  (insert "#+EMAIL: " email "\n")
  (message "Inserted ORG header")
  )

(defun insert-sql-create-table(table_name)
  "Use to prompt and insert SQL CREATE TABLE query"
  (interactive "sTable name: ")
  (insert "CREATE TABLE " table_name " ()")
  (backward-char 1))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom key bindings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Open Emacs initialization file with F5 key
(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

(defun zip-root()
  "Call in eshell to make a .zip of your emacshome directory"
  (interactive)
  (insert "zip -r ~/../emacshome.zip ~/."))

;; Expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Set multiple cursors with the mouse
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; Keyboard-driven solution for mc/add-cursor-on-click
;; C-S-Space to mark cursors, C-S-return to enter multiple-cursor-mode
(defun mc/toggle-cursor-at-point ()
  "Add or remove a cursor at point."
  (interactive)
  (if multiple-cursors-mode
      (message "Cannot toggle cursor at point while `multiple-cursors-mode' is active.")
    (let ((existing (mc/fake-cursor-at-point)))
      (if existing
          (mc/remove-fake-cursor existing)
        (mc/create-fake-cursor-at-point)))))
(add-to-list 'mc/cmds-to-run-once 'mc/toggle-cursor-at-point)
(add-to-list 'mc/cmds-to-run-once 'multiple-cursors-mode)
(global-set-key (kbd "C-S-SPC") 'mc/toggle-cursor-at-point)
(global-set-key (kbd "<C-S-return>") 'multiple-cursors-mode)

(setq japanese-input "")
(defun toggle-japanese-system()
  "Set Japanese language as secondary input"
  (interactive)
  (if (string= japanese-input "")
      (progn
	(setq japanese-input "japanese")
	(set-input-method japanese-input)
	)
    (progn
      (if (string= japanese-input "japanese")
	  (progn
	    (setq japanese-input "japanese-katakana")
	    (set-input-method japanese-input)
	    )
	(progn
	  (setq japanese-input "japanese")
	  (set-input-method japanese-input)
	  )
	)
      )
    )
  )

;; Key-chords and key-sequences (let's save our pinky finger, it uses Ctrl too much!)
(key-seq-define-global "44" 'ispell-word)

;; Cut, copy, and paste
(key-seq-define-global "xx" 'kill-region)
(key-seq-define-global "cc" 'kill-ring-save)
(key-seq-define-global "vv" 'yank)

;; Saving and quitting
(key-seq-define-global "xs" 'save-buffer)
(key-seq-define-global "xc" 'save-buffers-kill-terminal)
(key-seq-define-global "qq" 'save-buffers-kill-terminal)

;; Windows and buffers
(key-seq-define-global "00" 'delete-window)
(key-seq-define-global "11" 'delete-other-windows)
(key-seq-define-global "22" 'split-window-below)
(key-seq-define-global "33" 'split-window-right)
(key-seq-define-global "xo" 'other-window)
(key-seq-define-global "zx" 'next-buffer)
(key-seq-define-global "xz" 'previous-buffer)
(key-seq-define-global "xk" 'kill-buffer)

;; Other
(key-seq-define-global "xf" 'find-file)
(key-seq-define-global "^^" (lambda() (interactive)(if (string= major-mode "org-mode")
						       (org-export-dispatch)
						     (message "You must be in Org Mode to export"))))
(global-set-key (kbd "C-x j") 'toggle-japanese-system)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; その他 i.e. things I don't always want enabled, but may use here and there ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save cursor position

;; Emacs 25.1 and above
;;(save-place-mode 1)

;; Emacs 24.5 and below
;;(require 'saveplace)
;;(setq-default save-place t)

;;;;;;;;;;;;;;;;;;;;;
;; Sensitive stuff ;;
;;;;;;;;;;;;;;;;;;;;;

(load "~/.emacs.d/sensitive.el")
