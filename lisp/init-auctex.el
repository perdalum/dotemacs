;; AUC-TeX
 	
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq TeX-save-query nil) ; Autosave before compiling
(add-hook 'TeX-mode-hook #'TeX-fold-mode) ;; Automatically activate TeX-fold-mode.
;;(setq-default TeX-master nil) ; Query for master file.

;; Activate shell-escape so we can compile with master document
(eval-after-load "tex" 
  '(setcdr (assoc "LaTeX" TeX-command-list)
	   '("%`%l%(mode) -shell-escape%' %t"
	     TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))



;; RefTeX
(setq reftex-toc-split-windows-horizontally t) ; show TOC at the left

(defun mg/LaTeX-auto-fill-function ()
  (if (member (LaTeX-current-environment) '("tabular"))
      (align-current)
    (do-auto-fill)))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq auto-fill-function 'mg/LaTeX-auto-fill-function)))

(defun toggle-LaTeX-rectangular-edit-ready-mode ()
  (interactive)
  (if (equal truncate-lines nil)
      (progn
        (set-face-attribute
         'font-latex-subscript-face nil
         :height 1.0)
        (set-face-attribute
         'font-latex-superscript-face nil
         :height 1.0)
        (setq truncate-lines t)
        (message "LaTeX-rectangular-edit-ready-mode has been switched on"))
    (progn
      (set-face-attribute
       'font-latex-subscript-face nil
       :height 0.8)
      (set-face-attribute
       'font-latex-superscript-face nil
       :height 0.8)
      (setq truncate-lines nil)
      (message "LaTeX-rectangular-edit-ready-mode has been switched off"))))

(provide 'init-auctex)
