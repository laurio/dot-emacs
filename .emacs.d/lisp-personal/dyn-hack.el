;; Dynasty mode
(defun goto-method-line ()
  (interactive)
  (re-search-backward "Object( Method, \\(.*\\) )"))

(global-set-key [(C d)] 'goto-method-line)


(defun find-dyn-method-name ()
 "Kuvab meetodi nime, millises parasjagu on kursor."
 (interactive)
 (save-excursion
   (re-search-backward "Object( Method, \\(.*\\) )")
   (message "%s" (concat "MTH:" (match-string 1)))))

(global-set-key [(M d)] 'find-dyn-method-name)




(provide 'dyn-hack)
