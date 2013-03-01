;;; nxml-hide-end-tags.el --- Make all characters but slash invisible in XML end tags with NXML mode.

;; Distributed under the terms of Unlicense (http://unlicense.org/UNLICENSE)

;; Author: Orivej Desh <orivej@gmx.fr>
;; Created: 2013-02-28
;; Keywords: faces
;; Homepage: https://github.com/orivej/nxml-hide-end-tags.el

;;; Commentary:

;; Put
;;
;;      (add-hook 'nxml-mode-hook 'nxml-hide-end-tags)
;;
;; in the Emacs init file and evaluate it to activate.

;;; Code:

(defface invisible-face nil "'Invisible' face")

(defun update-invisible-face ()
  (set-face-attribute 'invisible-face nil :foreground (face-attribute 'default :background)))

(update-invisible-face)

(defvar nxml-end-tags-slash-rule '([nil 1 invisible-face] [1 2 nxml-element-local-name] [2 nil invisible-face]))
(defvar nxml-end-tags-no-rule '([nil nil invisible-face]))
(defvar nxml-end-tags-default-rule '([nil 1 nxml-tag-delimiter] [1 2 nxml-tag-slash] [-1 nil nxml-tag-delimiter] (element-qname . 2)))
(defvar nxml-start-tags-name-rule '([nil 1 invisible-face] [-1 nil invisible-face] (element-qname . 1) attributes))
(defvar nxml-start-tags-default-rule '([nil 1 nxml-tag-delimiter] [-1 nil nxml-tag-delimiter] (element-qname . 1) attributes))

(defun nxml-hide-end-tags (&optional arg)
  "Without argument, show slash in end tags.  With argument, hide end tags altogether."
  (interactive "p")
  (update-invisible-face)
  (put 'end-tag 'nxml-fontify-rule
       (if (zerop arg) nxml-end-tags-slash-rule nxml-end-tags-no-rule))
  (font-lock-fontify-buffer))

(defun nxml-show-end-tags ()
  (interactive)
  (put 'end-tag 'nxml-fontify-rule nxml-end-tags-default-rule)
  (font-lock-fontify-buffer))

(defun nxml-hide-start-tags ()
  (interactive)
  (update-invisible-face)
  (put 'start-tag 'nxml-fontify-rule nxml-start-tags-name-rule)
  (font-lock-fontify-buffer))

(defun nxml-show-start-tags ()
  (interactive)
  (put 'start-tag 'nxml-fontify-rule nxml-start-tags-default-rule)
  (font-lock-fontify-buffer))

(provide 'nxml-hide-end-tags)
