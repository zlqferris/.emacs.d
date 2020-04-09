(use-package emmet-mode :ensure t)

(use-package web-mode
  :ensure t
  :config
  (defun @-web-mode-hook ()
    (setq web-mode-markup-indent-offset 4)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-css-indent-offset 4))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-hook 'web-mode-hook '@-web-mode-hook)
  (setq tab-width 4)
  (add-hook 'web-mode-hook 'emmet-mode))

(use-package typescript-mode :ensure t)

(use-package tide :ensure t)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (eldoc-mode 1)
  (tide-hl-identifier-mode t)
  (company-mode))

(setq company-tooltip-align-annotations t)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; formats the buffer before saving
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "vue" (file-name-extension buffer-file-name))
              (setup-tide-mode))))


(provide 'init-web)
