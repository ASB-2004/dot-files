;; Startup time
(defun efs/display-startup-time ()
  (message
    "Emacs loaded in %s with %d garbage collections."
    (format
      "%.2f seconds"
      (float-time
        (time-subtract after-init-time before-init-time)))
    gcs-done))
;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'load-path (expand-file-name "custom/bookmark-plus" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "custom/bookmark-plus/bookmark+-mac.el" user-emacs-directory))
(require 'bookmark+)

(setq initial-scratch-message ";; ╔═╗┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬\n;; ╚═╗│  ├┬┘├─┤ │ │  ├─┤\n;; ╚═╝└─┘┴└─┴ ┴ ┴ └─┘┴ ┴\n")
(when init-file-debug
  (setq use-package-verbose t
        use-package-expand-minimally nil
        use-package-compute-statistics t
        debug-on-error t))

(require 'package)
(require 'use-package)
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "/Users/shashank/.emacs.d/elpa/use-package-2.4.5")
  (require 'use-package))
(use-package package
             :init
             (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                                      ("melpa" . "http://melpa.org/packages/")))
             (add-to-list 'package-archives '("melpa stable" . "http://stable.melpa.org/packages/"))
             (package-initialize)
             ;	(package-refresh-contents)
             )

(use-package evil
             :ensure t
             :after undo-tree
             :demand t
             :config
             (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
             (define-key evil-normal-state-map (kbd "C-e") #'evil-mode)
             (define-key evil-insert-state-map (kbd "RET") #'evil-ret-and-indent)
             (define-key evil-insert-state-map (kbd "RET") #'evil-ret-and-indent)
             (define-key evil-insert-state-map (kbd "jk") #'evil-normal-state)
             (define-key evil-normal-state-map "u" 'undo-tree-undo)
             (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)
             (define-key evil-normal-state-map (kbd "C-o") #'vterm-toggle-cd)
             (define-key evil-normal-state-map (kbd "<space>wo") #'delete-other-window)
             (add-hook 'emacs-startup-hook #'evil-mode)
             )
(use-package undo-tree
             :ensure t
             :demand t
             :config
             (global-undo-tree-mode t)
             )
;; (loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
;; 			    (nrepl-mode . insert)
;; 			    (pylookup-mode . emacs)
;; 			    (comint-mode . normal)
;; 			    (shell-mode . insert)
;; 			    (git-commit-mode . insert)
;; 			    (git-rebase-mode . emacs)
;; 			    (term-mode . emacs)
;; 			    (help-mode . emacs)
;;                           (org-mode . normal)
;; 			    (helm-grep-mode . emacs)
;; 			    (grep-mode . emacs)
;; 			    (bc-menu-mode . emacs)
;; 			    (magit-branch-manager-mode . emacs)
;; 			    (rdictcc-buffer-mode .emacs)
;; 			    (dired-mode . emacs)
;; 			    (wdired-mode . normal)
;; 			    (cc-mode . normal))
;;   do (evil-set-initial-state mode state))

(set-face-attribute 'default nil
                    :font "Fira code"
                    :height 175
                    :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
;;(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
;;(setq-default line-spacing 0.12)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(electric-pair-mode 1) ;auto bracket completion
(setq tab-width 4)
(setq ring-bell-function 'ignore)
(setq user-full-name "Annangi Shashank Babu"
      user-mail-address "shashankbabu2004@gmail.com")

(global-display-line-numbers-mode nil)
(global-visual-line-mode nil)
(setq display-line-numbers-type 'relative)
(setq split-width-threshold 0)
(setq split-height-threshold nil)
(setq compilation-window-height 40)
(desktop-save-mode t)
(setq desktop-path '("." "~/.emacs.d/var/desktop/" "~"))
(add-hook 'prog-mode-hook #'display-line-numbers-mode);;not working

(load-theme 'wheatgrass t)
;(use-package doom-themes
;  :init (load-theme 'doom-one t))
;(load-theme 'zenburn t)
; (load-theme 'ujelly t)
;(load-theme 'jbeans t)

(use-package which-key
             :ensure t
             :demand t
             :config
             (which-key-mode)
             :init
             (setq which-key-side-window-location 'bottom
                   which-key-sort-order #'which-key-description-order
                   which-key-sort-uppercase-first nil
                   which-key-add-column-padding 1
                   which-key-max-display-columns nil
                   which-key-min-display-lines 10
                   which-key-side-window-slot -10
                   which-key-side-window-max-height 0.50
                   which-key-idle-delay 1.2
                   which-key-max-description-length 50
                   which-key-allow-imprecise-window-fit nil
                   which-key-separator " → " ))

(use-package org
             :ensure t
             :init
             (setq org-directory "~/Documents/org/"
                   org-default-notes-file (expand-file-name "notes.org" org-directory))
             :config
             (setq org-link-abbrev-alist
                   '(("google" . "http://www.google.com/search?q=")
                     ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
                     ("ddg" . "https://duckduckgo.com/?q=")
                     ("wiki" . "https://en.wikipedia.org/wiki/"))
                   org-agenda-files '("~/Documents/org/")
                   org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
                   '((sequence
                       "TODO(t)"           ; A task that is ready to be tackled
                       "HIGHLIGHT(h)"           ; highlight of the day 
                       "|"                 ; The pipe necessary to separate "active" states and "inactive" states
                       "DONE(d)"           ; Task has been completed
                       )) ; Task has been cancelled
                   org-ellipsis " ▼ ")
             :config
             (setq
               ;org-fancy-priorities-list '("[A]" "[B]" "[C]")
               ;org-fancy-priorities-list '("❗" "[B]" "[C]")
               org-fancy-priorities-list '("🟥" "🟧" "🟨")
               org-priority-faces
               '((?A :foreground "#ff6c6b" :weight bold)
                 (?B :foreground "#98be65" :weight bold)
                 (?C :foreground "#c678dd" :weight bold))
               org-agenda-block-separator 8411)
             (setq org-startup-indented t)           ;; Indent according to section
             (setq org-startup-with-inline-images t) ;; Display images in-buffer by default
             (setq org-agenda-custom-commands
                   '(("v" "A better agenda view"
                      (
                       (tags "PRIORITY=\"A\""
                             ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                              (org-agenda-overriding-header "High-priority unfinished tasks:")))
                       (tags "PRIORITY=\"B\""
                             ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                              (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
                       (tags "PRIORITY=\"C\""
                             ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                              (org-agenda-overriding-header "Low-priority unfinished tasks:")))
                       (tags "customtag"
                             ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                              (org-agenda-overriding-header "Tasks marked with customtag:")))
                       (alltodo ""))))))
(use-package org-superstar
             :ensure t
             :config
             (setq
               org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
               org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)))
             :hook
             (org-mode . org-superstar-mode))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)
(use-package org-pdftools
             :ensure t
             :after org
             :hook (org-mode . org-pdftools-setup-link))

(use-package org-roam
             :ensure t
             :after org
             :init
             (setq org-roam-directory "~/Documents/roam")
             :custom
             (setq org-roam-capture-templates
                   '(("a" "pns" plain (file "~/Documents/roam/pns/pns.org")
                      :target (file+head "pns/%<%Y%m%d%H%M%S>-${slug}.org"
                                         "#+title: ${title}\n")
                      :unnarrowed t)
                     ("b" "research" plain (file "~/Documents/roam/research.org")
                      :target (file+head "research/%<%Y%m%d%H%M%S>-${slug}.org"
                                         "#+title: ${title}\n")
                      :unnarrowed t)))

             :bind (("C-c n l" . org-roam-buffer-toggle)
                    ("C-c n r" . org-roam-node-random)
                    ("C-c n c" . org-roam-capture)
                    ("C-c n f" . org-roam-node-find)
                    ("C-c n i" . org-roam-node-insert))

             :config
             (org-roam-setup))

(global-set-key (kbd "C-c r") #'LoadInitDotEl)
(defun LoadInitDotEl () (interactive)(load-file(expand-file-name "init.el" user-emacs-directory)))

(global-set-key (kbd "C-c f") #'OpenConfigDotOrg)
(defun OpenConfigDotOrg () (interactive)(find-file(expand-file-name "config.org" user-emacs-directory)))
(global-set-key (kbd "M-n") #'next-buffer)
(global-set-key (kbd "M-p") #'previous-buffer)
(global-set-key (kbd "C-e") #'evil-mode)

;; vterm toggle 

(global-set-key (kbd "C-o") #'vterm-toggle-cd)

;; set leader key in all states
;   (evil-set-leader nil (kbd "C-SPC"))

;; set leader key in normal state
;  (evil-set-leader 'normal (kbd "SPC"))

;; set local leader
; (evil-set-leader 'normal "," t)
;(define-key 'normal 'global (kbd "C-e") #'evil-mode)

(require 'org-tempo)

(use-package pdf-tools
             :ensure t
             :after (org-noter)
             :bind (:map pdf-view-mode-map
                         ("C-o" . org-noter))
             :config 
             (add-hook 'pdf-view-mode #'(lambda() (blink-cursor-mode -1)))
             )
(add-hook 'dov-view-mode #'(lambda() ('pdf-view-mode)))

(use-package all-the-icons
             :ensure t
             :if (display-graphic-p))

(use-package all-the-icons-dired
             :ensure t
             :after all-the-icons
             :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))
(use-package all-the-icons-ibuffer
             :ensure t
             :after all-the-icons
             :hook (ibuffer-mode . (lambda () (all-the-icons-ibuffer-mode t))))

(use-package auctex
             :requires texsite
             :ensure t)
(use-package latex-preview-pane
             :commands (latex-preview-pane)
             :after auctex
             :ensure t)

;; latex from internet
;; AucTeX settings
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (push
              '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                :help "Run latexmk on file")
              TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

(custom-set-variables
  '(TeX-source-correlate-method 'synctex)
  '(TeX-source-correlate-mode t)
  '(TeX-source-correlate-start-server t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable vertico
(use-package vertico
             :ensure t
             :init
             (vertico-mode)

             ;; Different scroll margin
             ;; (setq vertico-scroll-margin 0)

             ;; Show more candidates
             ;; (setq vertico-count 20)

             ;; Grow and shrink the Vertico minibuffer
             ;;    (setq vertico-resize t)

             ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
             (setq vertico-cycle t)
             )
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
             :ensure t
             :init
             (savehist-mode 1))

;; Optionally use the `orderless' completion style.

(use-package emacs
             :ensure t
             :init
             ;; Add prompt indicator to `completing-read-multiple'.
             ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
             (defun crm-indicator (args)
               (cons (format "[CRM%s] %s"
                             (replace-regexp-in-string
                               "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                               crm-separator)
                             (car args))
                     (cdr args)))
             (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

             ;; Do not allow the cursor in the minibuffer prompt
             (setq minibuffer-prompt-properties
                   '(read-only t cursor-intangible t face minibuffer-prompt))
             (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

             ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
             ;; Vertico commands are hidden in normal buffers.
             ;; (setq read-extended-command-predicate
             ;;       #'command-completion-default-include-p)

             ;; Enable recursive minibuffers
             (setq enable-recursive-minibuffers t))
(use-package vertico-directory
             :after vertico
             :ensure nil
             ;; More convenient directory navigation commands
             :bind (:map vertico-map
                         ("RET" . vertico-directory-enter)
                         ("M-DEL" . vertico-directory-delete-char)
                         ("DEL" . vertico-directory-delete-word)
                         ("TAB" . minibuffer-complete))
             ;; Tidy shadowed file names
             :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;(use-package modern-cpp-font-lock
;:ensure t)
;(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
(use-package oj
             :ensure t
             :defer t
             :init
             (setq oj-home-dir "~/Documents/contest"))

(use-package yasnippet 
             :ensure t
             :init
             ;; TODO emacs is not setting the yas-snippet dirst , have done manually now
             (setq yas-snippet-dirs
                   '("~/.emacs.d/snippets" "~/.emacs.d/elpa/yasnippet-snippets-1.0/snippets"))
             (yas-global-mode t))

(use-package yasnippet-snippets
             :ensure t
             :after yasnippet)

(use-package cc-mode
             :ensure t
             :init 
             (defun ContestCompileAndRun()
               (interactive)
               (save-buffer)
               (let* ((src (file-name-nondirectory (buffer-file-name)))
                      (exe (file-name-sans-extension src)))
                 (compile (concat "g++ -include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g " src " -o " exe " && timeout 5s ./" exe " <inp" exe))))

             (defun ContestCompile()
               (interactive)
               (save-buffer)
               (let* ((src (file-name-nondirectory (buffer-file-name)))
                      (exe (file-name-sans-extension src)))
                 (compile (concat "g++ -include-pch stdc++.h -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g " src " -o " exe))))

             (defun FindInputFile()
               (interactive)
               (let* ((exe (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
                 (find-file-other-window (concat "inp" exe))))
             :bind 
             (("<f10>" . ContestCompileAndRun)
              ("<f9>" . ContestCompile) 
              ("C-c i" . FindInputFile)))
(setq-default c-basic-offset 4)

;(use-package flycheck
;  :ensure t
;  :custom
;  (setq flycheck-python-flake8-executable "python3")
;  (setq flycheck-python-pycompile-executable "python3")
;
;  (setq flycheck-clang-language-standard "c++20")
;  (setq flycheck-clang-definitions (list "ONPC"))
;  (setq flycheck-clang-args (list  "-include-pch stdc++.h.pch -fsanitize=address -std=c++20 -Wall -Wextra -Wshadow -DONPC -O2 -g "))
;  (setq flycheck-clang-includes (list '"algorithm" '"bitset" '"complex" '"deque" '"functional" '"fstream" '"exception" '"iomanip" '"queue" '"map" '"set" '"stack" '"string" '"vector"
;									  '"chrono" '"random" '"regex" '"system_error" '"tuple" '"unordered_map" '"unordered_set" '"climits" '"limits" '"list" '"locale"
;									  '"array" '"forward_list" '"iostream")))
(quickrun-set-default "c" "c/clang")
(quickrun-set-default "c++" "c++/clang++")
;(global-flycheck-mode 1)
(use-package eglot :ensure t)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package clang-format
             :ensure t
             :commands (clang-format)
             :init
             (setq clang-format-fallback-style "WebKit")
             (setq clang-format-fallback-style "WebKit"))

(use-package clang-format+
             :ensure t
             :commands (clang-format+-mode)
             :init
             (add-hook 'c-mode-common-hook #'clang-format+-mode)
             (add-hook 'c++-mode-hook #'clang-format+-mode)
             (setq clang-format+-always-enable t)
             )

(setq backup-directory-alist `(("." . , (expand-file-name "tmp/backups/" user-emacs-directory))))
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(use-package no-littering
             :ensure t)

(use-package python
             :ensure t
             :custom
             (setq
               python-shell-interpreter "ipython"
               python-shell-interpreter-args "-i --simple-prompt"
               python-shell-prompt-regexp "In \\[[0-9]+\\]: "
               python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
               python-shell-completion-setup-code
               "from IPython.core.completerlib import module_completion"
               python-shell-completion-module-string-code
               "';'.join(module_completion('''%s'''))\n"
               python-shell-completion-string-code
               "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
               )

             ;(add-hook 'python-mode-hook (lamda ()(setq anaconda-mode nil)))

             (defun my-python-format-region (Begin End)
               "Format the current region file using `xah-python-formatter-software'.
               The region must be a valid python code.
               File is saved first.
               URL `http://xahlee.info/emacs/emacs/xah_format_python_code.html'
               Version 2022-08-25 2022-08-28"
               (interactive)
               (shell-command-on-region
                 Begin End
                 (format "%s - -q" "/opt/homebrew/bin/black")
                 nil
                 t))

             (defun my-python-format-buffer ()
               "Format the current buffer file by calling `xah-python-formatter-software'.
               If buffer is a file, it is saved first.

               URL `http://xahlee.info/emacs/emacs/xah_format_python_code.html'
               Version 2022-08-25 2022-08-28"
               (interactive)
               (let (($buffFileName (buffer-file-name)))
                 (if $buffFileName
                   (progn
                     ;(save-buffer)
                     (shell-command
                       (format "%s %s -q" "/opt/homebrew/bin/black "$buffFileName))
                     (revert-buffer t t t) )
                   (my-python-format-region (point-min) (point-max))))
               ;; (user-error "buffer should be a file. Use `xah-python-format-region' instead.")
               )
             ;(add-hook 'before-save-hook #'my-python-format-buffe)
             (add-hook 'python-mode-hook
                       (lambda () (add-hook 'after-save-hook #'my-python-format-buffer nil 'local))))

(use-package vterm
             :ensure t)

(use-package vterm-toggle
             :ensure t
             :after vterm
             :config
             (setq vterm-toggle-fullscreen-p nil)
             (setq vterm-toggle-scope 'project)
             (add-to-list 'display-buffer-alist
                          '((lambda (buffer-or-name _)
                              (let ((buffer (get-buffer buffer-or-name)))
                                (with-current-buffer buffer
                                                     (or (equal major-mode 'vterm-mode)
                                                         (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                            (display-buffer-reuse-window display-buffer-at-bottom)
                            ;;(display-buffer-reuse-window display-buffer-in-direction)
                            ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                            ;;(direction . bottom)
                            ;;(dedicated . t) ;dedicated is supported in emacs27
                            (reusable-frames . visible)
                            (window-height . 0.4)))
             :bind (
                    :map vterm-mode-map
                    ("C-o" . vterm-toggle-cd)))

(use-package company
             :ensure t
             :demand t
             :commands (global-company-mode)
             :config
             ;; Add yasnippet support for all company backends
             ;; https://github.com/syl20bnr/spacemacs/pull/179
             (defvar company-mode/enable-yas t
               "Enable yasnippet for all backends.")

             (defun company-mode/backend-with-yas (backend)
               (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
                 backend
                 (append (if (consp backend) backend (list backend))
                         '(:with company-yasnippet))))

             (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
             (add-hook 'after-init-hook 'global-company-mode)
             )
