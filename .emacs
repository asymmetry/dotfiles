; ui
(setq frame-title-format "%b@emacs")
(setq inhibit-startup-screen t)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(blink-cursor-mode 0)
(column-number-mode t)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

; edit
(cua-mode t)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode t)

; defaults
(setq default-major-mode 'text-mode)
(setq custom-file "~/.emacs.d/custom.el")
(defalias 'yes-or-no-p 'y-or-n-p)

; backups
(setq version-control t)
(setq kept-old-versions 0)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/auto-save-list")))

; encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

; package manager
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(require 'cl-lib)

; use package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)
(use-package diminish)
(require 'bind-key)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

; atom one dark theme
(use-package atom-one-dark-theme
  :config
  (load-theme 'atom-one-dark t))
(add-to-list 'default-frame-alist '(font . "Fira Mono-12"))
(set-face-attribute 'mode-line nil :font "Fira Mono-11")

; tabbar
(use-package tabbar
  :bind
  (("M-<up>" . 'tabbar-backward-group)
   ("M-<down>" . 'tabbar-forward-group)
   ("M-<left>" . 'tabbar-backward)
   ("M-<right>" . 'tabbar-forward))
  :config
  (tabbar-mode t))

; ivy swiper & counsel
(use-package ivy
  :bind
  ("C-c C-r" . 'ivy-resume)
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq enable-recursive-minibuffers t))
(use-package swiper
  :bind
  ("\C-s" . 'swiper))
(use-package counsel
  :bind
  (("M-x" . 'counsel-M-x)
   ("C-x C-f" . 'counsel-find-file)
   ("<f1> f" . 'counsel-describe-function)
   ("<f1> v" . 'counsel-describe-variable)
   ("<f1> l" . 'counsel-find-library)
   ("<f2> i" . 'counsel-info-lookup-symbol)
   ("<f2> u" . 'counsel-unicode-char)
   ("C-c g" . 'counsel-git)
   ("C-c j" . 'counsel-git-grep)
   ("C-c k" . 'counsel-ag)
   ("C-x l" . 'counsel-locate)
   ("C-S-o" . 'counsel-rhythmbox)))

; parentheses
(use-package smartparens
  :hook
  ((c-mode-common emacs-lisp-mode python-mode) . smartparens-mode)
  :config
  (require 'smartparens-config))
(use-package rainbow-delimiters
  :hook
  ((c-mode-common emacs-lisp-mode python-mode) . rainbow-delimiters-mode))
(show-paren-mode t)

; company-irony (code completion)
(use-package irony
  :hook
  (((c-mode c++-mode) . irony-mode)
   (irony-mode . irony-cdb-autosetup-compile-options)))
(use-package company-irony
  :hook
  (after-init . global-company-mode)
  :config
  (setq company-idle-delay t
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-limit 10
        company-dabbrev-downcase nil))
(use-package company-irony-c-headers
  :config
  (add-to-list 'company-backends '(company-irony-c-headers company-irony)))

; flycheck-irony
(use-package flycheck
  :hook
  ((c-mode c++-mode) . flycheck-mode))
(use-package flycheck-irony
  :hook
  (flycheck-mode . flycheck-irony-setup)
  :config
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11"))))

; ggtags (code jump)
(use-package ggtags
  :config
  (setq gtags-suggested-key-mapping t))
(use-package counsel-gtags
  :bind
  (:map counsel-gtags-mode-map
        ("M-t" . 'counsel-gtags-find-definition)
        ("M-r" . 'counsel-gtags-find-reference)
        ("M-s" . 'counsel-gtags-find-symbol)
        ("M-," . 'counsel-gtags-go-backward))
  :hook
  ((c-mode c++-mode) . counsel-gtags-mode))

; cc mode
(use-package cc-mode :ensure nil
  :config
  (defun my-c-mode-common-hook ()
    (c-set-style "k&r")
    (c-set-offset 'substatement-open 0)
    (c-set-offset 'member-init-intro '++)
    (setq c-basic-offset 4
          tab-width 4
          indent-tabs-mode nil)
    (c-toggle-auto-hungry-state 1)
    (local-set-key [return] 'newline-and-indent))
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook))

; cmake mode
(use-package cmake-mode :ensure nil
  :mode
  ("CMakeLists\\.txt\\'" . cmake-mode))

; markdown mode
(use-package markdown-mode
  :mode
  (("\\.markdown\\'" . markdown-mode)
   ("\\.md\\'" . markdown-mode)
   ("README\\.md\\'" . gfm-mode)))

; docker mode
(use-package dockerfile-mode
  :mode
  ("Dockerfile\\'" . dockerfile-mode))

; auctex
(use-package latex
  :ensure auctex
  :mode
  ("\\.tex\\'" . latex-mode)
  :config
  (setq Tex-PDF-mode t))

; server
(load "server")
(unless (server-running-p) (server-start))

; blackout minor mode
(define-minor-mode minor-mode-blackout-mode
  "Hides minor modes from the mode line."
  t)
(catch 'done
  (mapc (lambda (x)
          (when (and (consp x)
                     (equal (cadr x) '("" minor-mode-alist)))
            (let ((original (copy-sequence x)))
              (setcar x 'minor-mode-blackout-mode)
              (setcdr x (list "" original)))
            (throw 'done t)))
        mode-line-modes))
(global-set-key (kbd "C-c m") 'minor-mode-blackout-mode)
