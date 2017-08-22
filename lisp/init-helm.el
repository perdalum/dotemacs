(setq helm-buffers-fuzzy-matching t)
(setq helm-autoresize-mode t)
(setq helm-buffer-max-length 40)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
                
(provide 'init-helm)
