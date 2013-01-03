;;; json-mode.el --- Major mode for editing JSON files
;;; Author: Josh Johnston
;;; URL: https://github.com/joshwnj/json-mode
;;; Version: 0.1.2

;;;;
;; extend javascript-mode's syntax highlighting

(defvar json-mode-hook nil)

(defconst json-quoted-key-re "\\(\"[^\"]+?\"[ ]*:\\)")
(defconst json-quoted-string-re "\\(\".*?\"\\)") 
(defconst json-number-re "[^\"]\\([0-9]+\\(\\.[0-9]+\\)?\\)[^\"]")
(defconst json-keyword-re "\\(true\\|false\\|null\\)")

(defconst json-font-lock-keywords-1
  (list 
   (list json-quoted-key-re 1 font-lock-keyword-face)
   (list json-quoted-string-re 1 font-lock-string-face)
   (list json-keyword-re 1 font-lock-constant-face)
   (list json-number-re 1 font-lock-constant-face)
   )
  "Level one font lock.")

(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    ;; Beautify json with support for non-ascii characters.
    ;; Thanks to https://github.com/jarl-dk for this improvement.
    (shell-command-on-region b e
     "python -c 'import sys,json; data=json.loads(sys.stdin.read()); print json.dumps(data,sort_keys=True,indent=4).decode(\"unicode_escape\").encode(\"utf8\",\"replace\")'" (current-buffer) t)))

;;;###autoload
(define-derived-mode json-mode javascript-mode "JSON"
  "Major mode for editing JSON files"
  (set (make-local-variable 'font-lock-defaults) '(json-font-lock-keywords-1 t)))

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(define-key json-mode-map (kbd "C-c C-f") 'beautify-json)

(provide 'json-mode)
;;; json-mode.el ends here
