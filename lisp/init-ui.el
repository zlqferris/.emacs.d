;; 关闭toolbar
(tool-bar-mode -1)

;; 关闭滚动条
(scroll-bar-mode -1)

;; 关闭开始页面
(setq inhibit-splash-screen t)

;; 修改光标样式
(setq-default cursor-type 'bar)

;; 初始化全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 行高亮
(global-hl-line-mode t)

;; 标题栏透明
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(set-face-background 'vertical-border (face-background 'default))
(set-face-foreground 'vertical-border "grey")

(provide 'init-ui)
