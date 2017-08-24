;; Pretty arrows and magrittr pipes in R
(defvar pretty-alist
  (cl-pairlis '() '()))
(add-to-list 'pretty-alist '("%>%" . "⇛"))
(add-to-list 'pretty-alist '("<-" . "⇐"))
(defun pretty-things ()
  (mapc
   (lambda (x)
     (let ((word (car x))
           (char (cdr x)))
       (font-lock-add-keywords
        nil
        `((,(concat "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[a-zA-Z]")
            (0 (progn
                 (decompose-region (match-beginning 2) (match-end 2))
                 nil)))))
       (font-lock-add-keywords
        nil
        `((,(concat "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[^a-zA-Z]")
            (0 (progn
                 (compose-region (match-beginning 2) (match-end 2)
                  ,char)
                 nil)))))))
   pretty-alist))

(add-hook 'R-mode-hook
      (lambda ()
        (font-lock-add-keywords nil
                 '(("\\(%>%\\)" 1
                    font-lock-builtin-face t)))))

(define-key ess-mode-map "M-M" "%>%")

(provide 'init-ess)