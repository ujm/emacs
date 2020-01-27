(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
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

(fset 'form_input   [?\C-m ?t ?e ?s ?t ?  ?テ ?ス ?ト ?\C-m ?\C-i ?\C-m ?後 ?藤 ?\C-i ?\C-? ?\C-m ?\C-i ?\C-m ?テ ?\ス ?ト ?\C-m ?\C-i ?\C-m ?ゴ ?ト ?ウ ?\C-m ?\C-i ?\C-m ?テ ?ス ?ト ?\C-m ?\C-i ?\C-m ?g ?o ?t ?o ?@ ?b ?r ?o ?a ?d ?t ?e ?c ?h ?. ?c ?o ?j ?p ?\C-? ?\C-? ?. ?j ?p ?\C-a ?\C-@ ?\C-e ?\C-\[ ?w ?\C-m ?\C-i ?\C-m ?\C-y ?\C-m ?\C-i ?\C-m ?1 ?6 ?7 ?\C-m ?\C-i ?\C-m ?0 ?0 ?5 ?2 ?\C-m ?\C-i ?\C-i ?\C-m ?j ?j ?j ?j ?j ?j ?j ?j ?j ?j ?j ?j ?j ?\C-m ?\C-i ?\C-m ?杉 ?並 ?区 ?\C-m ?\C-i ?\C-m ?南 ?荻 ?窪 ?1 ?\C-? ?2 ?- ?2 ?8 ?- ?2 ?  ?ハ ?イ ?ム ?芙 ?蓉 ?1 ?2 ?\C-? ?0 ?2 ?\C-m ?\C-i ?\C-m ?0 ?9 ?0 ?\C-m ?\C-i ?\C-m ?3 ?7 ?3 ?2 ?\C-m ?\C-i ?\C-m ?0 ?1 ?1 ?1 ?\C-m ?\C-i ?\C-i ?\C-m])

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
