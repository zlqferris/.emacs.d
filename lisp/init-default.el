;; 设置文件编码
(prefer-coding-system 'utf-8)

(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")

;; 关闭警示音
(setq ring-bell-function 'ignore)

;; 显示行号
(global-linum-mode t)

;; 关闭文件备份
(setq make-backup-files nil)

;; 自动加载外部修改过的文件
(global-auto-revert-mode t)

;; 关闭自动保存
(setq auto-save-default nil)

;; 选中字符自动删除
(delete-selection-mode t)

;; 显示匹配的括号
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 删除单词
(global-set-key (kbd "C-w") 'backward-kill-word)

;; 显示当前电池电量
(display-battery-mode 1)

;; tab键设为4空格
(setq tab-width 4)

;; 恢复关闭前的页面
;;(desktop-save-mode 1)

(provide 'init-default)
