;;; nxmless-hide-end-tags.el --- Make all characters but slash invisible in XML end tags with NXML mode.

;; Distributed under the terms of Unlicense (http://unlicense.org/UNLICENSE)

;; Author: Orivej Desh <orivej@gmx.fr>
;; Created: 2013-02-28
;; Keywords: faces
;; Homepage: https://github.com/orivej/nxmlless

;;; Commentary:

;; Put
;;
;;      (add-hook 'nxml-mode-hook 'nxmless-hide-tags)
;;
;; in the Emacs init file and evaluate it to activate.

;;; Code:

(defface invisible-face nil "'Invisible' face")

(defun update-invisible-face ()
  (set-face-attribute 'invisible-face nil :foreground (face-attribute 'default :background)))

(update-invisible-face)

(defvar nxmless-end-tags-slash-rule '([nil 1 invisible-face] [1 2 nxml-element-local-name] [2 nil invisible-face]))
(defvar nxmless-end-tags-clean-rule '([nil nil invisible-face]))
(defvar nxmless-end-tags-default-rule '([nil 1 nxml-tag-delimiter] [1 2 nxml-tag-slash] [-1 nil nxml-tag-delimiter] (element-qname . 2)))
(defvar nxmless-start-tags-clean-rule '([nil 1 invisible-face] [-1 nil invisible-face] (element-qname . 1) attributes))
(defvar nxmless-start-tags-default-rule '([nil 1 nxml-tag-delimiter] [-1 nil nxml-tag-delimiter] (element-qname . 1) attributes))
(defvar nxmless-empty-elements-clean-rule '([nil 1 invisible-face] [-2 nil invisible-face] (element-qname . 1) attributes))
(defvar nxmless-empty-elements-default-rule '([nil 1 nxml-tag-delimiter] [-2 -1 nxml-tag-slash] [-1 nil nxml-tag-delimiter] (element-qname . 1) attributes))

(defun nxmless-hide-tags ()
  (interactive)
  (update-invisible-face)
  (put 'start-tag 'nxml-fontify-rule nxmless-start-tags-clean-rule)
  (put 'end-tag 'nxml-fontify-rule nxmless-end-tags-clean-rule)
  (put 'empty-element 'nxml-fontify-rule nxmless-empty-elements-clean-rule)
  (font-lock-fontify-buffer))

(defun nxmless-show-tags ()
  (interactive)
  (put 'start-tag 'nxml-fontify-rule nxmless-start-tags-default-rule)
  (put 'end-tag 'nxml-fontify-rule nxmless-end-tags-default-rule)
  (put 'empty-element 'nxml-fontify-rule nxmless-empty-elements-default-rule)
  (font-lock-fontify-buffer))

(provide 'nxmless-hide-tags)
