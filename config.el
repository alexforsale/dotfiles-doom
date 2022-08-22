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
(setq doom-font (font-spec :family "Fira Code Retina" :size 10)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 11))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-henna)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(when (file-directory-p
       (expand-file-name "Documents/google-drive/org" (getenv "HOME")))
  (setq org-directory (expand-file-name "Documents/google-drive/org" (getenv "HOME"))))

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
