;;slime
;;http://blog.alieniloquent.com/2007/12/29/make-slime-load-faster/
;;http://bc.tech.coop/blog/080116.html
(add-to-list 'load-path "~/clbuild/source/slime")
(require 'slime)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"
;;(setq inferior-lisp-program "/usr/local/bin/sbcl")

(let* ((core-file "/home/lauri/clbuild/monster.core"))
  (setq inferior-lisp-program (concat "/home/lauri/clbuild/target/bin/sbcl --core " core-file)))

;;(setq inferior-lisp-program "~/clbuild/target/bin/sbcl --core ")
(setq slime-backend "~/.emacs.d/slime/my-swank-loader.lisp")

;(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;
;(setq inferior-lisp-program "/usr/local/bin/sbcl"
;      lisp-indent-function 'common-lisp-indent-function
;      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;      slime-startup-animation t)

;;http://bc.tech.coop/blog/070515.html
(defun lispdoc ()
  "Searches lispdoc.com for SYMBOL, which is by default the symbol currently under the cursor"
  (interactive)
  (let* ((word-at-point (word-at-point))
         (symbol-at-point (symbol-at-point))
         (default (symbol-name symbol-at-point))
         (inp (read-from-minibuffer
               (if (or word-at-point symbol-at-point)
                   (concat "Symbol (default " default "): ")
		 "Symbol (no default): "))))
    (if (and (string= inp "") (not word-at-point) (not
						   symbol-at-point))
        (message "you didn't enter a symbol!")
      (let ((search-type (read-from-minibuffer
			  "full-text (f) or basic (b) search (default b)? ")))
	(browse-url (concat "http://lispdoc.com?q="
			    (if (string= inp "")
				default
			      inp)
			    "&search="
			    (if (string-equal search-type "f")
				"full+text+search"
			      "basic+search")))))))

(define-key lisp-mode-map (kbd "C-c l") 'lispdoc)

(provide 'm-slime-settings)
