;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ============================
;; Doom Emacs 基本配置
;; ============================

;; 用户信息（可选）
(setq user-full-name "Sean Yuan"
      user-mail-address "yuan_xiang@outlook.com")

;; ============================
;; Doom 字体配置（等宽 + 中文 + Emoji + all-the-icons）
;; ============================

;; 根据系统类型设置不同字号
(cond
 ((eq system-type 'darwin)  ;; macOS
  (defvar my-font-size 18 "macOS 默认字体大小"))
 ((eq system-type 'gnu/linux) ;; Linux
  (defvar my-font-size 22 "Linux 默认字体大小"))
 ((eq system-type 'windows-nt) ;; Windows
  (defvar my-font-size 24 "Windows 默认字体大小"))
 (t ;; 其他未知系统
  (defvar my-font-size 20 "默认字体大小")))
;; 英文 & 中文统一字体
(setq doom-font (font-spec :family "Sarasa Mono SC" :size my-font-size :weight 'semi-bold)
      doom-variable-pitch-font doom-font)

;; 中文等宽字体
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font t charset
                    (font-spec :family "Sarasa Mono SC" :size my-font-size :weight 'semi-bold)
                    nil 'prepend))

;; Emoji 字体
(when (member "Noto Color Emoji" (font-family-list))
  (set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji") nil 'prepend))

;; all-the-icons 支持
(when (member "Font Awesome 6 Free Solid" (font-family-list))
  (set-fontset-font t 'unicode (font-spec :family "Font Awesome 6 Free Solid") nil 'prepend))

;; 字体缩放比例
(setq face-font-rescale-alist
      `(("Sarasa Mono SC" . 1.0)
        ("Noto Color Emoji" . 1.0)
        ("Apple Color Emoji" . 1.0)))

(provide 'init-fonts)

;; 字体对齐测试
"
| 软件      |  版本 | 发布日期     |
|-----------+-------+--------------|
| GNU Emacs |  25.1 | 2016 年 9 月 |
| Org       | 9.9.5 | 2017 年 2 月 |
"

;; ============================
;; 主题 & 行号
;; ============================
;; (setq doom-theme 'spacemacs-light)
;; (setq doom-theme 'doom-one-light)
;; (setq doom-theme 'leuven)
;; (setq display-line-numbers-type t)
;; 加载主题
;; (load-theme 'leuven t t) ;; 加载浅色主题
;; (load-theme 'doom-one t t)  ;; 加载深色主题
(setq doom-theme 'doom-one)  ;; 加载深色主题

;; ============================
;; Org-mode 配置
;; ============================
(setq org-directory "~/org/")

(after! org
  ;; TODO 状态
  (setq org-todo-keywords '((sequence "TODO" "DOING" "DONE")))

  ;; Agenda 设置
  (setq org-agenda-files '("~/org/src/"
                           "~/org/notes.org"
                           "~/org/Work-Atom.org"
                           "~/org/src/calendar-events.org"))  ;; 添加农历节日文件
  (setq org-agenda-span 'month)  ;; 设置 agenda 默认显示范围为一个月
  ;; 农历节日和生日配置
  (setq calendar-chinese-celestial-stem ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
  (setq calendar-chinese-terrestrial-branch ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

  ;; Capture 模板
  (setq org-capture-templates nil)
  (add-to-list 'org-capture-templates
               '("t" "Personal todo" entry
                 (file+olp "~/org/notes.org" "todolist")
                 "* TODO %^{待办事项} \n %u"))
  (add-to-list 'org-capture-templates
               '("n" "Personal Notes" entry
                 (file+olp "~/org/notes.org" "inbox")
                 "* %^{heading} %t\n %?\n"))
  (add-to-list 'org-capture-templates
               '("d" "Diary" entry
                 (file "~/org/diary.org.gpg")
                 "* %<%Y>年%<%m>月%<%d>日 \n %^{日记内容}"))
  (add-to-list 'org-capture-templates '("w" "work"))
  (add-to-list 'org-capture-templates
               '("wn" "Work Notes" entry
                 (file+olp "~/org/work-Atom.org" "inbox")
                 "* %^{heading} %t\n %?\n"))
  (add-to-list 'org-capture-templates
               '("wt" "Work todo" entry
                 (file+olp "~/org/work-Atom.org" "todolist")
                 "* TODO %^{待办事项} \n %u"))
  ;; 添加农历生日捕获模板
  (add-to-list 'org-capture-templates
               '("b" "Chinese Birthday" entry
                 (file+headline "~/org/src/calendar-events.org" "农历生日")
                 "** %^{姓名}生日\n<%%(diary-chinese-date %^{农历月} %^{农历日})>"))

  ;; 日志设置
  (setq org-log-done t
        org-log-into-drawer t))

;; ============================
;; Org-download 配置
;; ============================
(after! org-download
  (setq org-download-method 'directory
        org-download-heading-lvl nil       ;; 不根据标题创建子文件夹
        org-download-image-dir ".images"   ;; 图片统一保存到 .images
        org-image-actual-width 600
        org-download-link-format "[[file:%s]]\n"
        org-download-abbreviate-filename-function #'file-relative-name
        org-download-link-format-function #'org-download-link-format-function-default)

  ;; 截图命令（Windows）
  (setq org-download-screenshot-method "snippingtool /clip")

  ;; 快捷键绑定
  (map! :leader
        :desc "Org download image from clipboard" "d y" #'org-download-yank
        :desc "Org download screenshot" "d s" #'org-download-screenshot))

;; 归档已完成任务
;; (defun org-archive-done-tasks ()
;;   (interactive)
;;   (org-map-entries
;;    (lambda ()
;;      (org-archive-subtree)
;;      (setq org-map-continue-from (outline-previous-heading)))
;;    "/DONE" 'agenda))
(defun org-archive-done-tasks ()
  (interactive)
  (let ((org-archive-location (concat "~/org/archive/%s_archive.org::* Archived Tasks")))
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (outline-previous-heading)))
     "/DONE" 'agenda)))

;; Calendar 设置
(setq calendar-week-start-day 1)

;; ============================
;; 系统 & 窗口设置
;; ============================
(setq confirm-kill-emacs nil
      system-time-locale "C")

(save-place-mode 1)

(setq initial-frame-alist '((top . 45)
                            (left . 1200)
                            (width . 150)
                            (height . 45)))

(setq frame-title-format "Sean")

;; ============================
;; 快捷键 &编辑体验
;; ============================
(map!
 "<f1>" #'+doom-dashboard/open
 :leader "x" #'org-capture)

(setq shift-select-mode t)

;; ============================
;; Projectile 中文文件名修复
;; ============================
(after! projectile
  (defun projectile-files-via-ext-command@decode-utf-8 (root command)
    "Advice override `projectile-files-via-ext-command' to decode shell output."
    (when (stringp command)
      (let ((default-directory root))
        (with-temp-buffer
          (shell-command command t "*projectile-files-errors*")
          (decode-coding-region (point-min) (point-max) 'utf-8)
          (let ((shell-output (buffer-substring (point-min) (point-max))))
            (split-string (string-trim shell-output) "\0" t))))))
  (advice-add 'projectile-files-via-ext-command
              :override 'projectile-files-via-ext-command@decode-utf-8))

;; ============================
;; 自动保存 & 备份
;; ============================
(setq auto-save-default t
      make-backup-files t)

;; ============================
;; Windows Explorer 打开当前文件目录
;; ============================
(defun open-current-file-in-explorer ()
  "用 Windows Explorer 打开当前文件所在目录，并选中该文件。"
  (interactive)
  (let ((file (buffer-file-name)))
    (when file
      (w32-shell-execute "open" "explorer.exe"
                          (concat "/select," (replace-regexp-in-string "/" "\\" file t t))))))

(map! :leader
      :desc "Open current file in Explorer" "f e" #'open-current-file-in-explorer)

;; ============================
;; Package 源
;; ============================
(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))


;; 设置默认加密密钥（使用你生成GPG密钥时用的邮箱）
;; (setq epa-file-encrypt-to "yuanxiang424@email.com")
(setq epa-file-encrypt-to "yuanxiang424@gmail.com"
      epa-file-cache-passphrase-for-symmetric-encryption t)

;; 可选：设置加密算法（推荐aes256）
;; (setq epa-encrypt-algorithm 'aes256)

;; 可选：设置缓存密码时间（秒）
;; (setq epa-file-cache-passphrase-for-symmetric-encryption 3600)



;; Treemacs配置
(map! :leader
      "0" #'treemacs-select-window
      "f t" #'treemacs)
