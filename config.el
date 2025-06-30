;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;;字体设置
;; (setq doom-font (font-spec :family "Iosevka" :weight 'medium :size 13.0))

;;   (defun my-cjk-font()
;;     (dolist (charset '(kana han cjk-misc symbol bopomofo))
;;       (set-fontset-font t charset (font-spec :family "Sarasa Mono SC"))))
;; (add-hook 'after-setting-font-hook #'my-cjk-font)
;;

(setq doom-font (font-spec :family "LXGW Wenkai Mono" :weight 'medium :size 13.0))

  (defun my-cjk-font()
    (dolist (charset '(kana han cjk-misc symbol bopomofo))
      (set-fontset-font t charset (font-spec :family "LXGW Wenkai Mono"))))

  (add-hook 'after-setting-font-hook #'my-cjk-font)


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(after! org
  (setq org-todo-keywords '((sequence "TODO" "DOING" "DONE")))
  ;; org agenda设置
  (setq org-agenda-files '("~/org/src/"
                           "~/org/notes.org"
                           "~/org/Work-Atom.org"
                           ))
  ;;---------------------------------------------
  ;;org-agenda-time-grid
  ;;--------------------------------------------
  (setq org-agenda-time-grid (quote ((daily today require-timed)
                                     (300
                                      600
                                      900
                                      1200
                                      1500
                                      1800
                                      2100
                                      2400)
                                     "......"
                                     "-----------------------------------------------------"
                                     )))

  ;;整合diary-file到org-agenda中的配置:
  (setq org-agenda-include-diary t)
  (setq org-agenda-diary-file "~/org/src/standard-diary")
  (setq diary-file "~/org/src/standard-diary")

  (setq org-capture-templates nil) ;;把doom原生的org-capture templates清除。

  (add-to-list 'org-capture-templates
             '("t" "Personal todo" entry
               (file+olp "~/org/Notes.org" "Todolist")
               "* TODO %^{待办事项} \n %u"))
  (add-to-list 'org-capture-templates
             '("T" "Work todo" entry
               (file+olp "~/org/Work-Atom.org" "todolist")
               "* TODO %^{待办事项} \n %u"))
  (add-to-list 'org-capture-templates
             '("d" "Diary" entry
               (file "~/org/日记.org")
               "* %<%Y>年%<%m>月%<%d>日 \n %^{日记内容}"))
  (add-to-list 'org-capture-templates
               '("n" "Personal Notes" entry
                 (file+olp "~/org/notes.org" "Inbox")
                 "* %^{heading} %t\n %?\n"))
  (add-to-list 'org-capture-templates
               '("w" "Work Notes" entry
                 (file+olp "~/org/Work-Atom.org" "Inbox")
                 "* %^{heading} %t\n %?\n"))

  )


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; 通过Emacs-china 的仓库来安装包, 提升安装速度
(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;;elfeed配置
;;(after! elfeed
;;  (setq elfeed-search-filter "@1-month-ago +unread")
;;  (setq rmh-elfeed-org-files '("~/org/elfeed.org")))
;;(add-hook! 'elfeed-search-mode-hook #'elfeed-update)
;;;; 关闭Doom rss 切割图片的功能, 展示完整图片吧
;;(setq +rss-enable-sliced-images nil)


;;emacs系统设置
(setq confirm-kill-emacs nil ; 关闭 emacs 时无需额外确认
      system-time-locale "C" ; 设置系统时间显示方式
      ;; pop-up-windows nil     ; no pop-up window
      ;; scroll-margin 2        ; It's nice to maintain a little margin
      ;; widget-image-enable nil
      ;; visible-bell nil
      ;; ring-bell-function 'ignore
      )

;; 编码设置
;; (prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8)
;; (set-language-environment 'Chinese-GB) ; 设置语言环境为中文，可能需要根据你的系统调整
;; (set-buffer-file-coding-system 'utf-8-unix) ; 建议使用 utf-8-unix
;; (set-default-coding-systems 'utf-8-unix)
;; (setq file-name-coding-system 'utf-8-unix)




;; 打开文件时, 光标自动定位到上次停留的位置
(save-place-mode 1)

;; (global-auto-revert-mode)

;; (setq display-line-numbers-type nil)

;; 保存会话窗口
;; Automatically save and restore sessions
(setq desktop-dirname             "~/.emacs.d/desktop/"
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil
      desktop-auto-save-timeout   30)
(desktop-save-mode 1)

;; 指定启动时的窗口位置和大小
;;(setq initial-frame-alist '((top . 45)
;;                             (left . 1200)
;;                             (width . 150)
;;                             (height . 45)))

(setq frame-title-format "Sean")
;; (menu-bar-mode -1) ;; minimal chrome
;; (tool-bar-mode -1) ;; no toolbar
;; (scroll-bar-mode -1) ;; disable scroll bars

;; (setq initial-major-mode 'org-mode) ;; org!
;; (setq initial-scratch-message nil)


;;;快捷键设置
(map!
 ;;"C-x w" #'elfeed
 "<f1>" #'+doom-dashboard/open
;;       "C-c n l" #'org-roam-buffer-toggle
;;       "C-c n f" #'org-roam-node-find
;;       "C-c n g" #'org-roam-graph
;;       "C-c n i" #'org-roam-node-insert
;;       "C-c n c" #'org-roam-capture
;;       "C-c n j" #'org-roam-dailies-goto-today

 :leader "x" #'org-capture
      )

;;shift select mode
(setq shift-select-mode t)

;; (after! org
  ;; 设置阳历节日和阴历节日、阴历生日
  ;; 补充用法: holiday-float m w n 浮动阳历节日, m 月的第 n 个星期 w%7
  (setq general-holidays  '((holiday-fixed 1 1   "元旦")
                           (holiday-fixed 2 14  "情人节")
                           (holiday-fixed 4 1   "愚人节")
                           (holiday-fixed 12 25 "圣诞节")
                           (holiday-fixed 10 1  "国庆节")
                           (holiday-float 5 0 2 "母亲节")   ;5月的第二个星期天
                           (holiday-float 6 0 3 "父亲节")
                           ))
  (setq local-holidays   '((holiday-chinese 1 15  "元宵节 (正月十五)")
                         (holiday-chinese 5 5   "端午节 (五月初五)")
                         (holiday-chinese 9 9   "重阳节 (九月初九)")
                         (holiday-chinese 8 15  "中秋节 (八月十五)")
                         ;; 生日
                         (birthday-fixed 4 24  "我的生日(1988)")
                         (holiday-chinese 9 21  "爸爸生日(1956)")
                         (holiday-chinese 5 21  "妈妈生日(1957)")
                         (holiday-chinese 2 29  "陈凡生日(1991)")           ;阴历生日

                         (holiday-lunar 1 1 "春节" 0)
                         ))
  (setq calendar-mark-holidays-flag t)    ;让calendar自动标记出节假日的日期
  (setq calendar-mark-diary-entries-flag t)    ;让calendar自动标记出记有待办事项的日期
  (setq calendar-week-start-day 1)            ;设置星期一为每周的第一天
;; )
