(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook
  (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp)))
;;  ((js-mode css-mode scss-mode web-mode) . lsp)
  :init
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0)
;;  (require 'lsp-clients))
  )
  
(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

(use-package lsp-ui
  :ensure t
  :custom-face
  ;; (lsp-ui-doc-background ((t (:background ni))))
  :init (setq lsp-ui-doc-enable t
           lsp-ui-doc-include-signature t
           lsp-ui-doc-position 'at-point
           lsp-ui-doc-border (face-foreground 'default)

           ;; lsp-enable-snippet nil
           lsp-ui-sideline-enable nil)
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (global-set-key (kbd "C-c u") 'lsp-ui-imenu)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)

(provide 'init-programming)
