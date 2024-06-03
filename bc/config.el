;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; 通过Emacs-china 的仓库来安装包, 提升安装速度
(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; 个人信息
(setq user-full-name "Sean Yuan"
      user-mail-address "yuan_xiang@outlook.com")

;; 通过iCloud 自动同步Documents 目录, 多台电脑可以无缝迁移使用
(setq org-directory "~/org/")

(setq confirm-kill-emacs nil ; 关闭 emacs 时无需额外确认
      system-time-locale "C" ; 设置系统时间显示方式
      pop-up-windows nil     ; no pop-up window
      scroll-margin 2        ; It's nice to maintain a little margin
      widget-image-enable nil
      visible-bell nil
      ring-bell-function 'ignore)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; 全局打开visual line
(global-visual-line-mode)

(setq word-wrap-by-category t)

(add-hook 'org-mode-hook 'adaptive-wrap-prefix-mode)

;; 查帮助文档时, 显示使用Demos
(advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update)

;; 打开文件时, 光标自动定位到上次停留的位置
(save-place-mode 1)

(global-auto-revert-mode)

(setq display-line-numbers-type nil)

;; 关闭Doom rss 切割图片的功能, 展示完整图片吧
(setq +rss-enable-sliced-images nil)

(blink-cursor-mode 0)
(show-paren-mode t)
(fringe-mode '(0 . 0)) ;; No fringe

;; 指定启动时的窗口位置和大小
(setq initial-frame-alist '((top . 45)
                             (left . 1200)
                             (width . 100)
                             (height . 45)))

(setq frame-title-format "Sean")
(menu-bar-mode -1) ;; minimal chrome
(tool-bar-mode -1) ;; no toolbar
(scroll-bar-mode -1) ;; disable scroll bars

(setq initial-major-mode 'org-mode) ;; org!
(setq initial-scratch-message nil)

;; 新打开窗口时, 提示要打开哪个Buffer
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

(setq +ivy-buffer-preview t)

(setq-default x-stretch-cursor t ;; Stretch cursor to the glyph width
              line-spacing 0.25
              fill-column 80
              x-underline-at-descent-line t)

;; Smooth mouse scrolling
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))  ; scroll two lines at a time
      mouse-wheel-progressive-speed nil             ; don't accelerate scrolling
      mouse-wheel-follow-mouse t                    ; scroll window under mouse
      scroll-step 1)

;; for night
(setq doom-theme 'doom-zenburn)

;; another awesome night theme
;; (setq doom-theme 'doom-monokai-spectrum)
;; for day
;; (setq doom-theme 'doom-flatwhite)

;; Doom 自带的字体变量配置

;; Plan A: 中文苹方, 英文Roboto Mono
;; (setq doom-font (font-spec :family "Roboto Mono" :size 22)
;;       doom-serif-font doom-font
;;       doom-symbol-font (font-spec :family "PingFang SC")
;;       doom-variable-pitch-font (font-spec :family "PingFang SC" :weight 'extra-bold))

;; Plan B: 中文苹方, 英文Zpix 像素风格
;; (setq doom-font (font-spec :family "Zpix" :size 22)
;;       doom-serif-font doom-font
;;       doom-symbol-font (font-spec :family "PingFang SC")
;;       doom-variable-pitch-font (font-spec :family "PingFang SC" :weight 'extra-bold))

;; Plan C: 中英文仓耳今楷
(setq doom-font (font-spec :family "TsangerJinKai03 W03" :size 24)
      doom-serif-font doom-font
      doom-symbol-font (font-spec :family "TsangerJinKai03 W03")
      doom-variable-pitch-font (font-spec :family "TsangerJinKai03 W03"))

;; 如果不把这玩意设置为 nil, 会默认去用 fontset-default 来展示, 配置无效
(setq use-default-font-for-symbols nil)
;; Doom 的字体加载顺序问题, 如果不设定这个 hook, 配置会被覆盖失效
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'symbol (font-spec :family "Symbola"))
  (set-fontset-font t 'mathematical (font-spec :family "Symbola"))
  (set-fontset-font t 'emoji (font-spec :family "Symbola")))

;; Macbook 安装路径
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2022/bin/universal-darwin"))
(setq exec-path (append exec-path '("/usr/local/texlive/2022/bin/universal-darwin")))

;; 家里iMac 安装路径
;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2019/bin/x86_64-darwin/"))
;; (setq exec-path (append exec-path '("/usr/local/texlive/2019/bin/x86_64-darwin/")))

(setq org-highlight-latex-and-related '(native script entities))

(pdf-loader-install)

(setq Tex-command-default "XeLaTeX")
(setq org-latex-pdf-process
      '(
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "rm -fr %b.out %b.log %b.tex auto"))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("ctexart" "\\documentclass[11pt,titlepage]{ctexart}

% Document title
\\usepackage{titling}

% Page Margins: important
% https://ctan.math.illinois.edu/macros/latex/contrib/geometry/geometry.pdf
% \\usepackage[scale=0.8,centering]{geometry}
\\usepackage{geometry}
\\geometry{
    a4paper,% 210 * 297mm
    hcentering,% 将hmarginratio设为1:1，即left=right
    left=28mm,% 注意left=right
    top=37.00mm,% Word 模板页眉顶端距离20mm
    width=156mm,
    height=225mm,
    }

% Page head and foot
% lhead/chead/rhead
% lfoot/cfoot/rfoot
\\usepackage{lastpage}

\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\chead{\\textsc{\\title}}
\\rhead{\\textit{Last modified: \\today}}
\\rfoot{}
\\cfoot{\\color{gray} \\textsc{\\thepage~/~\\pageref*{LastPage}}}
\\lfoot{}
\\renewcommand\\headrulewidth{0.6pt}
\\renewcommand\\footrulewidth{0.6pt}

\\usepackage[most]{tcolorbox}
\\usepackage[colorinlistoftodos]{todonotes}
\\usepackage{tikz-bagua}

% xcolor is more powerful than color
% \\color{red!70}  %70 percent red color
% \\textcolor{red}
% \\colorbox{gray}
\\usepackage[RGB,dvipsnames,svgnames]{xcolor}
% colortble is for org-table
% \\rowclor{gray}
\\usepackage{colortbl}

% 定义新的颜色
\\definecolor{mycolor}{RGB}{200,198,196}

%% Highlighted remarks/notes
% Highlighted remark/note with and without title
\\newenvironment{Highlight}[1]
{
        \\ifthenelse{\\equal{#1}{}}{
                \\begin{tcolorbox}[breakable, enhanced, colback=white!55!white,colframe=mycolor!45!black]
                \\setlength\\parskip{0.2cm}
        }
        {
                \\begin{tcolorbox}[breakable, enhanced, colback=white!55!white,colframe=mycolor!45!black, fonttitle=\\bfseries, title=#1]
                \\setlength\\parskip{0.2cm}
        }
}
{
        \\end{tcolorbox}
}
\\newtcolorbox{tip}{colback=blue!5!white,colframe=blue!75!black}
\\newtcolorbox{tipt}[1]{colback=blue!5!white,colframe=blue!75!black,fonttitle=\\bfseries,title=#1}

% Format of section and subsection headers
% [rm sf tt bf up it sl sc]
% Select the corresponding family/series/shape. Default is bf.
\\usepackage{titlesec}

% for use notin math symbol
\\usepackage{unicode-math}

% 使用UTF-8编码输入文字
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}

% Hyperlinks and bookmarks
\\usepackage{hyperref}
\\hypersetup{colorlinks=true,linkcolor=blue}

% Include graphics
\\usepackage{graphicx}

\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}

% List items
\\usepackage{enumerate}
%% \\usepackage{enumitem}

% Line spread
\\usepackage{parskip}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "ctexart")
  (setq org-latex-compiler "xelatex"))

(after! org
  (setq org-archive-location (concat org-directory "roam/archive.org::")
        org-log-done t
        org-use-property-inheritance t
        org-confirm-babel-evaluate nil
        org-list-allow-alphabetical t
        org-export-with-sub-superscripts nil
        org-export-headline-levels 5
        org-export-use-babel t
        org-use-speed-commands t
        org-return-follows-link t
        org-hide-emphasis-markers t
        org-special-ctrl-a/e t
        org-special-ctrl-k t
        org-src-preserve-indentation nil
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-export-in-background nil
        org-fontify-quote-and-verse-blocks t
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fold-catch-invisible-edits 'smart)

  (setq org-ellipsis " ▾ "
        org-hide-leading-stars t
        org-priority-highest ?A
        org-priority-lowest ?E
        org-priority-faces
        '((?A . 'all-the-icons-red)
          (?B . 'all-the-icons-orange)
          (?C . 'all-the-icons-yellow)
          (?D . 'all-the-icons-green)
          (?E . 'all-the-icons-blue)))

  (setq org-todo-keywords
        '((sequence "TODO" "WORK" "|" "DONE")))

  (setq org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))

  (setq org-tag-alist '(("@工作" . ?w) ("@生活" . ?l) ("@学习" . ?s)))

  ;; Coding system for HTML export.
  (setq org-html-coding-system 'utf-8)
  (setq org-html-doctype "html5")
  (setq org-html-head
        "<link rel='stylesheet' type='text/css' href='https://gongzhitaao.org/orgcss/org.css'/> ")

  (after! org-superstar
    ;; other symbols like: 🦄  🐻 "🙘" "🙙" "🙚" "🙛" "☯" "☷" "☲" "☵"
    (setq org-superstar-headline-bullets-list '("🙘" "🙙" "🙚" "🙛")
          org-superstar-special-todo-items t
          org-superstar-item-bullet-alist '((?- . ?•) (?* . ?–) (?+ . ?◦))
          org-superstar-prettify-item-bullets t ))

  (add-hook! 'org-babel-after-execute-hook 'org-display-inline-images 'append)
  (add-hook! 'org-babel-after-execute-hook 'org-toggle-latex-fragment 'append)
  (add-hook! 'org-mode-hook #'+org-pretty-mode))


  ;; 任何.org 后缀的文件, 均以orgmode 打开
  (setq auto-mode-alist (append '(("\\.org$" . org-mode)) auto-mode-alist))

(after! org
  ;; FIXME
  (setq org-agenda-files (directory-files-recursively (concat org-directory "roam") "\\.org$"))
  (setq org-agenda-diary-file (concat org-directory "private/standard-diary"))
  (setq diary-file (concat org-directory "private/standard-diary"))

  (setq org-agenda-deadline-faces
        '((1.001 . error)
          (1.0 . org-warning)
          (0.5 . org-upcoming-deadline)
          (0.0 . org-upcoming-distant-deadline)))

  (setq org-agenda-prefix-format '((agenda . "%t %s ")
                                   (todo   . " ")))

  (setq org-agenda-clockreport-parameter-plist
        '(:link t :maxlevel 6 :fileskip0 t :compact t :narrow 60 :score 0))

  (setq org-agenda-hide-tags-regexp ".")

  (setq org-agenda-span 7
        org-agenda-start-on-weekday 1
        org-agenda-log-mode-items '(clock)
        org-agenda-include-all-todo t
        org-agenda-time-leading-zero t
        org-agenda-use-time-grid nil
        calendar-holidays nil
        org-agenda-include-diary t))

(after! org
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (setq org-plantuml-jar-path (expand-file-name "~/org/private/plantuml.jar"))
  (setq plantuml-default-exec-mode 'jar)
  (setq org-hide-block-startup t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (plantuml . t)
     (gnuplot . t))))

(setq-default prettify-symbols-alist '(("#+title:" . "✍")
                                       ("#+author:" . "👨")
                                       ("#+caption:" . "☰")
                                       ("#+results:" . "🎁")
                                       ("#+attr_latex:" . "🍄")
                                       ("#+attr_org:" . "🔔")
                                       ("#+date:" . "⚓")
                                       ("#+property:" . "☸")
                                       (":PROPERTIES:" . "⚙")
                                       (":END:" . ".")
                                       ("[ ]" . "☐")
                                       ("[X]" . "☑︎")
                                       ("#+options:" . "⌥")
                                       ("\\pagebreak" . 128204)
                                       ("#+begin_quote" . "❮")
                                       ("#+end_quote" . "❯")
                                       ("#+BEGIN_Highlight" . "📖")
                                       ("#+END_Highlight" . "📜")
                                       ("#+begin_src" . "⏩")
                                       ("#+end_src" . "⏪")))


(add-hook! 'org-mode-hook 'prettify-symbols-mode)

(defun org-mode-remove-stars ()
  ;; 关掉 Headline 前面的 * 符号显示
  (font-lock-add-keywords
   nil
   '(("^\\*+ "
      (0
       (prog1 nil
         (put-text-property (match-beginning 0) (match-end 0)
                            'invisible t)))))))

(add-hook! 'org-mode-hook #'org-mode-remove-stars)

(after! org
  (custom-set-faces!
    '(outline-1 :weight extra-bold :height 1.25)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold))

  (custom-set-faces
   '(region ((t (:foreground "green" :background "#464646")))))

  (custom-set-faces!
    '(org-document-title :height 1.2)))

;; 关闭indent
(after! org
  (custom-set-variables
   '(org-startup-indented nil)))

(after! org
  ;; @Eli 帮忙写的解决标记符号前后空格问题的代码, 感谢.
  (setq org-emphasis-regexp-components '("-[:space:]('\"{[:nonascii:]"
                                         "-[:space:].,:!?;'\")}\\[[:nonascii:]"
                                         "[:space:]"
                                         "."
                                         1))
  (setq org-match-substring-regexp
        (concat
         ;; 限制上标和下标的匹配范围，org 中对其的介绍见：(org) Subscripts and superscripts
         "\\([0-9a-zA-Zα-γΑ-Ω]\\)\\([_^]\\)\\("
         "\\(?:" (org-create-multibrace-regexp "{" "}" org-match-sexp-depth) "\\)"
         "\\|"
         "\\(?:" (org-create-multibrace-regexp "(" ")" org-match-sexp-depth) "\\)"
         "\\|"
         "\\(?:\\*\\|[+-]?[[:alnum:].,\\]*[[:alnum:]]\\)\\)"))
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-element-update-syntax)
  )

(after! org
  ;; 标记字符前后空格优化问题
  (defun eli/org-do-emphasis-faces (limit)
    "Run through the buffer and emphasize strings."
    (let ((quick-re (format "\\([%s]\\|^\\)\\([~=*/_+]\\)"
                            (car org-emphasis-regexp-components))))
      (catch :exit
        (while (re-search-forward quick-re limit t)
          (let* ((marker (match-string 2))
                 (verbatim? (member marker '("~" "="))))
            (when (save-excursion
                    (goto-char (match-beginning 0))
                    (and
                     ;; Do not match if preceded by org-emphasis
                     (not (save-excursion
                            (forward-char 1)
                            (get-pos-property (point) 'org-emphasis)))
                     ;; Do not match in latex fragments.
                     ;; (not (org-inside-LaTeX-fragment-p))
                     ;; Do not match in Drawer.
                     (not (org-match-line
                           "^[    ]*:\\(\\(?:\\w\\|[-_]\\)+\\):[      ]*"))
                     ;; Do not match table hlines.
                     (not (and (equal marker "+")
                               (org-match-line
                                "[ \t]*\\(|[-+]+|?\\|\\+[-+]+\\+\\)[ \t]*$")))
                     ;; Do not match headline stars.  Do not consider
                     ;; stars of a headline as closing marker for bold
                     ;; markup either.
                     (not (and (equal marker "*")
                               (save-excursion
                                 (forward-char)
                                 (skip-chars-backward "*")
                                 (looking-at-p org-outline-regexp-bol))))
                     ;; Match full emphasis markup regexp.
                     (looking-at (if verbatim? org-verbatim-re org-emph-re))
                     ;; Do not span over paragraph boundaries.
                     (not (string-match-p org-element-paragraph-separate
                                          (match-string 2)))
                     ;; Do not span over cells in table rows.
                     (not (and (save-match-data (org-match-line "[ \t]*|"))
                               (string-match-p "|" (match-string 4))))))
              (pcase-let ((`(,_ ,face ,_) (assoc marker org-emphasis-alist))
                          (m (if org-hide-emphasis-markers 4 2)))
                (font-lock-prepend-text-property
                 (match-beginning m) (match-end m) 'face face)
                (when verbatim?
                  (org-remove-flyspell-overlays-in
                   (match-beginning 0) (match-end 0))
                  (when (and (org-fold-core-folding-spec-p 'org-link)
                             (org-fold-core-folding-spec-p 'org-link-description))
                    (org-fold-region (match-beginning 0) (match-end 0) nil 'org-link)
                    (org-fold-region (match-beginning 0) (match-end 0) nil 'org-link-description))
                  (remove-text-properties (match-beginning 2) (match-end 2)
                                          '(display t invisible t intangible t)))
                (add-text-properties (match-beginning 2) (match-end 2)
                                     '(font-lock-multiline t org-emphasis t))
                (when (and org-hide-emphasis-markers
                           (not (org-at-comment-p)))
                  (add-text-properties (match-end 4) (match-beginning 5)
                                       '(invisible t))
                  (add-text-properties (match-beginning 3) (match-end 3)
                                       '(invisible t)))
                (throw :exit t))))))))

  (advice-add #'org-do-emphasis-faces :override #'eli/org-do-emphasis-faces)

  (defun eli/org-element--parse-generic-emphasis (mark type)
  "Parse emphasis object at point, if any.

MARK is the delimiter string used.  TYPE is a symbol among
`bold', `code', `italic', `strike-through', `underline', and
`verbatim'.

Assume point is at first MARK."
  (save-excursion
    (let ((origin (point)))
      (unless (bolp) (forward-char -1))
      (let ((opening-re
             (rx-to-string
              `(seq (or line-start (any space ?- ?\( ?' ?\" ?\{ nonascii))
                ,mark
                (not space)))))
        (when (looking-at opening-re)
          (goto-char (1+ origin))
          (let ((closing-re
                 (rx-to-string
                  `(seq
                    (not space)
                    (group ,mark)
                    (or (any space ?- ?. ?, ?\; ?: ?! ?? ?' ?\" ?\) ?\} ?\\ ?\[
                             nonascii)
                        line-end)))))
            (when (re-search-forward closing-re nil t)
              (let ((closing (match-end 1)))
                (goto-char closing)
                (let* ((post-blank (skip-chars-forward " \t"))
                       (contents-begin (1+ origin))
                       (contents-end (1- closing)))
                  (list type
                        (append
                         (list :begin origin
                               :end (point)
                               :post-blank post-blank)
                         (if (memq type '(code verbatim))
                             (list :value
                                   (and (memq type '(code verbatim))
                                        (buffer-substring
                                         contents-begin contents-end)))
                           (list :contents-begin contents-begin
                                 :contents-end contents-end)))))))))))))
(advice-add #'org-element--parse-generic-emphasis :override #'eli/org-element--parse-generic-emphasis)

  )

(after! evil
  (setq evil-ex-substitute-global t     ; I like my s/../.. to by global by default
        evil-move-cursor-back nil       ; Don't move the block cursor when toggling insert mode
        evil-kill-on-visual-paste nil))

(after! ivy
  ;; Causes open buffers and recentf to be combined in ivy-switch-buffer
  (setq ivy-use-virtual-buffers t
        +ivy-project-search-engines '(rg)
        ivy-re-builders-alist '((swiper . ivy--regex-plus) (t . ivy--regex-fuzzy))
        counsel-find-file-at-point t
        ivy-wrap nil
        ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))
        ivy-posframe-height-alist '((t . 20))
        ivy-posframe-parameters '((internal-border-width . 1))
        ivy-posframe-width 100))

(use-package! doom-modeline
  :custom
  (doom-modeline-enable-word-count t)
  (doom-modeline-height 10)
  (doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode text-mode)))

(after! elfeed
  (setq rmh-elfeed-org-files (list (concat org-roam-directory "elfeed.org")))
  (add-hook 'elfeed-search-mode-hook #'elfeed-update)
  (setq elfeed-search-title-max-width 80    ; Maximum titles width
        elfeed-search-title-min-width 40    ; Minimum titles width
        elfeed-search-trailing-width 24     ; Space reserved for feed & tag
        elfeed-curl-extra-arguments '("-xhttp://127.0.0.1:2080")
         ;; elfeed-curl-extra-arguments '("--proxy" "socks5://127.0.0.1:7890"
         ;;                                                "--retry" "3"
         ;;                                                "--insecure"))
        elfeed-curl-timeout 60
        elfeed-search-filter                ; Default filter
        "@1-weeks-ago +unread")

  (defvar elfeed-search-sort-function)
  (defun eli/elfeed-search-filter-source (entry)
    "Filter elfeed search buffer by the feed under cursor."
    (interactive (list (elfeed-search-selected :ignore-region)))
    (when (elfeed-entry-p entry)
      (let ((elfeed-search-sort-function nil))
        (elfeed-search-set-filter
         (concat
          "="
          (replace-regexp-in-string
           (rx "?" (* not-newline) eos)
           ""
           (elfeed-feed-url (elfeed-entry-feed entry))))))))
  )

(after! org-roam
  :config
  (org-roam-db-autosync-mode)

  (setq org-roam-directory (concat org-directory "roam/")
        org-roam-db-location (concat org-directory "roam/org-roam.db")
        +org-roam-open-buffer-on-find-file nil)

  (setq org-roam-capture-templates
        `(("n" "default note" plain "%?"
           :if-new
           (file+head "${slug}.org"
                      "#+title: ${title}\n\n ")
           :unnarrowed t))))

(after! plantuml-mode
  (setq plantuml-jar-path (expand-file-name "~/org/private/plantuml.jar"))
  (setq plantuml-default-exec-mode 'jar))

(use-package! ace-pinyin
  :config
  (ace-pinyin-global-mode +1))

(add-to-list 'load-path "~/.config/emacs/local-packages/blink-search")

(require 'blink-search)
(global-set-key (kbd "C-S-s") 'blink-search)

(use-package! gptel
  :config
  (setq! gptel-model "gpt-4")
  (setq! gptel-api-key "your-api-key")
  (setq! gptel-backend (gptel-make-openai "seven"
                         :protocol "https"
                         :host "api.xiaoyukefu.com"
                         :stream t
                         :key 'gptel-api-key
                         :header (lambda () `(("Authorization" . ,(concat "Bearer " (gptel--get-api-key)))))
                         :models '("gpt-4" "gpt-4-turbo-preview"))))
(global-set-key (kbd "s-l") 'gptel-send)

(defvar eli/gptel-quick-prompts-directory org-roam-directory)

(defun eli/gptel-quick-query (beg end)
  (interactive "r")
  (let* ((prompt (string-split (buffer-substring-no-properties beg end)
                               ":" t " "))
         (gptel--system-message
          (with-temp-buffer
            (org-mode)
            (insert-file-contents
             (file-name-concat eli/gptel-quick-prompts-directory
                               (file-name-with-extension
                                (car prompt) ".org")))
            (goto-char (point-min))
            (org-next-visible-heading 1)
            (let* ((elt (org-element-at-point))
                   (beg (org-element-property :contents-begin elt))
                   (end (org-element-property :contents-end elt)))
              (buffer-substring-no-properties beg end))))
         (user-prompt (cadr prompt)))
    (gptel-request user-prompt :stream t)
    (deactivate-mark)))

(defun eli/gptel-quick-select-prompt ()
  "Select a prompt."
  (interactive)
  (let* ((full-path (read-file-name "Select: " eli/gptel-quick-prompts-directory))
         (filename (file-name-base full-path)))
    (insert filename)))

(global-set-key (kbd "s-d") 'eli/gptel-quick-select-prompt)
(global-set-key (kbd "s-p") 'eli/gptel-quick-query)

(use-package! focus
  :after org-roam
  :config
  (add-to-list 'focus-mode-to-thing '(org-mode . paragraph)))

(use-package! literate-calc-mode)

;;
(use-package! olivetti
  :hook (org-mode . olivetti-mode)
  :config
  ;; 设置文本宽度，默认是 80 列
  (setq olivetti-body-width 80))
;;

;;
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))
;;

(use-package! org-download
  :defer nil
  :custom
  (org-download-image-dir "~//org/roam/images")
  (org-image-actual-width '(400))
  (org-download-heading-lvl nil)
  (org-download-timestamp "")
  :config
  (require 'org-download))

(after! org-download
  (setq org-download-method 'directory)
  (setq org-download-link-format "[[file:images/%s]]\n"))

(use-package! org-roam-ui)

(use-package! org-transclusion
  :after org
  :init
  (map!
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(global-set-key (kbd "C-s-j") 'org-transclusion-add)

;; Easy insertion of weblinks
(use-package! org-web-tools
  :init
  (map!
   :leader
   :prefix "i"
   :desc "insert weblinks" "l" #'org-web-tools-insert-link-for-url))

(use-package! osx-dictionary
  :bind (("C-c d l" . osx-dictionary-search-word-at-point)
         ("C-c d i" . osx-dictionary-search-input)))

(use-package! pangu-spacing
  :config
  (global-pangu-spacing-mode 1)
  ;; 在中英文符号之间, 真正地插入空格
  (setq pangu-spacing-real-insert-separtor t))

(use-package! telega
  :hook
  (telega-chat-mode . (lambda () (font-lock-mode -1)))
  :config
  (setq telega-chat-show-avatars nil)
  (setq telega-avatar-text-compose-chars nil)
  (setq telega-sticker-size '(0 . 0))
  (setq telega-chat-prompt-format "🐴>: ")
  (setq telega-chat-input-markups '("org"))
  (setq telega-use-images t))

(with-eval-after-load 'telega
  (define-key telega-msg-button-map "k" nil))

(use-package! valign
  :config
  (setq valign-fancy-bar t)
  (add-hook 'org-mode-hook #'valign-mode))

(defun dcf (cf0 g r n)
  "calculate dcf value

CF0为初始净利润， g为预计净利润年复合增长率

r 为未来现金流折现率， n为企业未来存活年数"
  (interactive "nCF0: \nng: \nnr: \nnn: ")
  (let* ((g1 (expt (1+ g) n))
         (r1  (expt (1+ r) (- n)))
         (cf1 (* cf0 g1 r1)))
    (/ (- cf0 cf1) (- r g))))

;; 插入今年的时间进度条
(defun make-progress (width percent has-number?)
  (let* ((done (/ percent 100.0))
         (done-width (floor (* width done))))
    (concat
     "["
     (make-string done-width ?/)
     (make-string (- width done-width) ? )
     "]"
     (if has-number? (concat " " (number-to-string percent) "%")))))



(defun insert-day-progress ()
  (interactive)
  (let* ((today (time-to-day-in-year (current-time)))
         (percent (floor (* 100 (/ today 365.0)))))
    (insert (make-progress 30 percent t))
    ))

;; SPC i p to insert day progress
(map! :leader :desc "Insert day progress" "i p" #'insert-day-progress)

(defun org-insert-image ()
  "insert a image from clipboard"
  (interactive)
  (let* ((path (concat default-directory "images/"))
         (fname (read-string "Enter file name: "))
         (image-file (concat path fname)))
    (if (not (file-exists-p path))
        (mkdir path))
    (do-applescript (concat
                     "set the_path to \"" image-file "\" \n"
                     "set png_data to the clipboard as «class PNGf» \n"
                     "set the_file to open for access (POSIX file the_path as string) with write permission \n"
                     "write png_data to the_file \n"
                     "close access the_file"))
    ;; (shell-command (concat "pngpaste " image-file))
    (org-insert-link nil
                     (concat "file:" image-file)
                     "")
    (message image-file))
  (org-display-inline-images)
  )

(map! :leader :desc "Insert image" "i i" #'org-insert-image)

;; Author: @Nasy 学姐
;; Description: 将当前窗口设置为居中.

(defun nasy/frame-recenter (&optional frame)
  "Center FRAME on the screen.
FRAME can be a frame name, a terminal name, or a frame.
If FRAME is omitted or nil, use currently selected frame."
  (interactive)
  (unless (eq 'maximised (frame-parameter nil 'fullscreen))
    (let* ((frame (or (and (boundp 'frame) frame) (selected-frame)))
           (frame-w (frame-pixel-width frame))
           (frame-h (frame-pixel-height frame))
            ;; frame-monitor-workarea returns (x y width height) for the monitor
           (monitor-w (nth 2 (frame-monitor-workarea frame)))
           (monitor-h (nth 3 (frame-monitor-workarea frame)))
           (center (list (/ (- monitor-w frame-w) 2)
                         (/ (- monitor-h frame-h) 2))))
      (apply 'set-frame-position (flatten-list (list frame center))))))
;;

;;
;; Author: @Eli
;; Description: 将 Orgmode 文本复制到其它软件时, 去除硬换行和标记符号
;; 使用时, C-u + 复制 即可
(require 'ox-ascii)

(defun eli/org2plaintxt (string)
  (cl-flet ((drop-markup (_ content _) (identity content)))
    (cl-letf (((symbol-function #'org-ascii-bold) #'drop-markup)
              ((symbol-function #'org-ascii-italic) #'drop-markup)
              ((symbol-function #'org-ascii-strike-through) #'drop-markup)
              ((symbol-function #'org-ascii-underline) #'drop-markup))
      (let ((org-ascii-text-width 999999)
   (org-ascii-bullets nil)
            (org-ascii-underline nil)
            (org-ascii-verbatim-format "%s"))
        (org-export-string-as string 'ascii t)))))

(defun eli/unfill-string (string)
  (if current-prefix-arg
   (thread-last string eli/org2plaintxt)
    string))

(advice-add #'buffer-substring--filter :filter-return #'eli/unfill-string)
;;

(defun insert-bold-hline ()
  "Insert a bold horizontal line in Org-mode."
  (interactive)
  (insert (make-string 18 ?━))
  (insert "\n"))

(global-set-key (kbd "s-h") 'insert-bold-hline)

(defun insert-custom-symbol ()
  "Inserts the custom symbol '▎' at the cursor position."
  (interactive)
  (insert "▎"))

(global-set-key (kbd "C-s-i") 'insert-custom-symbol)

;; 启动时 *Messages* 有 warning: "Package cl is deprecated"

;; - 链接: [[https://github.com/doomemacs/doomemacs/issues/3372][Doom emacs issue #3372]]

;; - 原因:
;;   + Emacs 27 之后的版本废弃了内置库=cl=, 替之以=cl-lib=
;;   + 但有很多第三方包仍在使用=cl=, 所以启动时会有该提示。

;; - 解法: *无解*
;;   - 根本解: 只能等待第三方包升级完成替换修复

;;   - hack way: 在发出报警的函数上做文章, 增加=advice=

(defadvice! fixed-do-after-load-evaluation (abs-file)
  :override #'do-after-load-evaluation
  (dolist (a-l-element after-load-alist)
    (when (and (stringp (car a-l-element))
               (string-match-p (car a-l-element) abs-file))
      (mapc #'funcall (cdr a-l-element))))
  (run-hook-with-args 'after-load-functions abs-file))

(defun convert-markdown-links-to-org ()
  "将 markdown 语法的链接转换成 orgmode 的链接"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\\[\\(.*?\\)\\](\\(.*?\\))" nil t)
    (replace-match "[[\\2][\\1]]")))

(setq doom-localleader-key ",")

(map!
 ;; 众妙之门, 值得分配一个 SPC SPC
 :leader :desc "All in M-x" "SPC" #'counsel-M-x

 "C-h h" 'helpful-at-point
 "C-h f" 'helpful-function
 "C-h v" 'helpful-variable
 "C-h k" 'helpful-key)


(map! :leader
      :desc "open export dispatch" "e" #'org-export-dispatch)

(map! :leader
      (:prefix "o" :desc "open applications"
               "e" #'elfeed
               "t" #'telega))

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

(global-set-key (kbd "s-j") 'avy-goto-word-1)
(global-set-key (kbd "s-o") 'org-roam-node-find)
(global-set-key (kbd "s-i") 'org-roam-node-insert)

(map! :leader
      :prefix ("r" . "org-roam")
      "f" #'org-roam-find-file
      ;; "s" #'org-roam-server-mode
      "i" #'org-roam-insert
      "t" #'org-roam-dailies-goto-today)
