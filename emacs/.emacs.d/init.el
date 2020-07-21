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
   (quote
    ("08e0ba7881c93bc4ecb393df5de4c696ee820d586872ab5d42bb26834c9770eb" "cfd51857f5e80eddece7eb5d30b9afce81f442707207e0d636250d03978a66ec" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "d1af5ef9b24d25f50f00d455bd51c1d586ede1949c5d2863bef763c60ddf703a" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "8b70211fb375c396ebba233a4d3ec90c54b3cad2dd1c26d43c008b442d1a1cf7" "332e009a832c4d18d92b3a9440671873187ca5b73c2a42fbd4fc67ecf0379b8c" "2035a16494e06636134de6d572ec47c30e26c3447eafeb6d3a9e8aee73732396" "3a9f65e0004068ecf4cf31f4e68ba49af56993c20258f3a49e06638c825fbfb6" "e5dc5b39fecbeeb027c13e8bfbf57a865be6e0ed703ac1ffa96476b62d1fae84" "043c8375cad0cf1d5c42f5d85cbed601075caf09594da04a74712510e9437d2b" "c8f959fb1ea32ddfc0f50db85fea2e7d86b72bb4d106803018be1c3566fd6c72" "d75383f8507ebbd38c8dd8ff28e4684fcd05d61467f81bc0407a12c9b2350f16" "ad16a1bf1fd86bfbedae4b32c269b19f8d20d416bd52a87cd50e355bf13c2f23" "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" "7f9dc0c7bc8e5b4a1b9904359ee449cac91fd89dde6aca7a45e4ed2e4985664c" "4ce13ab8b7a8b44ed912a74312b252b0a3ad79b0da6b1034c0145b1fcfd206cb" "947190b4f17f78c39b0ab1ea95b1e6097cc9202d55c73a702395fc817f899393" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "f061b6bdcf3e9d82dad9fd79458125b3c477d399e87d2027083b7e3ecd6f4dad" "f589e634c9ff738341823a5a58fc200341b440611aaa8e0189df85b44533692b" "d6c5b8dc6049f2e9dabdfcafa9ef2079352640e80dffe3e6cc07c0f89cbf9748" "10a31b6c251640d04b2fa74bd2c05aaaee915cbca6501bcc82820cdc177f5a93" "70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "f951343d4bbe5a90dba0f058de8317ca58a6822faa65d8463b0e751a07ec887c" "071f5702a5445970105be9456a48423a87b8b9cfa4b1f76d15699b29123fb7d8" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "d6f04b6c269500d8a38f3fabadc1caa3c8fdf46e7e63ee15605af75a09d5441e" "e7666261f46e2f4f42fd1f9aa1875bdb81d17cc7a121533cad3e0d724f12faf2" "1728dfd9560bff76a7dc6c3f61e9f4d3e6ef9d017a83a841c117bd9bebe18613" "f2b83b9388b1a57f6286153130ee704243870d40ae9ec931d0a1798a5a916e76" "b462d00de785490a0b6861807a360f5c1e05b48a159a99786145de7e3cce3afe" "2a3ffb7775b2fe3643b179f2046493891b0d1153e57ec74bbe69580b951699ca" "a2286409934b11f2f3b7d89b1eaebb965fd63bc1e0be1c159c02e396afb893c8" "c9f102cf31165896631747fd20a0ca0b9c64ecae019ce5c2786713a5b7d6315e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "428754d8f3ed6449c1078ed5b4335f4949dc2ad54ed9de43c56ea9b803375c23" "8150ded55351553f9d143c58338ebbc582611adc8a51946ca467bd6fa35a1075" "b583823b9ee1573074e7cbfd63623fe844030d911e9279a7c8a5d16de7df0ed0" "0dd2666921bd4c651c7f8a724b3416e95228a13fca1aa27dc0022f4e023bf197" "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" "8d805143f2c71cfad5207155234089729bb742a1cb67b7f60357fdd952044315" "0e8bac1e87493f6954faf5a62e1356ec9365bd5c33398af3e83cfdf662ad955f" "b73a23e836b3122637563ad37ae8c7533121c2ac2c8f7c87b381dd7322714cd0" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" "f357d72451c46d51219c3afd21bb397a33cb059e21db1f4adeffe5b8a9093537" "e8ebf4fb99b76dad3b7ec2313d5d091c1f3a3e0e4f9d55d3a58d73a8d3387358" default)))
 '(elfeed-feeds
   (quote
    ("https://memento.epfl.ch/feeds/rss/?memento=sti&lang=en&period=upcoming&category=CONF" "https://japorized.ink/feed.xml" "https://castel.dev/rss.xml" "https://terrytao.wordpress.com/feed/")))
 '(jdee-compiler (quote ("javac")))
 '(package-selected-packages
   (quote
    (which-key evil-terminal-cursor-changer org-magit haskell-emacs projectile multi-vterm vterm oceanic-theme atom-one-dark-theme helm-unicode unicode-emoticons ewal-doom-themes ewal-evil-cursors ewal-spacemacs-themes helm-fuzzier elfeed mu4e-overview helm-company flymake-shell emamux workspaces w3m ujelly-theme mu4e-query-fragments dired-ranger peep-dired xresources-theme ewal evil-mu4e smooth-scrolling jbeans-theme theme-changer challenger-deep-theme evil-org org-evil ripgrep discord openwith ivy-posframe perspective tabbar-ruler eyebrowse org-pdfview nordless-theme northcode-theme ranger writeroom-mode mpdel org-ac org-agenda-property org-alert org-analyzer org-cliplink spacemacs-theme cdlatex vimrc-mode lsp-ui use-package lsp-java jdee eclim elpy neotree evil-collection treemacs doom-modeline tron-theme zenburn-theme evil-leader all-the-icons-gnus all-the-icons-ivy all-the-icons centaur-tabs rg org-starter-swiper counsel ivy evil-numbers alsamixer org-babel-eval-in-repl helm-fuzzy helm-fuzzy-find smart-mode-line-atom-one-dark-theme telephone-line smart-mode-line-powerline-theme exwm powerline-evil color-theme-solarized grayscale-theme gruvbox-theme htmlize org-bullets org-pretty-tags xelb tabbar spacegray-theme solarized-theme snazzy-theme pdf-tools one-themes nord-theme night-owl-theme material-theme key-chord ido-grid-mode helm haskell-mode fzf evil-tabs evil-surround evil-nerd-commenter evil-magit evil-commentary dracula-theme doom-themes doom dashboard circe annalist)))
 '(send-mail-function (quote mailclient-send-it)))

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
