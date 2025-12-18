;;; init.el --- setting file -*- lexical-binding: t -*-
;;; Author: yuzu-juice
;;; Commentary:
;;; Code:

;; Suppress byte compile warnings
(setq byte-compile-warnings nil)

;; Package archives and initialization
(require 'package)
(setq package-archives '(("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Core Emacs Settings
(setq column-number-mode t)
(global-display-line-numbers-mode 1)
(setq inhibit-startup-message t)
(setq require-final-newline t)
(desktop-save-mode 1)
(global-auto-revert-mode 1)

;; Cursor color and coding system
(set-cursor-color "#F79428")
(prefer-coding-system 'utf-8)
(setq compilation-scroll-output t)

;; Keybindings
(global-set-key (kbd "C-t") 'delete-window)
(global-set-key (kbd "C-h") 'delete-backward-char)

;; UI Packages
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-solarized-light t))

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))

(use-package beacon
  :ensure t
  :config (beacon-mode 1)
  :custom
  (beacon-color "#FAB27B"))

;; Editing Packages
(use-package undo-tree
  :ensure t
  :hook ((prog-mode . undo-tree-mode)
         (markdown-mode . undo-tree-mode)
         (text-mode . undo-tree-mode))
  :custom
  (undo-tree-auto-save-history nil))

(use-package gcmh
  :ensure t
  :config (gcmh-mode 1)
  :custom
  (gcmh-verbose t))

;; Programming Packages
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package web-mode
  :mode
  (("\\.js\\'" . web-mode)
   ("\\.vue\\'" . web-mode)
   ("\\.ts\\'" . web-mode)))


(use-package typescript-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (typescript-ts-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (js2-mode . lsp-deferred)
         (json-ts-mode . lsp-deferred)
	 (vue-mode . lsp-deferred))
  :custom
  (lsp-use-plists t))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode)

(use-package projectile
  :ensure t
  :config (projectile-mode 1)

  (add-hook 'emacs-startup-hook
	    (lambda ()
              (when (projectile-project-p)
		(require 'treemacs-projectile)
		(treemacs-display-current-project-exclusively)))))

;; Git Packages
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package diff-hl
  :ensure t
  :hook ((prog-mode . diff-hl-mode)
         (magit-refresh-buffer . diff-hl-magit-post-refresh)))

;; File browser Packages
(use-package treemacs
  :ensure t
  :custom
  (treemacs-is-never-other-window t)
  :bind ("<f8>" . treemacs)
  :config
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile)
  :config
  (add-hook 'projectile-after-switch-project-hook
            #'treemacs-display-current-project-exclusively))

;; Other Packages
(use-package mozc
  :ensure t
  :config
  (setq default-input-method "japanese-mozc"))

(when (executable-find
       (cond ((eq system-type 'darwin) "/opt/homebrew/bin/wakatime-cli")
             ((eq system-type 'gnu/linux)
              (expand-file-name "~/.wakatime/wakatime-cli"))))
  (use-package wakatime-mode
    :ensure t
    :config (global-wakatime-mode 1)))

(use-package vterm
  :ensure t)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(beacon company corfu diff-hl doom-modeline doom-themes gcmh lsp-ui
	    mozc treemacs-magit treemacs-projectile typescript-mode
	    undo-tree vterm vue-mode web-mode yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
