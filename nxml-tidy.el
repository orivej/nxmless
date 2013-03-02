;;;; nxml-tidy.el --- Example code to automatically reindent XML file with NXML

;;; Commentary:

;; See docstrings for nxml-normal-tidy and nxml-sexp-tidy.  I bound them with:
;;
;;      (define-key nxml-mode-map (kbd "C-<tab>") 'nxml-sexp-tidy)
;;      (define-key nxml-mode-map (kbd "<backtab>") 'nxml-normal-tidy)

;;; Code:

;;; https://sinewalker.wordpress.com/2008/06/26/pretty-printing-xml-with-emacs-nxml-mode/
;;; This function is independent of the rest of this file
(defun nxml-normal-tidy ()
  "Pretty format XML markup in region. Insert linebreaks to
separate tags that have nothing but whitespace between them."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward ">[ \\t]*<" nil t)
      (backward-char) (insert "\n"))
    (indent-region (point-min) (point-max))))

;;; For the indent-region here to work, nxml-compute-indent must be updated as shown below
(defun nxml-sexp-tidy ()
  "Move end tags onto lines with their content (if present) or start tags (otherwise)."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward ">\\s-+</" nil t)
      (replace-match "></" nil nil))
    (indent-region (point-min) (point-max))))

;;; Redefine nxml-compute-indent to support Lisp style of end tag placement

(defun my-nxml-compute-indent-from-matching-start-tag ()
  "Compute the indent for a line with an end-tag using the matching start-tag.
When the line containing point ends with an end-tag and does not start with a start-tag or
in the middle of a token, return the indent of the line containing the
matching start-tag, if there is one and it occurs at the beginning of
its line.  Otherwise return nil."
  (save-excursion
    (back-to-indentation)
    (nxml-token-after)
    (unless (memq xmltok-type '(start-tag empty-element))
      (nxml-compute-indent-from-matching-start-tag))))

(defun my-nxml-compute-indent-from-previous-line ()
  "Compute the indent for a line using the last start tag closed
before current, or using indentation of a previous line otherwise."
  (save-excursion
    (back-to-indentation)
    (let ((previous-open (nxml-scan-element-backward
                          (point)
                          nil
                          (- (point) nxml-end-tag-indent-scan-distance))))
      (cond
       (previous-open
        (goto-char previous-open)
        (current-indentation))
       (t
        (nxml-compute-indent-from-previous-line))))))

(defun nxml-compute-indent ()
  "Return the indent for the line containing point."
  (or (my-nxml-compute-indent-from-matching-start-tag)
      (my-nxml-compute-indent-from-previous-line)))

(provide 'nxml-tidy)
