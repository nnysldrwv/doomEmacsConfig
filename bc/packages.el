;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; 快速跳转到任意位置, 通过汉字拼音的方式
(package! ace-pinyin
  :recipe (:host github :repo "cute-jumper/ace-pinyin"))

;; 好用的翻译包
(package! osx-dictionary)

;; 高亮当前段落, Dim 其它区域, 保持Focus!
(package! focus)

(package! gptel)

(package! imenu-list)

(package! olivetti)

;; 鼠标放到加粗字符上, 可编辑修饰符, 离开即显示加粗后的效果
(package! org-appear
  :recipe (:host github :repo "awth13/org-appear"))

;; 在Orgmode 文件中插入图片
(package! org-download)

(package! org-imenu
  :recipe (:host github :repo "rougier/org-imenu"))

;; 一个快速查询org 文件相关内容的 query language
(package! org-ql)

(package! org-roam-ui)

;; 文件间引用的插件
(package! org-transclusion)

;; 便捷插入网页到org 文件
(package! org-web-tools)

;; 中英文字符之间自动插入空格, 增加可阅读性
(package! pangu-spacing)

;; 每个标识符显示一个颜色, 花里胡哨的开始
(package! rainbow-identifiers)

;; 在Emacs 中使用rime, 减少切换中英文状态
(package! rime)

(package! telega
  :recipe (:host github :repo "zevlg/telega.el"))

;; 在orgmode 文件中进行计算器式的操作
(package! literate-calc-mode)

;; 完美解决中英文字符在表格中对齐的问题
(package! valign)
