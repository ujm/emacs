(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

;; 初期化
(package-initialize)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup")) version-control t)
(put 'upcase-region 'disabled nil)

(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 0.5)

;;カーソル前の文字を1文字消す
(global-set-key "\C-h" 'delete-backward-char)

;; auto-complete の設定
(require 'auto-complete-config)
(ac-config-default)

;; perl-mode の設定
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook 
    (function (lambda ()
        (set-face-background 'cperl-hash-face "black")
        (set-face-background 'cperl-array-face "black")
)))

;; cc-mode の設定
(require 'cc-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(fset 'mailaddress
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("^Mgo\
to@broadtech.co.jp" 0 "%d")) arg)))

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
      ;; DONEの時刻を記録
      (setq org-log-done 'time)

(setq org-agenda-files '("todo.org"))

(global-set-key (kbd "C-c a") 'org-agenda)

(setq indent-guide-delay 0.1)
(setq indent-guide-recursive t)
(add-hook 'prog-mode-hook 'indent-guide-mode)

;;======================
;; GO 言語のための設定==
;;======================
;; Goのパスを通す
(add-to-list 'exec-path (expand-file-name "/usr/local/go/bin/"))
;; go get で入れたツールのパスを通す
(add-to-list 'exec-path (expand-file-name "~/work/go/bin/"))
;; 必要なパッケージのロード
(require 'go-mode)
(require 'company-go)
;; 諸々の有効化、設定
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
           (add-hook 'before-save-hook' 'gofmt-before-save)
           (local-set-key (kbd "M-.") 'godef-jump)
           (set (make-local-variable 'company-backends) '(company-go))
           (company-mode)
           (setq indent-tabs-mode nil)
           (setq c-basic-offset 4)
           (setq tab-width 4)
           ;; C-n, C-pで補完候補を次/前の候補を選択
           (define-key company-active-map (kbd "C-n") 'company-select-next)
           (define-key company-active-map (kbd "C-p") 'company-select-previous)
           (setq company-selection-wrap-around t)
           (setq company-idle-delay 0)
))
;;==============================
;; GO 言語のための設定ここまで==
;;==============================

;;============================
;;=org-capture の設定
;;============================
(setq org-capture-templates
    '(("t" "スケジュール" entry (file "~/todo.org")
         "* TODO %? \n")
        ("m" "メモ" entry (file+headline "~/memo.org" "メモ")
         "* %?\n  %T")))

(global-set-key (kbd "C-c c") 'org-capture)
;;============================
;;=org-capture の設定ここまで
;;============================

;;============================
;;=org-html-export-to-html の設定
;;============================

(defun my-org-replace-newline-and-remove-backslashes-from-headlines (backend)
    "Add backslashes at the end of each line and remove them from headlines during HTML export."
      (when (eq backend 'html)
            ;; Add \\ at the end of each line
                (goto-char (point-min))
                    (while (not (eobp))
                                 (goto-char (line-end-position))
                                       (insert " \\\\")
                                             (forward-line 1))
                        ;; Remove \\ from the end of lines starting with * or **
                            (goto-char (point-min))
                                (while (re-search-forward "^\\*+ .* \\\\\\\\$" nil t)
                                             (replace-match (replace-regexp-in-string " \\\\\\\\$" "" (match-string 0)) nil t))))

(add-hook 'org-export-before-processing-hook 'my-org-replace-newline-and-remove-backslashes-from-headlines)
;;============================
;;=org-html-export-to-html の設定ここまで
;;============================
