;;; json-mode.el --- major mode for editing JSON files
;;; - extends javascript mode to add better syntax highlighting

;;;;
;; syntax highlighting

(defvar json-mode-hook nil)

(defconst json-quoted-key-re "\\(\"[^\"]+?\"[ ]*:\\)")
(defconst json-quoted-string-re "\\(\".*?\"\\)") 
(defconst json-int-re "\\([^\"][0-9]+[^\"]\\)")
(defconst json-keyword-re "\\(true\\|false\\|null\\)")

(defconst json-font-lock-keywords-1
  (list 
   (list json-quoted-key-re 1 font-lock-keyword-face)
   (list json-quoted-string-re 1 font-lock-string-face)
   (list json-keyword-re 1 font-lock-constant-face)
   (list json-int-re 1 font-lock-constant-face)
   )
  "Level one font lock.")

(define-derived-mode json-mode javascript-mode "JSON"
  "Major mode for editing JSON files"
  (set (make-local-variable 'font-lock-defaults) '(json-font-lock-keywords-1 t)))

(provide 'json-mode)