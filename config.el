;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kristian Alexander P"
      user-mail-address "alexforsale@yahoo.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(cond
 ;; `doom-font'
 ((find-font (font-spec :family "Ubuntu Mono"))
  (setq doom-font (font-spec :family "Ubuntu Mono" :size 8)))
 ((find-font (font-spec :family "Fira Code Retina"))
  (setq doom-font (font-spec :family "Fira Code Retina" :size 8)))
 ((find-font (font-spec :family "Source Code Pro"))
  (setq doom-font (font-spec :family "Source Code Pro" :size 8)))
 ((find-font (font-spec :family "DejaVu Sans Mono"))
  (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 8)))
 ;; `doom-variable-pitch-font'
 ((find-font (font-spec :family "Fira Sans"))
  (setq doom-variable-pitch-font (font-spec :family "Fira Sans" :size 9)))
 ((find-font (font-spec :family "Fira Sans"))
  (setq doom-variable-pitch-font (font-spec :family "Fira Sans" :size 9)))
 )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark-high-contrast)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(cond
 ((file-directory-p
   (expand-file-name "Documents/google-drive/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Documents/google-drive/org" (getenv "HOME"))))
 ((file-directory-p
   (expand-file-name "Dropbox/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Dropbox/org" (getenv "HOME"))))
 ((file-directory-p
   (expand-file-name "Sync/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Sync/org" (getenv "HOME"))))
 )
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! fish-mode
  :config
  (setq fish-enable-auto-indent t))

(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(after! docker-tramp-completion-function-alist
  :bind ("C-c d" . docker)
  :custom (docker-image-run-arguments '("-i" "-t" "--rm")))

(after! magit
  (setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")
        magit-diff-refine-hunk 'all))

(after! org-roam
  (setq org-roam-directory (expand-file-name "roam" org-directory)))

(use-package! notmuch
  :config
  (setq +notmuch-sync-backend 'offlineimap
        notmuch-saved-searches
        '((:name "inbox" :query "tag:inbox" :key "i")
          (:name "unread" :query "tag:unread" :key "u")
          (:name "flagged" :query "tag:flagged" :key "f") ;starred in gmail
          (:name "sent" :query "tag:sent" :key "t")
          (:name "drafts" :query "tag:draft" :key "d")
          (:name "all mail" :query "*" :key "a")
          (:name "Today"
           :query "date:today AND NOT tag:spam AND NOT tag:bulk"
           :key "T"
           :search-type 'tree
           :sort-order 'newest-first)
          (:name "This Week"
           :query "date:weeks AND NOT tag:spam AND NOT tag:bulk"
           :key "W"
           :search-type 'tree
           :sort-order 'newest-first)
          (:name "This Month"
           :query "date:months AND NOT tag:spam AND NOT tag:bulk"
           :key "M"
           :search-type 'tree
           :sort-order 'newest-first)
          (:name "flagged"
           :query "tag:flagged AND NOT tag:spam AND NOT tag:bulk"
           :key "f"
           :search-type 'tree
           :sort-order 'newest-first)
          (:name "spam" :query "tag:spam")
          (:name "gmail/inbox" :query "tag:gmail/inbox")
          (:name "gmail/sent" :query "tag:gmail/sent")
          (:name "gmail/draft" :query "tag:gmail/draft")
          (:name "gmail/archive" :query "tag:gmail/archive")
          (:name "gmail/spam" :query "tag:gmail/spam")
          (:name "yahoo/inbox" :query "tag:yahoo/inbox")
          (:name "yahoo/sent" :query "tag:yahoo/sent")
          (:name "yahoo/draft" :query "tag:yahoo/draft")
          (:name "yahoo/archive" :query "tag:yahoo/archive")
          (:name "yahoo/spam" :query "tag:yahoo/spam")
          (:name "hotmail/inbox" :query "tag:hotmail/inbox")
          (:name "hotmail/sent" :query "tag:hotmail/sent")
          (:name "hotmail/draft" :query "tag:hotmail/draft")
          (:name "hotmail/archive" :query "tag:hotmail/archive")
          (:name "hotmail/spam" :query "tag:hotmail/spam")
          (:name "ymail/inbox" :query "tag:ymail/inbox")
          (:name "ymail/sent" :query "tag:ymail/sent")
          (:name "ymail/draft" :query "tag:ymail/draft")
          (:name "ymail/archive" :query "tag:ymail/archive")
          (:name "ymail/spam" :query "tag:ymail/spam"))))

;; org-roam-ui
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package! org-clock
  :after org
  :config
  ;; save history accross `Emacs' sessions.
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))

(after! org
  (setq org-log-done 'time ;; Information to record when a task moves to the DONE state.
        org-startup-folded t ;; Non-nil means entering Org mode will switch to OVERVIEW.
        org-capture-templates ;; this is the default from `doom'.
        '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* [ ] %?\n%i\n%a" :prepend t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i\n%a" :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i\n%a" :prepend t)
          ("p" "Templates for projects")
          ("pt" "Project-local todo" entry
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)
          ("pn" "Project-local notes" entry
           (file+headline +org-capture-project-notes-file "Inbox")
           "* %U %?\n%i\n%a" :prepend t)
          ("pc" "Project-local changelog" entry
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a" :prepend t)
          ("o" "Centralized templates for projects")
          ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
          ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))
        org-agenda-custom-commands ;; Custom commands for the agenda.
        `(("A" "Daily Agenda and Top Priority Tasks"
           ((tags-todo "*"
                       ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                        (org-agenda-skip-function
                         `(org-agenda-skip-entry-if 'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                        (org-agenda-block-separator nil)
                        (org-agenda-overriding-header "Important Tasks Without a Date\n")))
            (agenda "" ((org-agenda-span 1)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator nil)
                        (org-scheduled-past-days 0)
                        (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                        (org-agenda-format-date "%A %-e %B %Y")
                        (org-agenda-overriding-header "\nToday's agenda\n")))
            (agenda "" ((org-agenda-start-on-weekday nil)
                        (org-agenda-start-day "+1d")
                        (org-agenda-span 3)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator nil)
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                        (org-agenda-overriding-header "\nNext three days\n")))
            (agenda "" ((org-agenda-time-grid nil)
                        (org-agenda-start-on-weekday nil)
                        (org-agenda-start-day "+4d")
                        (org-agenda-span 14)
                        (org-agenda-show-all-dates nil)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator nil)
                        (org-agenda-entry-types '(:deadline))
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                        (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")))))
          ("P" "Plain Text Daily Agenda and Top Priorities"
           ((tags-todo "*"
                       ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                        (org-agenda-skip-function `(org-agenda-skip-entry-if 'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                        (org-agenda-block-separator nil)
                        (org-agenda-overriding-header "Important Tasks Without a Date\n")))
            (agenda "" ((org-agenda-span 1)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-scheduled-past-days 0)
                      ;; We don't need the `org-agenda-date-today'
                      ;; highlight because that only has a practical
                      ;; utility in multi-day views.
                      (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header "\nToday's agenda\n")))
            (agenda "" ((org-agenda-start-on-weekday nil)
                      (org-agenda-start-day "+1d")
                      (org-agenda-span 3)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nNext three days\n")))
            (agenda "" ((org-agenda-time-grid nil)
                      (org-agenda-start-on-weekday nil)
                      ;; We don't want to replicate the previous section's
                      ;; three days, so we start counting from the day after.
                      (org-agenda-start-day "+4d")
                      (org-agenda-span 14)
                      (org-agenda-show-all-dates nil)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n"))))
           ((org-agenda-with-colors nil)
            (org-agenda-prefix-format "%t %s")
            (org-agenda-current-time-string ,(car (last org-agenda-time-grid)))
            (org-agenda-fontify-priorities nil)
            (org-agenda-remove-tags t))
           ("agenda.txt")))
        ))
