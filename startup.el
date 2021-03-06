

;; Setup backup directories
(setq make-backup-files nil)

(require 'site-gentoo)

;; (setq default-frame-alist 
;;       '( 
;; 	;;(font .  "-Misc-Fixed-Medium-R-Normal--20-200-75-75-C-100-ISO8859-1")
;; ;;	(font . "-*-fixed-*-*-normal-*-18-*-*-*-*-*-iso8859-*")
;; ;;     	(width . 80)
;; ;;	(height . 50)
;; 	(background-color . "black")
;; 	(foreground-color . "green")
;; 	))
(require 'longlines )
(defun human-minor-modes ()
	"A function to enable a few nice minor modes."
	(interactive "")
	(transient-mark-mode 1)
	(font-lock-mode 1))

(defun text-mode-minor-modes ()
  "A few minor modes that I only want in text mode"
  (interactive "")
  (human-minor-modes )
  (flyspell-mode 1)
  ;;  (auto-fill-mode 1))
  (linum-mode)
  (longlines-mode 1)
  (longlines-show-hard-newlines )
)



;; Define some mode hooks that make things sane

(add-hook 'text-mode-hook 'text-mode-minor-modes)
(add-hook 'emacs-lisp-mode-hook 'human-minor-modes)
(add-hook 'c-mode-hook 'human-minor-modes)

(setq-default major-mode 'text-mode )
;(setq default-fill-column 78)


(defun set-fullscreen (full-or-not)
  "Use set-frame-parameter to make emacs fullscreen.  When passed a non-nil value, set-frame-parameter to fullboth (fullscreen)"
  (set-frame-parameter nil 'fullscreen 
                       (if full-or-not
                           'fullboth
                            nil)))


;; Full screen key bindings
(defun toggle-fullscreen ()
  (interactive)
  (let
      ((full-or-not    (if (frame-parameter nil 'fullscreen) nil 1)))
    
    (set-fullscreen full-or-not)
    (menu-bar-mode (if full-or-not 0 1))
    (tool-bar-mode (if full-or-not 0 1))
    full-or-not))
      
(global-set-key [(meta return)] 'toggle-fullscreen)


;; Let's do some boiler plate stuff
;; auto-insert-mode
(require 'autoinsert)
(setq auto-insert-directory "~/emacs/templates/")
(setq auto-insert-query nil)

(defun template-list (insert-directory)
(let (lst)
  (dolist (elt (directory-files insert-directory nil "[^\\.]" nil) lst)
  (setq lst (append lst `((,(concat "\\." elt "$") . ,elt)))))))

(setq auto-insert-alist (template-list auto-insert-directory))
(auto-insert-mode)


;; css-mode

;(byte-compile-if-newer-and-load "~/emacs/modes/css-mode")
;(autoload 'css-mode "css-mode")


(byte-compile-if-newer-and-load "~/emacs/modes/tads3-mode")
;(autoload 'tads3-mode "tads3-mode" "TADS 3 editing mode." t)

;(byte-compile-if-newer-and-load "~/emacs/modes/tads2-mode")
;(autoload 'tads2-mode "~/emacs/modes/tads2-mode.el" "TADS 2 editing mode." t)

;  (setq auto-mode-alist
;        (append (list (cons "\\.t$" 'tads2-mode))
;                auto-mode-alist))

(load-file "~/emacs/parrot.el")
(load-file "~/emacs/pasm.el")
(load-file "~/emacs/pir-mode.el")
(byte-compile-if-newer-and-load "~/emacs/word-count.el")

;; Load the pir mode
(autoload 'pir-mode "pir-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.pir\\'" . pir-mode))

;; setup mason
;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)
;; (add-to-list 'auto-mode-alist '("\\.mas\\'" . html-mode))
;; (mmm-add-mode-ext-class 'html-mode "\\.mas\\'" 'mason)
;; (add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
;; (mmm-add-mode-ext-class 'html-mode "\\.html\\'" 'mason)

;; (byte-compile-if-newer-and-load "~/emacs/clojure/clojure-mode")


;(autoload 'clojure-mode "~/emacs/clojure/clojure-mode/clojure-mode" "A major mode for Clojure" t)
;(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;(setq clojure-src-root "/home/jules/src")
;(setq swank-clojure-extra-classpaths nil)
;(clojure-slime-config "/home/jules/src")

;; Setup perlcritic
;; (byte-compile-if-newer-and-load "~/emacs/modes/perlcritic")

;; (autoload 'perlcritic        "perlcritic" "" t)
;; (autoload 'perlcritic-region "perlcritic" "" t)
;; (autoload 'perlcritic-mode   "perlcritic" "" t)

(eval-after-load "cperl-mode"
  '(add-hook 'cperl-mode-hook 'perlcritic-mode))

;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org>                               
(defalias 'perl-mode 'cperl-mode)

(custom-set-variables
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t))

;; (eval-after-load "perl-mode"
;;   '(add-hook 'perl-mode-hook 'perlcritic-mode))
;;

;; haml-mode
(byte-compile-if-newer-and-load "~/emacs/haml-mode/haml-mode.el")

;; flex-mode
(byte-compile-if-newer-and-load "~/emacs/modes/flex-mode.el")

;; insert lorem-ipsum
(byte-compile-if-newer-and-load "~/emacs/lorem-ipsum.el")

(require 'color-theme)

(color-theme-initialize)
;;(eval-after-load "color-theme" '(when window-system (color-theme-dark-laptop)))
(eval-after-load "color-theme" '(when window-system (color-theme-deep-blue)))

;; Setup org-mode
;; (require 'org-install)
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done t)

;; Relative line numbers in linum-mode
;; http://stackoverflow.com/questions/6874516/relative-line-numbers-in-emacs
(defvar my-linum-current-line-number 0)
(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (number-to-string (- line-number my-linum-current-line-number)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)


