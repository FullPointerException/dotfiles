;; Change from 800kB to 50 Mb
(setq gc-cons-threshold (* 50 1000 1000))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Loaded in %s."
                     (format "%.2f seconds"
                             (float-time
                            (time-subtract after-init-time before-init-time))))))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(set-frame-parameter (selected-frame) 'alpha '(95 . 90))

(add-to-list 'default-frame-alist '(alpha . (95 . 90)))

(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message ""
      intial-buffer-choice t
      large-file-warning-threshold nil ; Don't warn on opening large files
      vc-follow-symlinks t) ; Don't warn for opening sym-link'ed files

(scroll-bar-mode -1) ; No scroll bars

(tool-bar-mode -1) ; No toolbar

(tooltip-mode -1) ; No tooltips

(menu-bar-mode -1) ; No menu bar

(set-fringe-mode 10) ; set left and right fringe widths

;; Disable audio bell
(setq ring-bell-function 'ignore)

;; Disable visible bell
(setq visible-bell nil)

;; Default tab sizes
(setq-default tab-width 4)

(set-frame-parameter (selected-frame) 'fullscreen 'maximized)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(column-number-mode) ; Enable column numbers in mode bar

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override to turn line numbers back off in org mode
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq mouse-wheel-scroll-amount
      '(1 ((shift) . 1)
          ((control) . nil))) ; scroll 1 line at a time

(setq mouse-wheel-progressive-speed nil ; no acceleration
      mouse-wheel-follow-mouse 't ; scroll window under mouse
      scroll-step 1) ; keyboard scroll one line at a time

(setq-default frame-title-format '("emacs - %b"))

(defun fullpointer/toggle-line-beginning ()
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))

(global-set-key (kbd "C-a") 'fullpointer/toggle-line-beginning)

;; Define the backup dir
(defvar fullpointer-backup-dir (expand-file-name ".backup" user-emacs-directory))

;; Make sure it exists
(if (not (file-exists-p fullpointer-backup-dir))
	(make-directory fullpointer-backup-dir t))

(setq  backup-by-copying t ;; Don't clobber symlinks
	   backup-directory-alist `((".*" . ,fullpointer-backup-dir)) ;; Backup all files in the backup dir
       auto-save-file-name-transforms `((".*" ,fullpointer-backup-dir t))
	   delete-old-versions t ;; Silently delete excess backups
	   kept-new-versions 5 ;; Newest number to keep
	   kept-old-versions 2 ;; Oldest number to keep
	   make-backup-files t ;; Create backups when first saving files
	   version-control t) ;; Version number the backups

(setq auto-save-default t ;; Autosave visited files
	  auto-save-interval 1000 ;; Autosave after this many keystrokes
	  auto-save-timeout (* 60 5)) ;; Seconds to wait before autosave

(setq delete-by-moving-to-trash t)

(setq-default create-lockfiles nil)

(setq-default indent-tabs-mode nil
			  indent-line-function 'insert-tab
			  tab-width 4
			  c-basic-offset 4
			  js-switch-indent-offest 4)

;; Setup the package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; If the archive is empty, refresh its contents
(unless package-archive-contents
  (package-refresh-contents))

;; Get use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package doom-themes :defer t)

(load-theme 'doom-acario-dark t)

(use-package diminish)

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package projectile
  :bind-keymap
  ("C-c p" . projectile-command-map) ; set C-c p as projectile leader
  :custom
  (projectile-completion-system 'ivy)
  :demand t
  :config
  (projectile-mode 1))

(use-package rg)

(use-package yasnippet
  :diminish yas-minor-mode
  :hook ((prog-mode org-mode) . yas-minor-mode)
  :config 
  (setq yas-snippet-dirs (append '("/home/josh/.emacs.d/work/snippets")
                                 yas-snippet-dirs))
  (yas-reload-all))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package command-log-mode)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.7))

(use-package editorconfig
  :ensure t
  :diminish
  :config
  (editorconfig-mode 1))

(add-hook 'prog-mode-hook #'editorconfig-mode-apply)

(defun fullpointer/org-mode-setup ()
  (org-indent-mode) ; Enable org-indent-mode by default
  (diminish org-indent-mode) ; Do not show org-indent-mode minor mode in modeline
  (visual-line-mode 1) ; Wrap lines after a certain width
  (auto-fill-mode 0)) ; Disable automatically inserting new lines while typing

(use-package org
  :defer t
  :hook (org-mode . fullpointer/org-mode-setup)
  :bind (:map org-mode-map
			  ("<f5>" . org-redisplay-inline-images)
			  ("C-<f5>" . org-latex-preview))
  :config
  (add-to-list 'org-src-lang-modes '("dot" . "graphviz-dot"))
  (setq
   org-adapt-indentation nil ; Set indentation based on sub-heading level in outline
   org-confirm-babel-evaluate nil ; Do not require a confirmation when executing code blocks in an org buffer
   org-edit-src-content-indentation 0 ; Contents of src block have no extra indentation
   org-ellipsis " ▼" ; Set the expand for more glyph
   org-fontify-quote-and-verse-blocks t ; Give special fact to begin_quote and begin_verse blocks
   org-fontify-whole-heading-line t ; Fontifies the whole heading line
   org-hide-emphasis-markers t ; Hide markers for bold, italics, etc.
   org-image-actual-width nil ; Allow inline images to be resized
   org-latex-create-formula-image-program 'dvisvgm ; Use dvisvgm instead of the default dvipng for better inline images
   org-src-preserve-indentation nil ; Remove the leading whitespace for the block when tangling
   org-return-follows-link nil ; Do not follow a link when pressing return,
   org-src-fontify-natively t ; Fontify code in code blocks
   org-src-tab-acts-natively t ; Make TAB indent code in src blocks like their language
   org-startup-folded 'nofold) ; Default to content visible on startup
  (plist-put org-format-latex-options :scale 1.5) ;; Bigger inline latex
  (org-babel-do-load-languages ;; Load the languages in org mode
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)
	   (dot . t)
	   (css . t)
	   (js . t)
	   (latex . t)
	   (plantuml . t))))

(with-eval-after-load 'org-faces
  (dolist
	  (face '((org-level-1 . 1.75)
			  (org-level-2 . 1.50)
			  (org-level-3 . 1.25)
			  (org-level-4 . 1.10)
			  (org-level-5 . 1.05)
			  (org-level-6 . 1.00)
			  (org-level-7 . 1.00)
			  (org-level-8 . 1.0)
			  (org-document-title . 2.0)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face))))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○")))

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(with-eval-after-load 'org-faces
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-formula nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-link nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED"))
      org-todo-keyword-faces
      '(("BLOCKED" . "red") ("IN PROGRESS" . "orange")))

(defun fullpointer/org-mode-visual-fill ()
    (setq visual-fill-column-width 200
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . fullpointer/org-mode-visual-fill))

(use-package plantuml-mode
  :defer t
  :custom
  (org-plantuml-jar-path (expand-file-name "~/.local/bin/plantuml.jar")))

(c-set-offset 'comment-intro 0)

(c-set-offset 'innamespace 0)

(c-set-offset 'case-label '+)

(c-set-offset 'access-label 0)

(c-set-offset 'cpp-macro 0 nil)

(c-set-offset 'substatement-open 0)

(c-set-offset 'brace-list-intro '+)

(c-set-offset 'arglist-intro '+)

(use-package modern-cpp-font-lock
  :diminish t
  :init (modern-c++-font-lock-global-mode t))
