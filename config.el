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
  (setq doom-font (font-spec :family "Ubuntu Mono" :size 10)))
 ((find-font (font-spec :family "Fira Code Retina"))
  (setq doom-font (font-spec :family "Fira Code Retina" :size 10)))
 ((find-font (font-spec :family "Source Code Pro"))
  (setq doom-font (font-spec :family "Source Code Pro" :size 10)))
 ((find-font (font-spec :family "DejaVu Sans Mono"))
  (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 10)))
 ;; `doom-variable-pitch-font'
 ((find-font (font-spec :family "Fira Sans"))
  (setq doom-variable-pitch-font (font-spec :family "Fira Sans" :size 11)))
 ((find-font (font-spec :family "Fira Sans"))
  (setq doom-variable-pitch-font (font-spec :family "Fira Sans" :size 11)))
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
   (expand-file-name "Sync/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Sync/org" (getenv "HOME"))))
 ((file-directory-p
   (expand-file-name "Documents/google-drive/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Documents/google-drive/org" (getenv "HOME"))))
 ((file-directory-p
   (expand-file-name "Dropbox/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Dropbox/org" (getenv "HOME")))))
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
  (setq notmuch-fcc-dirs nil
        notmuch-search-result-format
        '(("date" . "%12s ")
          ("count" . "%-7s ")
          ("authors" . "%-30s ")
          ("subject" . "%-72s ")
          ("tags" . "(%s)"))
        notmuch-tag-formats
        '(("unread" (propertize tag 'face 'notmuch-tag-unread)))
        notmuch-tagging-keys
        '(("a" notmuch-archive-tags "Archive")
          ("u" notmuch-show-mark-read-tags "Mark read")
          ("f" ("+flagged") "Flag")
          ("s" ("+spam" "-inbox") "Mark as spam")
          ("d" ("+deleted" "-inbox") "Delete"))
        notmuch-saved-searches
        '((:name "inbox" :query "tag:inbox not tag:trash" :key "i")
          (:name "flagged" :query "tag:flagged" :key "f")
          (:name "sent" :query "tag:sent" :key "s")
          (:name "drafts"  :query "tag:draft" :key "d")
          (:name "all mail" :query "*" :key "a")
          (:name "unread" :query "tag:unread" :key "u")
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
          (:name "spam" :query "tag:spam"))
        notmuch-archive-tags '("-inbox" "-unread")))

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
  (customize-set-variable 'org-agenda-files
                          `(,(expand-file-name "habits.org" org-directory)
                            ,(expand-file-name "exercism.org" org-directory)
                            ,(expand-file-name "links.org" org-directory)
                            ,(expand-file-name "mkn.org" org-directory)
                            ,(expand-file-name "notes.org" org-directory)
                            ,(expand-file-name "projects.org" org-directory)
                            ,(expand-file-name "todo.org" org-directory)
                            ;; directories
                            ,(expand-file-name "journal/" org-directory)
                            ,(expand-file-name "misc/" org-directory)
                            ,(expand-file-name "personal/" org-directory)
                            ,(expand-file-name "roam/" org-directory)
                            ,(expand-file-name "tasks/" org-directory)
                            ,(expand-file-name "work/" org-directory)))
  (setq org-log-done 'time ;; Information to record when a task moves to the DONE state.
        org-startup-folded t ;; Non-nil means entering Org mode will switch to OVERVIEW.
        org-capture-templates ;; this is the default from `doom'.
        `(("t" "Personal todo" entry
           (file+headline ,(expand-file-name "personal/todos.org" org-directory) "Inbox")
           "* [ ] %?\n%i\n%a" :prepend t)
          ("n" "Personal notes" entry
           (file+headline ,(expand-file-name "personal/notes.org" org-directory) "Inbox")
           "* %u %?\n%i\n%a" :prepend t)
          ("w" "work")
          ("wt" "work todo" entry
           (file+headline ,(expand-file-name "work/todos.org" org-directory) "Inbox")
           "* %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)
          ("wn" "work notes" entry
           (file+headline ,(expand-file-name "work/notes.org" org-directory) "Inbox")
           "* %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)
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
          ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)
          ("ol" "Links" entry (file ,(expand-file-name "links.org" org-directory))))
        org-agenda-custom-commands ;; Custom commands for the agenda.
        `(("w" "Work Agenda and all TODOs"
           ((agenda ""
                    ((org-agenda-span 7)
                     ;; (org-deadline-warning-days 0)
                     (org-agenda-block-separator nil)
                     (org-scheduled-past-days 0)
                     ;; (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                     ;; (org-agenda-format-date "%A %-e %B %Y")
                     (org-agenda-start-on-weekday 1)
                     (org-agenda-start-day "+1d")
                     ;; (org-agenda-start-with-log-mode '(closed))
                     ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE" "HOLD" "CANCELLED" "KILL")))
                     ;; (org-agenda-skip-function '(org-agenda-skip-entry-if '(notdeadline notscheduled)))
                     (org-agenda-overriding-header "This Week")))
            (tags "STYLE=\"habit\""
                  ((org-agenda-overriding-header "Routine")))
            (tags-todo "+work-personal"
                       ((org-agenda-overriding-header "Work Stuffs")
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE" "HOLD" "CANCELLED" "KILL")))))
            (tags-todo "-personal+{project*}-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                       ((org-agenda-overriding-header "Projects")))
            (tags-todo "+followup-personal-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                       ((org-agenda-overriding-header "Needs Followup")))
            (tags-todo "+learning-personal-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                       ((org-agenda-overriding-header "Learning stuffs")))
            (tags-todo "-personal-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                       ((org-agenda-overriding-header "Inbox")))))))
  (add-to-list 'org-agenda-custom-commands
               `("p" "Personal Agenda and TODOs"
                 ((agenda ""
                          ((org-agenda-span 7)
                           (org-agenda-block-separator nil)
                           (org-scheduled-past-days 0)
                           (org-agenda-start-on-weekday 1)
                           (org-agenda-start-day "+1d")
                           (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE" "HOLD" "CANCELLED" "KILL")))
                           (org-agenda-overriding-header "This Week")))
                  (tags "-work+STYLE=\"habit\""
                        ((org-agenda-overriding-header "Routine")))
                  (tags-todo "+personal"
                             ((org-agenda-overriding-header "Personal Stuffs")
                              (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE" "HOLD" "CANCELLED" "KILL")))))
                  (tags-todo "+personal+{project*}-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                             ((org-agenda-overriding-header "Projects")))
                  (tags-todo "+followup+personal-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                             ((org-agenda-overriding-header "Needs Followup")))
                  (tags-todo "+learning+personal-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                             ((org-agenda-overriding-header "Personal Learning stuffs")))
                  (tags-todo "+personal-TODO=\"DONE\"-TODO=\"HOLD\"-TODO=\"CANCELLED\"-TODO=\"KILL\""
                             ((org-agenda-overriding-header "Personal Inbox"))))))
  ;; from https://stackoverflow.com/questions/22394394/orgmode-a-report-of-tasks-that-are-done-within-the-week
  (add-to-list 'org-agenda-custom-commands
               '("R" . "Review" )
               )
  (setq efs/org-agenda-review-settings
        '((org-agenda-show-all-dates t)
          (org-agenda-start-with-log-mode '(closed))
          ;; (org-agenda-start-with-clockreport-mode t)
          (org-agenda-archives-mode t)
          ;; I don't care if an entry was archived
          (org-agenda-hide-tags-regexp
           (concat org-agenda-hide-tags-regexp
                   "\\|ARCHIVE\\|archive"))
          ))
  (add-to-list 'org-agenda-custom-commands
               `("Rw" "Week in review"
                 agenda ""
                 ;; agenda settings
                 ,(append
                   efs/org-agenda-review-settings
                   '((org-agenda-span 'week)
                     (org-agenda-start-on-weekday 0)
                     ;;(org-agenda-start-with-log-mode '(closed))
                     (org-agenda-overriding-header "Week in Review"))
                   )
                 (,(expand-file-name "review/week.html" org-directory))
                 ))
  (add-to-list 'org-agenda-custom-commands
               `("Ry" "Year in review"
                 agenda ""
                 ;; agenda settings
                 ,(append
                   efs/org-agenda-review-settings
                   '((org-agenda-span 'year)
                     (org-agenda-start-day "01-01")
                     (org-read-date-prefer-future nil)
                     ;;(org-agenda-start-with-log-mode '(closed))
                     (org-agenda-overriding-header "Year in Review"))
                   )
                 (,(expand-file-name "review/year.html" org-directory))
                 ))
  (add-to-list 'org-agenda-custom-commands
               `("Rm" "Month in review"
                 agenda ""
                 ;; agenda settings
                 ,(append
                   efs/org-agenda-review-settings
                   '((org-agenda-span 'month)
                     (org-agenda-start-day "01")
                     (org-read-date-prefer-future nil)
                     ;; (org-agenda-start-with-log-mode '(closed))
                     (org-agenda-overriding-header "Month in Review"))
                   )
                 (,(expand-file-name "review/month.html" org-directory))
                 )))

(use-package! lsp-haskell
  :hook (haskell-mode . lsp)
  :hook (haskell-literate-mode . lsp))

(use-package! web-beautify)
(use-package! org-present
  :hook (org-present-mode .
                          (lambda ()
                            (org-present-big)
                            (org-display-inline-images)
                            (org-present-hide-cursor)
                            (setq org-present-hide-stars-in-headings nil)
                            (org-present-read-only)))
  :hook (org-present-quit .
                          (lambda ()
                            (org-present-small)
                            (org-remove-inline-images)
                            (org-present-show-cursor)
                            (org-present-read-write)
                            (blink-cursor-mode 1))))
(map!
 :localleader
 (:after js2-mode
  :map js2-mode-map
  "B" #'web-beautify-js)
 (:map org-mode-map
       (:prefix-map ("C-p" . "org-present")
        :desc "org-present mode" "p" #'org-present
        :desc "Quit presentation" "q" #'org-present-quit
        :desc "Make font size larger" "b" #'org-present-big
        :desc "Make font size smaller" "s" #'org-present-small
        :desc "toggle one big page" "t" #'org-present-toggle-one-big-page
        :desc "read only" "r" #'org-present-read-only
        :desc "write mode" "w" #'org-present-read-write
        :desc "hide cursor" "H" #'org-present-hide-cursor
        :desc "show cursor" "h" #'org-present-show-cursor)
       (:when org-present-mode
         :desc "next slide" "M-n" #'org-present-next
         :desc "next slide" "C-n" #'org-present-next
         :desc "previous slide" "M-p" #'org-present-next
         :desc "previous slide" "C-p" #'org-present-next
         )
       )
 )

;; reveal
(after! org
  (load-library "ox-reveal")
  (require 'ox-reveal)
  (setq org-reveal-root (concat "file:///home/" user-login-name "/project/personal/reveal.js"))
  (setq org-use-property-inheritance t
        org-use-tag-inheritance t))

;; misc
(setq browse-url-chrome-program "firefox")

(use-package! spell-fu
  :hook (org-mode . (lambda ()
                      (setq spell-fu-faces-exclude
                            '(org-block-begin-line
                              org-block-end-line
                              org-code
                              org-date
                              org-drawer
                              org-document-info-keyword
                              org-ellipsis
                              org-link
                              org-meta-line
                              org-properties
                              org-properties-value
                              org-special-keyword
                              org-src
                              org-tag
                              org-verbatim))
                      (spell-fu-mode)))
  :hook (emacs-lisp-mode . (lambda ()
                             (spell-fu-mode)))
  :hook (spell-fu-mode . (lambda ()
                           (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))
                           (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "id")))))

(use-package! mastodon
  :config
  (mastodon-discover)
  (setq mastodon-instance-url "https://social.alexforsale.site"
        mastodon-active-user "alexforsale")
  (map!
   :map mastodon-mode-map
   :n "q" #'quit-window
   ;;:localleader
   :n "@" #'mastodon-notifications--get-mentions
   :n "A" #'mastodon-profile--get-toot-author
   :n "B" #'mastodon-tl--block-user
   :n "C" #'mastodon-toot--copy-toot-url
   :n "D" #'mastodon-toot--delete-and-redraft-toot
   :n "E" #'mastodon-toot--view-toot-edits
   :n "F" #'mastodon-tl--get-federated-timeline
   :n "G" #'mastodon-tl--get-follow-suggestions
   :n "H" #'mastodon-tl--get-home-timeline
   :n "I" #'mastodon-tl--view-filters
   :n "K" #'mastodon-profile--view-bookmarks
   :n "L" #'mastodon-tl--get-local-timeline
   :n "M" #'mastodon-tl--mute-user
   :n "M-n" #'mastodon-tl--next-tab-item
   :n "M-p" #'mastodon-tl--previous-tab-item
   :n "N" #'mastodon-notifications-get
   :n "O" #'mastodon-profile--my-profile
   :n "P" #'mastodon-profile--show-user
   :n "Q" #'kill-buffer-and-window
   :n "R" #'mastodon-profile--view-follow-requests
   :n "S" #'mastodon-search--search-query
   :n "S-RET" #'mastodon-tl--unmute-user
   :n "T" #'mastodon-tl--thread
   :n "U" #'mastodon-profile--update-user-profile-note
   :n "V" #'mastodon-profile--view-favourites
   :n "W" #'mastodon-tl--follow-user
   :n "X" #'mastodon-tl--view-lists
   :n "b" #'mastodon-toot--toggle-boost
   :n "c" #'mastodon-tl--toggle-spoiler-text-in-toot
   :n "d" #'mastodon-toot--delete-toot
   :n "e" #'mastodon-toot--edit-toot-at-point
   :n "f" #'mastodon-toot--toggle-favourite
   :n "g" #'mastodon-tl--update
   :n "i" #'mastodon-toot--pin-toot-toggle
   ;;:n "k" #'mastodon-toot--bookmark-toot-toggle
   :n "n" #'mastodon-tl--goto-next-toot
   :n "k" #'mastodon-tl--goto-prev-toot
   :n "j" #'mastodon-tl--goto-next-toot
   :n "p" #'mastodon-tl--goto-prev-toot
   :n "r" #'mastodon-toot--reply
   :n "t" #'mastodon-toot
   :n "u" #'mastodon-tl--update
   :n "v" #'mastodon-tl--poll-vote
   :leader
   "M" #'mastodon
   ))

;; org-gcal
;; (use-package! org-gcal
;;   :init
;;   (setq org-gcal-client-id (password-store-get "console.cloud.google.com/gcal/id")
;;         org-gcal-client-secret (password-store-get "console.cloud.google.com/gcal/secret")
;;         org-gcal-fetch-file-alist '(("alexarians@gmail.com" .  (expand-file-name (concat org-directory "/" "personal-calendar.org"))))))
