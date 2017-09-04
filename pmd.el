
;; Hm, strangely enough, I can't remember why I had to use the below code!?
;; syncronise Emacs kill-register (if that is its name) and the macOS clipboard
;; code copied from https://emacs.stackexchange.com/questions/10900/copy-text-from-emacs-to-os-x-clipboard
;; (defun copy-from-osx ()
;;   (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function nil)
;; (setq interprogram-paste-function nil)

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)



(defun go-focus ()
  "Enable focused writing"
  (interactive)
  (linum-relative-off)
  (linum-mode 0)
  (fringe-mode 0)
  (olivetti-mode 1))


(defun exit-focus ()
  "Go back to my normal state"
  (interactive)
  (olivetti-mode 0)
  (linum-mode 1)
  (linum-relative-on)
  (fringe-mode))

;; Change the color of the curly arrow marking continued line
;; Color names: http://raebear.net/comp/emacscolors.html
(defface my-custom-curly-face
  '((t (:foreground "misty rose")))
  "Face for fringe curly bitmaps."
  :group 'basic-faces)

(set-fringe-bitmap-face 'left-curly-arrow 'my-custom-curly-face)

(provide 'pmd)
