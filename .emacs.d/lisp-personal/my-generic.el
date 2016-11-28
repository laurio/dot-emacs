;;; Generic emacs settings I cannot live without

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)

;; Emacs gurus don't need no stinking scroll bars
(toggle-scroll-bar -1)

;; Line-wrapping
(set-default 'fill-column 80)

;;Enable copy-paste between other apps
;;http://iwiwdsmi.blogspot.com/2007/11/ubuntu-gutsy-emacs-copy-paste.html
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;Set modeline color to blue for active buffer
;;http://iwiwdsmi.blogspot.com/2007/10/emacs-mode-line-color-custimization.html
(set-face-background 'modeline "#4477aa")

;;enable ido-mode
(require 'ido)
(ido-mode t)

;;enable cua-mode
(require 'cua-base)
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; http://www.emacsblog.org/2007/02/27/quick-tip-add-occur-to-isearch/
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
	       (regexp-quote isearch-string))))))

;;http://steve.yegge.googlepages.com/effective-emacs
(defalias 'qrr 'query-replace-regexp)
(defalias 'rb 'revert-buffer)
(defalias 'rs 'replace-string)

;; from http://exceedhl.wordpress.com/2006/07/13/tweak-emacs/
(defun tweakemacs-duplicate-one-line ()
  "Duplicate the current line. There is a little bug: when current line is the last line of the buffer, this will not work as expected. Anyway, that's ok for me."
  (interactive)
  (let ((start (progn (beginning-of-line) (point)))
	(end (progn (next-line 1) (beginning-of-line) (point))))
    (insert-buffer-substring (current-buffer) start end)
    (forward-line -1)))
(global-set-key (kbd "C-=") 'tweakemacs-duplicate-one-line)

;; http://juangarcia.890m.com/blog/2008/06/04/emacs-keymaps-prefix-keys/
(defvar my-insert-map nil)
(setq my-insert-map (make-sparse-keymap))

(global-set-key "\C-ci" my-insert-map)
(global-set-key "\C-cid" 'my-insert-date)
(global-set-key (kbd "C-x g") 'magit-status)

(defun my-insert-date ()
  (interactive)
  (insert (format-time-string "%Y%m%d")))

(provide 'my-generic)
