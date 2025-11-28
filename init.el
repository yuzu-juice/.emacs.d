;;; init.el --- setting file -*- lexical-binding: t -*-

;;; Author: yuzu-juice
;;; Commentary:

;;; Code:
;; byte compile warning 非表示
(setq byte-compile-warnings nil)

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;;
;; Core Emacs Settings
;;
(leaf emacs
  :custom
  ;; 現在位置表示
  (column-number-mode . t)
  ;; 行番号表示
  (global-display-line-numbers-mode . t)
  ;; 最初の挨拶非表示
  (inhibit-startup-message . t)
  ;; 最終行に空行を強制
  (require-final-newline . t)
  ;; 起動時に最後に開いていたファイルを開く
  (desktop-save-mode . 1)
  ;; バッファの自動リフレッシュ
  (global-auto-revert-mode . 1)
  :config
  ;; カーソルの色を変更
  (set-cursor-color "#F79428")
  ;; UTF-8を優先
  (prefer-coding-system 'utf-8)
  :bind
  (("C-t" . delete-window)
   ("C-h" . delete-backward-char)))

;;
;; Ui Packages
;;
(leaf doom-themes
  :ensure t
  :config (load-theme 'doom-solarized-light t))

(leaf doom-modeline
  :ensure t
  :global-minor-mode t)

(leaf beacon
  :ensure t
  :global-minor-mode t
  :custom ((beacon-color . "#FAB27B")))

;;
;; Editing Packages
;;
(leaf undo-tree
  :ensure t
  :hook ((prog-mode . undo-tree-mode)
	 (markdown-mode . undo-tree-mode)
	 (text-mode . undo-tree-mode))
  :custom
  (undo-tree-auto-save-history . nil))

(leaf gcmh
  :ensure t
  :global-minor-mode t
  :custom
  (gcmh-verbose . t))

;;
;; Programming Packages
;;
(leaf lsp-mode
  :ensure t
  :hook ((c-mode . lsp)
         (c++-mode . lsp)
	 (typescript-ts-mode . lsp)
	 (tsx-ts-mode . lsp)
	 (typescript-mode . lsp)
	 (js-mode . lsp)
	 (js2-mode . lsp)
	 (json-ts-mode . lsp))
  :commands lsp)

(leaf lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
)

(leaf projectile
  :ensure t
  :global-minor-mode projectile-mode)

;;
;; Git Packages
;;

(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(leaf diff-hl
  :ensure t
  :hook
  ((prog-mode . diff-hl-mode)
   (magit-refresh-buffer . diff-hl-magit-post-refresh)))

;;
;; File browser Packages
;;

(leaf treemacs
  :ensure t
  :custom
  (treemacs-is-never-other-window . t)
  :bind
  ("<f8>" . treemacs)
  (:treemacs-mode-map
   ([mouse-1] . #'treemacs-single-click-expand-action))
  )

(leaf treemacs-magit
  :ensure t
  :after (treemacs magit))

(leaf treemacs-projectile
  :ensure t
  :after (treemacs projectile)
  :config
  (add-hook 'projectile-after-switch-project-hook
            #'treemacs-display-current-project-exclusively))


;;;
;;; icons
;;;
(leaf nerd-icons
  :ensure t)

(leaf treemacs-nerd-icons
  :ensure t
  :after treemacs nerd-icons
  :config
  (treemacs-nerd-icons-config))

;;
;; Other Packages
;;

(leaf mozc
  :ensure t
  :config
  (setq default-input-method "japanese-mozc"))

(when (executable-find
       (cond ((eq system-type 'darwin) "/opt/homebrew/bin/wakatime-cli")
             ((eq system-type 'gnu/linux)
              (expand-file-name "~/.wakatime/wakatime-cli"))))
  (leaf wakatime-mode :ensure t :global-minor-mode t))

(leaf vterm
  :ensure t)



;;; init.el ends here
