;; ;; Pretty arrows and magrittr pipes in R
;; (defvar pretty-alist
;;   (cl-pairlis '() '()))
;; (add-to-list 'pretty-alist '("%>%" . "⇛"))
;; (add-to-list 'pretty-alist '("<-" . "⇐"))
;; (defun pretty-things ()
;;   (mapc
;;    (lambda (x)
;;      (let ((word (car x))
;;            (char (cdr x)))
;;        (font-lock-add-keywords
;;         nil
;;         `((,(concat "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[a-zA-Z]")
;;             (0 (progn
;;                  (decompose-region (match-beginning 2) (match-end 2))
;;                  nil)))))
;;        (font-lock-add-keywords
;;         nil
;;         `((,(concat "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[^a-zA-Z]")
;;             (0 (progn
;;                  (compose-region (match-beginning 2) (match-end 2)
;;                   ,char)
;;                  nil)))))))
;;    pretty-alist))

;; (add-hook 'R-mode-hook
;;       (lambda ()
;;         (font-lock-add-keywords nil
;;                  '(("\\(%>%\\)" 1
;;                     font-lock-builtin-face t)))))

;; (defun my-pretty-R-operators ()
;;   "make some word or string show as pretty Unicode symbols"
;;   (setq prettify-symbols-alist
;;         '(
;;           ("%>%" . "⇛")
;;           ("<-"  . "⇐")
;;           )))

;; (add-hook 'ess-mode-hook 'my-pretty-R-operators)
;; (add-hook 'R-mode-hook 'my-pretty-R-operators)
;; (global-prettify-symbols-mode 1) ; this sexp has been moved to mail file.

;; OR this (from https://www.miskatonic.org/2014/10/17/prettifying-r-in-emacs/)
(when (boundp 'global-prettify-symbols-mode)
  (add-hook 'ess-mode-hook
            (lambda ()
              (push '("%>%" . ?|) prettify-symbols-alist)
	      ))
  (add-hook 'inferior-ess-mode-hook
            (lambda ()
              (push '("%>%" . ?|) prettify-symbols-alist)
	      ))
  (global-prettify-symbols-mode +1))

;; no smart expansion of the underscore
;;(ess-toggle-underscore nil)
;;(define-key ess-mode-map "\M-M" " %>% ")

(provide 'init-ess)
