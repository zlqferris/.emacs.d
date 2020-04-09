(require 'package)
(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; 如果未安装use-package, 则安装之
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(package-initialize)

;; 按f2打开init-package.el
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-packages.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)

(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize)))

;; 自动补全
(use-package company
  :ensure t
  :init
  (progn
    (global-company-mode 1)))

;; 安装spacemacs-theme
(use-package spacemacs-theme
  :ensure
  :defer t
  :init
  (load-theme 'spacemacs-dark t))

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(use-package ag
  :ensure t)

(use-package ivy
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key (kbd "C-s") 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "M-y") 'counsel-yank-pop)
    (global-set-key (kbd "C-c s") 'counsel-ag)
    (global-set-key (kbd "C-h f") 'counsel-describe-function)
    (global-set-key (kbd "C-h v") 'counsel-describe-variable)))

(use-package counsel
  :ensure t
  :demand t)

(use-package swiper
  :ensure t
  :demand t)

;; 打开最近的文件
(use-package recentf
  :ensure t
  :config
  (progn
    (recentf-mode 1)
    (setq rencetf-max-menu-items 25)
    (global-set-key (kbd "C-x C-r") 'recentf-open-files)))

(require 'cl)

(defmacro def-pairs (pairs)
  "Define functions for pairing. PAIRS is an alist of (NAME . STRING)
conses, where NAME is the function name that will be created and
STRING is a single-character string that marks the opening character.

  (def-pairs ((paren . \"(\")
              (bracket . \"[\"))

defines the functions WRAP-WITH-PAREN and WRAP-WITH-BRACKET,
respectively."
  `(progn
     ,@(loop for (key . val) in pairs
             collect
             `(defun ,(read (concat
                             "wrap-with-"
                             (prin1-to-string key)
                             "s"))
                  (&optional arg)
                (interactive "p")
                (sp-wrap-with-pair ,val)))))

(def-pairs ((paren . "(")
            (bracket . "[")
            (brace . "{")
            (single-quote . "'")
            (double-quote . "\"")
            (underscores . "_")
            (back-quote . "`")))

;; 括号补全
(use-package smartparens
  :ensure t
  :config
  (progn
    (smartparens-global-mode t)
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    (global-set-key (kbd "C-<up>") 'sp-up-sexp)
    (global-set-key (kbd "M-<up>") 'sp-backward-up-sexp)
    (global-set-key (kbd "C-<down>") 'sp-down-sexp)
    (global-set-key (kbd "M-<down>") 'sp-backward-down-sexp)
    (global-set-key (kbd "C-<right>") 'sp-forward-slurp-sexp)
    (global-set-key (kbd "M-<riight>") 'sp-forward-barf-sexp)
    (global-set-key (kbd "C-<left>") 'sp-backward-slurp-sexp)
    (global-set-key (kbd "M-<left>") 'sp-backward-barf-sexp)
    (global-set-key (kbd "M-<space>") 'backward-kill-sexp)
    (global-set-key (kbd "M-[") 'sp-backward-unwrap-sexp)
    (global-set-key (kbd "M-]") 'sp-unwrap-sexp)
    (global-set-key (kbd "C-c (") 'wrap-with-parens)
    (global-set-key (kbd "C-c [") 'wrap-with-brackets)
    (global-set-key (kbd "C-c {") 'wrap-with-braces)
    (global-set-key (kbd "C-c '") 'wrap-with-single-quotes)
    (global-set-key (kbd "C-c \"") 'wrap-with-double-quotes)
    (global-set-key (kbd "C-c _") 'wrap-with-underscores)
    (global-set-key (kbd "C-c `") 'wrap-with-back-quotes)
    (global-set-key (kbd "C-M-f") 'sp-forward-sexp)
    (global-set-key (kbd "C-M-b") 'sp-backward-sexp)
    (global-set-key (kbd "C-M-a") 'sp-beginning-of-sexp)
    (global-set-key (kbd "C-M-e") 'sp-end-of-sexp)))


(use-package popwin
  :ensure t
  :init
  (popwin-mode 1))

(use-package window-numbering
  :ensure t
  :init
  (window-numbering-mode 1))

(use-package projectile
  :ensure t
  :init (projectile-global-mode 1)
  :config
  (progn
    (setq projectile-enable-caching t)
    (setq projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package counsel-projectile
  :ensure t
  :init (counsel-projectile-mode 1))

;; 括号颜色
(use-package rainbow-mode
  :ensure t
  :config
  (progn
    (defun @-enable-rainbow ()
      (rainbow-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow)))

(use-package rainbow-delimiters
  :ensure t
  :config
  (progn
    (defun @-enable-rainbow-delimiters ()
      (rainbow-delimiters-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow-delimiters)))

(use-package key-chord
  :ensure t)

;; 显示快捷键
(use-package which-key
  :ensure t
  :config
  (progn
    (which-key-mode)
    (which-key-setup-side-window-bottom)))

(use-package all-the-icons
  :ensure t)

;; neotree
(use-package neotree
  :ensure t
  :config
  (progn
    (setq neo-smart-open t)
    (setq neo-window-fixed-size nil)
    ;;(global-set-key (kbd "C-j k") 'neotree-toggle)
    (global-set-key (kbd "<f3>") 'neotree-dir)
    (setq neo-theme (if (display-graphic-p) 'icons 'nerd))
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (add-hook 'neotree-mode-hook
	      (lambda ()
                (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                (define-key evil-normal-state-local-map (kbd "`") 'neotree-quick-look)
                (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
                (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
                (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
                (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
                (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
                (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))))

(use-package undo-tree
  :ensure t
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package smart-tab
  :ensure t
  :config
  (progn
    (defun @-enable-smart-tab ()
      (smart-tab-mode))
    (add-hook 'prog-mode-hook '@-enable-smart-tab)))

;; evil
(use-package evil
  :ensure t
  :init
  (progn
    (use-package evil-leader
      :ensure t
      :init (global-evil-leader-mode)
      :config
      (progn
	(setq evil-leader/leader "SPC")
	(setq evil-want-C-u-scroll t)
	(evil-leader/set-key
	 "ff" 'counsel-find-file
	 "SPC" 'neotree-toggle
	 "bb" 'switch-to-buffer
	 "kk" 'kill-this-buffer
	 "0" 'select-window-0
	 "1" 'select-window-1
	 "2" 'select-window-2
	 "3" 'select-window-3
	 ":" 'counsel-M-x
	 "wd" 'delete-window
	 "wm" 'delete-other-windows)))
    (evil-mode 1))
  :config
  (progn
    (setcdr evil-insert-state-map nil)
    (key-chord-mode 1)
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)))
(provide 'init-packages)
