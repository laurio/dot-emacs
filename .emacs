;;;; My emacs initialization

;; Enable a backtrace when problems occur
;; (setq debug-on-error t)

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

;; Personal customizations
(require 'my-generic)

(when (eq system-type 'gnu/linux)
  (require 'm-linux-settings))

(require 'm-slime-settings)
(require 'dyn-hack)
;(require 'my-carbon-emacs)
;(require 'my-colors)
;; Many more to come
;;http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/



(add-to-list 'load-path "~/downloads/emacspeak-26.0/lisp/g-client")
(add-to-list 'load-path "~/elisp")
(require 'http-twiddle)
(load-library "g")


;;distel (http://bc.tech.coop/blog/070528.html)
;(add-to-list 'load-path "/home/lauri/distel/elisp")
;(require 'distel)
;(distel-setup)

;; This is needed for Erlang mode setup
;(setq erlang-root-dir "/usr/local/lib/erlang")
;(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.5.1/emacs" load-path))
;(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
;(require 'erlang-start)

;; This is needed for Distel setup
(let ((distel-dir "~/.emacs.d/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))

(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
	    ;; add Erlang functions to an imenu menu
	    (imenu-add-to-menubar "imenu")))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("C-M-i"   erl-complete)
    ("M-?"      erl-complete)
    ("M-."      erl-find-source-under-point)
    ("M-,"      erl-find-source-unwind)
    ("M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;; add some Distel bindings to the Erlang shell
	    (dolist (spec distel-shell-keys)
	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;;http://www.emacswiki.org/cgi-bin/wiki/Git
(add-to-list 'load-path "/home/lauri/git-emacs")
(setq load-path (cons (expand-file-name "/usr/share/doc/git-core/contrib/emacs") load-path))
(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require 'git)
(require 'git-blame)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(git-author-email "lauri.oherd@gmail.com")
 '(git-committer-email "lauri.oherd@gmail.com")
 '(mail-host-address "gmail.com")
 '(org-agenda-custom-commands (quote (("d" todo "DELEGATED" nil) ("c" todo "DONE|DEFERRED|CANCELLED" nil) ("w" todo "WAITING" nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" alltodo "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "<[^>
]+>"))) (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/notes.org")
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates (quote ((116 "* TODO %?
  %u" "~/todo.org" "Tasks") (110 "* %u %?" "~/notes.org" "Notes"))))
 '(org-reverse-note-order t)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(safe-local-variable-values (quote ((Syntax . COMMON-LISP) (Package . CL-PPCRE) (Base . 10) (unibyte . t)))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;;http://sami.samhuri.net/2007/8/10/cheat-from-emacs
(require 'cheat)


;;org-mode
;;http://www.newartisans.com/blog_files/org.mode.day.planner.php
(add-to-list 'load-path "~/.emacs.d/org-5.13i")

(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key mode-specific-map [?a] 'org-agenda)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)

     (define-key org-mode-map "\C-cx" 'org-todo-state-map)

     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))

     (define-key org-agenda-mode-map "\C-n" 'next-line)
     (define-key org-agenda-keymap "\C-n" 'next-line)
     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     (define-key org-agenda-keymap "\C-p" 'previous-line)))

(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control meta ?r)] 'remember)



;turn on transient mark mode
;http://www.emacswiki.org/cgi-bin/wiki/EmacsNiftyTricks#toc4
(transient-mark-mode 1)

;http://www.emacswiki.org/cgi-bin/wiki/EmacsNiftyTricks#toc5
(set-register ?e '(file . "~/.emacs"))

;http://emacslife.blogspot.com/2007/12/setting-registers-in-emacs-file.html
(set-register ?a '("<a href=\"\"></a>"))

;http://www.emacswiki.org/cgi-bin/wiki/SkeletonMode
(define-skeleton tehom-let-skel
  "Insert a let in all its glory."
  nil
  \n >
  "(let"
  \n >
  "()"
  \n >
  _
  \n >
  ")"
  )

;http://www.emacswiki.org/cgi-bin/wiki/AutoCompressionMode
(auto-compression-mode 1)
