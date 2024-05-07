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
(setq org-roam-directory "~/org/roam/")


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

;;font
  ;(setq doom-font (font-spec :family "LXGW Neo Xihei" :size 24))
  ;
;;font 抄自centaur
;;
(defun font-installed-p (font-name)
  (find-font (font-spec :name font-name)))
;;
(defun centaur-setup-fonts ()
  "Setup fonts."
  (when (display-graphic-p)
   ;; Set default font
   (cl-loop for font in '("Cascadia Code" "Fira Code" "Jetbrains Mono"
    "SF Mono" "Hack" "Source Code Pro" "Menlo"
    "Monaco" "DejaVu Sans Mono" "Consolas")
    when (font-installed-p font)
    return (set-face-attribute 'default nil
       :family font
       :height 120))

   ;; Set mode-line font
   ;; (cl-loop for font in '("Menlo" "SF Pro Display" "Helvetica")
   ;;          when (font-installed-p font)
   ;;          return (progn
   ;;                   (set-face-attribute 'mode-line nil :family font :height 120)
   ;;                   (when (facep 'mode-line-active)
   ;;                     (set-face-attribute 'mode-line-active nil :family font :height 120))
   ;;                   (set-face-attribute 'mode-line-inactive nil :family font :height 120)))

   ;; Specify font for all unicode characters
   (cl-loop for font in '("Segoe UI Symbol" "Symbola" "Symbol")
      when (font-installed-p font)
      return (if (< emacs-major-version 27)
        (set-fontset-font "fontset-default" 'unicode font nil 'prepend)
      (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend)))

   ;; Emoji
   (cl-loop for font in '("Noto Color Emoji" "Apple Color Emoji" "Segoe UI Emoji")
      when (font-installed-p font)
      return (cond
        ((< emacs-major-version 27)
     (set-fontset-font "fontset-default" 'unicode font nil 'prepend))
        ((< emacs-major-version 28)
     (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend))
        (t
     (set-fontset-font t 'emoji (font-spec :family font) nil 'prepend))))

   ;; Specify font for Chinese characters
   (cl-loop for font in '("LXGW Neo Xihei" "WenQuanYi Micro Hei Mono" "LXGW WenKai Screen"
              "LXGW WenKai Mono" "PingFang SC" "Microsoft Yahei UI" "Simhei")
      when (font-installed-p font)
      return (progn
      (setq face-font-rescale-alist `((,font . 1.3)))
      (set-fontset-font t 'han (font-spec :family font))))))

(centaur-setup-fonts)
(add-hook 'window-setup-hook #'centaur-setup-fonts)
(add-hook 'server-after-make-frame-hook #'centaur-setup-fonts)



;;光标改为竖线，不闪烁
(setq-default cursor-type '(bar . 3))
;(setq blink-cursor-mode nil)


;;开启server mode
(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory; ~/.emacs.d/server is unsafe" on windows.
(server-start)
