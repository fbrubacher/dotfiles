;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(defvar BASEDIR (expand-file-name "~/.emacs.d/"))

(add-to-list 'load-path (concat BASEDIR "site-lisp"))
(add-to-list 'exec-path (concat BASEDIR "bin"))

; bs
(require 'bs)
(global-set-key (kbd "C-x C-b") 'bs-show)
(add-to-list 'bs-configurations
             '("channels" nil nil "^[^#]" nil nil))
(add-to-list 'bs-configurations
             '("targets" nil nil nil
               (lambda (buf)
                 (with-current-buffer buf
                   (not (erc-default-target)))) nil))


(defun load-setting (name)
  (load (concat BASEDIR "settings/" name)))

; Ido
(require 'ido)
(ido-mode t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10)

(defvar BASEDIR (expand-file-name "~/.emacs.d/"))

(add-to-list 'load-path (concat BASEDIR "site-lisp"))
(add-to-list 'exec-path (concat BASEDIR "bin"))

(defun load-setting (name)
  (load (concat BASEDIR "settings/" name)))

(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Load up ELPA, the package manager

(add-to-list 'load-path dotfiles-dir)

(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'package)
(package-initialize)
(require 'starter-kit-elpa)

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)

;; Load up starter kit customizations

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-js)
(global-set-key (kbd "C-.") 'repeat)
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(defun open-previous-line ()
  (interactive)
  (previous-line 1)
  (next-line 1)
  (move-beginning-of-line 1)
  (open-line 1)
  (forward-button 0)
)
(global-set-key (kbd "C-x c") 'duplicate-line)
(global-set-key (kbd "C-x y") 'open-previous-line)

(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

(setq rsense-home (expand-file-name "/Users/federicobrubacher/Documents/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)
(require 'color-theme-desert)
(color-theme-desert)
;(setq rsense-home (expand-file-name "/Users/federicobrubacher/Documents"))
;(add-to-list 'load-path (concat rsense-home "/magit-0.8.2"))
(add-to-list 'exec-path "/usr/local/bin")
(setq magit-git-executable "/usr/local/bin/git")
(require 'ruby-electric)
(require 'magit)

(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))

(global-set-key (kbd "C-=") 'rsense-complete)

(autoload 'paredit-mode "paredit"
    "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))


(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
    ;; which is annoying when backspacing over a '('
    (defun override-slime-repl-bindings-with-paredit ()
    (define-key slime-repl-mode-map
        (read-kbd-macro paredit-backward-delete-key) nil))
        (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (paredit-mode t)
            (turn-on-eldoc-mode)
            (eldoc-add-command
             'paredit-backward-delete
             'paredit-close-round)
            (local-set-key (kbd "RET") 'electrify-return-if-match)
            (eldoc-add-command 'electrify-return-if-match)
	      (show-paren-mode t)))

(regen-autoloads)
(load custom-file 'noerror)


;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(require 'highlight-current-line)
(highlight-current-line-on t)
(require 'undo-tree)
(global-undo-tree-mode)
(server-start)
;; To customize the background color
(set-face-background 'highlight-current-line-face "light red")
(defvar no-easy-keys-minor-mode-map (make-keymap) 
  "no-easy-keys-minor-mode keymap.")
(let ((f (lambda (m)
           `(lambda () (interactive) 
              (message (concat "No! use " ,m " instead."))))))
  (dolist (l '(("<left>" . "C-b") ("<right>" . "C-f") ("<up>" . "C-p")
               ("<down>" . "C-n")
               ("<C-left>" . "M-f") ("<C-right>" . "M-b") ("<C-up>" . "M-{")
               ("<C-down>" . "M-}")
               ("<M-left>" . "M-f") ("<M-right>" . "M-b") ("<M-up>" . "M-{")
               ("<M-down>" . "M-}")
               ("<delete>" . "C-d") ("<C-delete>" . "M-d")
               ("<M-delete>" . "M-d") ("<next>" . "C-v") ("<C-next>" . "M-x <")
               ("<prior>" . "M-v") ("<C-prior>" . "M-x >") 
               ("<home>" . "C-a") ("<C-home>" . "M->")
               ("<C-home>" . "M-<") ("<end>" . "C-e") ("<C-end>" . "M->")))
    (define-key no-easy-keys-minor-mode-map
      (read-kbd-macro (car l)) (funcall f (cdr l)))))
(define-minor-mode no-easy-keys-minor-mode
  "A minor mode that disables the arrow-keys, pg-up/down, delete
  and backspace."  t " no-easy-keys"
  'no-easy-keys-minor-mode-map :global t)
(no-easy-keys-minor-mode 0)
(progn
  (setq cdt-dir "/Users/federicobrubacher/clojure/cdt")
  (setq cdt-source-path "/Users/federicobrubacher/clojure/clojure-1.2.0/src/jvm:/Users/federicobrubacher/clojure/clojure-1.2.0/src/clj:/Users/federicobrubacher/clojure/clojure-contrib-1.2.0/src/main/clojure:")
  (load-file (format "%s/ide/emacs/cdt.el" cdt-dir)))
(global-linum-mode 1)
(defun print-class-path
  (println (seq (.getURLs (java.lang.ClassLoader/getSystemClassLoader)))))
(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(require 'whitespace)
(require 'grep-ed)
(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)
(defvar BASEDIR (expand-file-name "~/.emacs.d/"))

(add-to-list 'load-path (concat BASEDIR "site-lisp"))
(add-to-list 'exec-path (concat BASEDIR "bin"))

(defun load-setting (name)
  (load (concat BASEDIR "settings/" name)))
;; Javascript
;;(load-setting "javascript")
