;;; init.el -*- lexical-binding: t; -*-

(doom!
       :completion
       (ivy
        +icons
        +prescient)       ; a search engine for love and life

       :ui
       doom               ; what makes DOOM look the way it does
       modeline
       hl-todo            ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       (ligatures +extra)
       ophints            ; highlight the region an operation acts on
       (popup
        +all
        +defaults)        ; tame sudden yet inevitable temporary windows
       unicode
       ;;zen                ; distraction-free coding or writing

       :editor
       ;(evil +everywhere) ; come to the dark side, we have cookies
       file-templates     ; auto-snippets for empty files
       fold               ; (nigh) universal code folding
       (format +onsave)   ; automated prettiness
       snippets           ; my elves. They type so I don't have to
       word-wrap

       :emacs
       ;; electric           ; smarter, keyword-based electric-indent
       (ibuffer +icons)   ; interactive buffer management
       undo               ; persistent, smarter undo for your inevitable mistakes

       :checkers
       syntax             ; tasing you for every semicolon you forget

       :tools
       (eval +overlay)    ; run code, run (also, repls)
       lookup             ; navigate your code and its documentation
       magit              ; a git porcelain for Emacs
       pdf                ; pdf enhancements
       rgb                ; creating color strings

       :os
       (:if IS-MAC macos) ; improve compatibility with macOS

       :lang
       emacs-lisp         ; drown in parentheses
       latex              ; writing papers in Emacs has never been so fun
       markdown

       (org               ; organize your plain life in plain text
        +roam2
        +dragndrop
        +gnuplot
        +hugo
        +pandoc
        +pretty
        +present)

       plantuml           ; diagrams for confusing people more
       rest               ; for use restclient
       sh                 ; she sells {ba,z,fi}sh shells on the C xor
       yaml               ; JSON, but readable

       :email
       (mu4e +org)

       :app
       ;; calendar
       (rss +org)         ; emacs as an RSS reader

       :config
       (default +bindings +smartparens))
