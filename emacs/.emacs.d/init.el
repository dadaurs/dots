;;(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;;(add-to-list 'load-path "<path where use-package is installed>")
  ;;(require 'use-package))

(defun load-config()
  (interactive)
  (org-babel-load-file "~/.emacs.d/config.org"))
  (load-config)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d1af5ef9b24d25f50f00d455bd51c1d586ede1949c5d2863bef763c60ddf703a" "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" default))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(latex-math-preview projectile org-superstar org-bullets ivy-posframe smex ivy-rich doom-modeline page-break-lines org-dashboard dashboard general ibuffer-git which-key wallpaper vterm use-package unicode-emoticons treemacs-evil rg ranger pkg-info peep-dired pdf-tools org-magit org-evil openwith oceanic-theme lsp-java latex-preview-pane key-chord jupyter helm-core haskell-mode haskell-emacs eyebrowse ewal-spacemacs-themes ewal-doom-themes evil-terminal-cursor-changer evil-org evil-nerd-commenter evil-mu4e evil-magit evil-leader elpy ein eclim dired-ranger counsel base16-theme atom-one-dark-theme all-the-icons))
 '(tetris-x-colors
   [[229 192 123]
    [97 175 239]
    [209 154 102]
    [224 108 117]
    [152 195 121]
    [198 120 221]
    [86 182 194]]))

;;(custom-set-faces)


 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(default ((((class color) (min-colors 89)) (:foreground "#494B53" :background "#FAFAFA")))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(default ((((class color) (min-colors 89)) (:foreground "#494B53" :background "#FAFAFA")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
