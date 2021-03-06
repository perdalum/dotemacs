;; Leave this here, or package.el will just add it again.
(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Also add all directories within "lisp"
;; I use this for packages I'm actively working on, mostly.
;; (let ((files (directory-files-and-attributes "~/.emacs.d/lisp" t)))
;;   (dolist (file files)
;;     (let ((filename (car file))
;;           (dir (nth 1 file)))
;;       (when (and dir
;;                  (not (string-suffix-p "." filename)))
;;         (add-to-list 'load-path (car file))))))


(add-to-list 'exec-path "/usr/local/bin")

;; Don't litter my init file
(setq pmd-file (expand-file-name "pmd.el" user-emacs-directory))
(load pmd-file)

;;(require 'init-utils)
(require 'init-elpa)

(require-package 'cl-lib)
(require 'cl-lib)

;; Essential settings
(windmove-default-keybindings 'alt)
(setq windmove-wrap-around t)

;; more modern backup
(setq make-backup-files nil) ; stop creating ~ files

;; Danish calendar
(setq calendar-week-start-day 1
      calendar-day-name-array
      ["søndag" "mandag" "tirsdag" "onsdag"
       "torsdag" "fredag" "lørdag"]
      calendar-month-name-array
      ["januar" "februar" "marts" "april" "maj"
       "juni" "juli" "august" "september"
       "oktober" "november" "december"])

(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
                    :height 0.7)

(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'calendar-iso-week-face))
;; Eller bare brug en anden farve til ugenummer i stedet for en mindre font
;; der laver rod i formateringen
;; (set-face-attribute 'calendar-iso-week-face nil
;;                       :height 1.0 :foreground "salmon")

(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
;; make fringe color like background
(set-face-attribute 'fringe nil :background nil)

;; Why did I do this? Perhaps to keep vc from meddling with things
;; that Magit does, but it's convenient to be able to lean on vc for
;; certain things, so let's try it again with this turned on.
;; (eval-after-load "vc" '(setq vc-handled-backends nil))

(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(column-number-mode t)
(setq tab-width 4)
;; from: http://pragmaticemacs.com/emacs/dont-kill-buffer-kill-this-buffer-instead/
(defun bjm/kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (save-buffer)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'bjm/kill-this-buffer)

;; Allow confusing functions
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; PMD better visual bell
(setq visible-bell nil)
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))

;; Load essential packages
(require-package 'helm)
(require 'helm)
(require 'init-helm)
(global-set-key (kbd "C-c h") 'helm-mini)

;;(require-package 'linum-relative)
;;(setq linum-relative-current-symbol "")

;; dired
(setq dired-listing-switches "-alH")

;; Themes
(require-package 'challenger-deep-theme)
(require-package 'calmer-forest-theme)
(require-package 'solarized-theme)

;; Jeg kan ikke helt finde ud af hvordan powerline virker...
;(require-package 'powerline "20170708.1442")
;; (require 'powerline)
(require-package 'neotree) ; TODO: keyboard shortcut (eller vente på
                                        ; installation af evil med leader-key
(require-package 'olivetti)
(require-package 'fountain-mode)
(require-package 'all-the-icons)
(require-package 'all-the-icons-dired)
(global-prettify-symbols-mode 1)

;; Remember mode - persistente noter
(setq remember-data-file (substitute-in-file-name "$HOME/Dropbox/Noter/remember"))
(setq remember-notes-buffer-name "PERSISTENTE NOTER")
(setq remember-notes-initial-major-mode 'org-mode)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(require-package 'sunrise-commander)
(require-package 'sunrise-x-buttons)
(require-package 'sunrise-x-tree)
(require-package 'magit)
(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
;;(require-package 'evil)
;;(require 'evil)
;;(require-package 'evil-leader)
;;(global-evil-leader-mode)
;;(evil-leader/set-leader ",")
;;(evil-mode 1)
;;(require 'init-evil)
(require-package 'dired-narrow)
(define-key dired-mode-map "/" 'dired-narrow)
(define-key dired-mode-map "j" 'dired-next-line)
(define-key dired-mode-map "k" 'dired-previous-line)

(require-package 'multiple-cursors)
;;(require-package 'evil-mc)
(require-package 'expand-region)
(require 'init-eshell)

;; Install newest from Org ELPA
(require-package 'org) ; Hm, it looks like this doen't work automatically
(require 'init-org)

(require-package 'bm)
(require-package 'yasnippet)
(yas-global-mode 1)

;; Andre muligheder
;; - window navigtation
;; - lær multiple-cursors fra http://emacsrocks.com/e13.html
;; fuzzy match for helm

;; Application packages
(require-package 'auctex)
(require 'init-auctex)
(require-package 'latex-extra)
(require-package 'latex-pretty-symbols)

(require-package 'markdown-mode)

(require-package 'ess)
(require 'init-ess)
(require-package 'ess-R-data-view)
(require-package 'ess-smart-equals)
(require-package 'ess-view)

(require-package 'polymode)
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))


(set-face-attribute 'fringe nil :background nil)
(global-set-key (kbd "A-<tab>") 'other-frame)


(add-to-list 'load-path "/usr/local/Cellar/ledger/3.1.1_7/share/emacs/site-lisp/ledger")
(require 'ledger-mode)

(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file)
