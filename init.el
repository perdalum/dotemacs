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

(require-package 'linum-relative)
(setq linum-relative-current-symbol "")

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(column-number-mode t)
 '(csv-separators (quote (";" "	")))
 '(display-time-mode t)
 '(fci-rule-color "#073642")
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(indicate-buffer-boundaries (quote left))
 '(ledger-post-use-completion-engine :ido)
 '(ledger-use-iso-dates t)
 '(linum-relative-global-mode t)
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("~/Dropbox/Noter/emacs.org" "~/Dropbox/Noter/kulturarvscluster.org" "~/Dropbox/Noter/privat.org" "~/Dropbox/Noter/refile-beorg.org" "~/Dropbox/Noter/probing_noter.org" "~/Dropbox/Noter/arbejde.org" "~/Dropbox/Noter/indbakke.org")))
 '(package-selected-packages
   (quote
    (yasnippet yassnippet solarized-theme bm ess-view ess-smart-equals ess-R-data-view latex-pretty-symbols multiple-cursors dired-narrow markdown-mode polymode ess latex-extra auctex olivetti neotree neontree calmer-forest-theme dark-forest-theme powerline challenger-deep-theme challenger-deep linum-relative helm)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "nil" :slant normal :weight normal :height 120 :width normal)))))
(put 'downcase-region 'disabled nil)
