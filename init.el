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

;; leaf package install
;;; magit
(leaf magit :ensure t :bind (("C-x g" . magit-status)))
;;; undo-tree
(leaf undo-tree
  :ensure t
  :global-minor-mode global-undo-tree-mode
  :custom
  (undo-tree-auto-save-history . nil)
)
;;; corfu
(leaf corfu
  :ensure t
  :global-minor-mode global-corfu-mode
  :custom
  (corfu-cycle . t)
  (corfu-auto . t)
  (text-mode-ispell-word-completion . nil)
)

;;; cape
(leaf cape
  :ensure t
)

;; 現在位置表示
(column-number-mode t)

;; 行番号表示
(global-display-line-numbers-mode t)

;; 最初の挨拶非表示
(setq inhibit-startup-message t)

;; key bind
(global-set-key (kbd "C-t") 'delete-window)

;; byte compile warning 非表示
(setq byte-compile-warnings nil)

