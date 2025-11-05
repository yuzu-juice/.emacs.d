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
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; leaf
(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status)))
(leaf undo-tree
  :ensure t
  :global-minor-mode global-undo-tree-mode
  :custom
  (undo-tree-auto-save-history . nil))
(leaf gcmh
  :ensure t
  :global-minor-mode t
  :custom
  (gcmh-verbose . t))
(leaf doom-themes
  :ensure t
  :config
  (load-theme 'doom-solarized-light t))
(leaf doom-modeline
  :ensure t
  :global-minor-mode t
)
(leaf beacon
  :ensure t
  :global-minor-mode t
  :custom ((beacon-color . "#FAB27B")))
(leaf corfu
  :ensure t
  :global-minor-mode global-corfu-mode
  :custom
  (corfu-cycle . t)
  (corfu-auto . t)
  (text-mode-ispell-word-completion . nil))
(leaf cape
  :ensure t)
(leaf flymake
  :global-minor-mode t)
(leaf mozc
  :ensure t
  :config
  (setq default-input-method "japanese-mozc"))
(leaf :font
  :config
  (leaf nerd-icons
    :ensure t)
  )
(leaf puni
  :ensure t
  :global-minor-mode puni-global-mode)

;; 現在位置表示
(column-number-mode t)

;; 行番号表示
(global-display-line-numbers-mode t)

;; カーソルの色を変更
(set-cursor-color "#F79428")

;; 最初の挨拶非表示
(setq inhibit-startup-message t)

;; key bind
(global-set-key (kbd "C-t") 'delete-window)
(global-set-key (kbd "C-h") 'delete-backward-char)

;; UTF-8を優先
(prefer-coding-system 'utf-8)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
