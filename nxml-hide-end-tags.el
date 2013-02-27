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

(defun nxml-hide-end-tags ()
  (interactive)
  (update-invisible-face)
  (put 'end-tag 'nxml-fontify-rule '([nil 1 invisible-face] [1 2 nxml-element-local-name] [2 nil invisible-face])))

(defun nxml-show-end-tags ()
  (interactive)
  (put 'end-tag 'nxml-fontify-rule '([nil 1 nxml-tag-delimiter] [1 2 nxml-tag-slash] [-1 nil nxml-tag-delimiter] (element-qname . 2))))

(provide 'nxml-hide-end-tags)
