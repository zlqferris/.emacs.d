(use-package lsp-python-ms
  :ensure t
  :defer t
  :demand nil
  :config
  (progn
    (setq lsp-python-ms-executable
	  "~/python-language-server/output/bin/Release/osx-x64/publish/Microsoft.Python.LanguageServer")
    (setq lsp-python-ms-python-executable-cmd "python3")
    (setq lsp-python-ms-extra-paths (list "."))
    (setq python-shell-interpreter "/usr/local/bin/python3")
    (setq python-shell-completion-native-enable nil)
    (setq python-shell-completion-native-disabled-interpreters '("python"))
    (setq lsp-python-ms-dir (file-name-directory lsp-python-ms-executable))))

(use-package python
  :mode ("\\.py" . python-mode)
  :ensure t)

(use-package python-black
  :ensure t
  :demand t
  :after python
  :config
  (python-black-on-save-mode)
  (global-set-key (kbd "C-c f") 'python-black-buffer))


(provide 'init-python)
