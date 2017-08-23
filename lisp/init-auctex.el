;; AUC-TeX
 	
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq TeX-save-query nil) ; Autosave before compiling
(add-hook 'TeX-mode-hook #'TeX-fold-mode) ;; Automatically activate TeX-fold-mode.
;;(setq-default TeX-master nil) ; Query for master file.

; Can't remember what this code does :-(
(eval-after-load "tex" 
  '(setcdr (assoc "LaTeX" TeX-command-list)
	   '("%`%l%(mode) -shell-escape%' %t"
	     TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))



;; RefTeX
(setq reftex-toc-split-windows-horizontally t) ; show TOC at the left

(provide 'init-auctex)
