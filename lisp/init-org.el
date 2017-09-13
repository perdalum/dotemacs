;; Activation

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;;(setq org-log-done 'time)
(setq org-log-into-drawer 't)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; don't show done tasks in the agenda
(setq org-agenda-skip-scheduled-if-done nil)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "AFVIST(a@)")))

(setq org-capture-templates
      '(("e" "Emacs" entry (file+headline "~/Dropbox/Noter/emacs.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; Direct access to the Emacs capture template
(define-key global-map "\C-ce"
        (lambda () (interactive) (org-capture nil "e")))

;; org modules
(setq org-modules (quote (org-bibtex
                          org-habit)))

;; Use helm for refile
;; good info at https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html
(setq org-refile-targets '((org-agenda-files :maxlevel . 5)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-completion-use-ido nil)


(require 'org-mouse)
(org-indent-mode 1)
(setq org-pretty-entities t)
(provide 'init-org)
