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

(provide 'my-generic)
