;; This file lives in the dotfiles repo and is loaded via a one-line stub in
;; ~/.emacs. Keep Customize output out of it: write it to a per-machine
;; custom.el in user-emacs-directory instead (loaded at the end of this file).
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Auto restore last desktop
(desktop-save-mode 1)

;; If the desktop lock file is stale (owning PID is dead, e.g. after a
;; reboot or crash), load the desktop anyway instead of prompting.
(setq desktop-load-locked-desktop 'check-pid)

;; If Microsoft Windows
(cond
 ((string-equal system-type "windows-nt")
  (progn
    (message "Microsoft Windows detected")
  )
 )
 
 ((string-equal system-type "darwin") ;  macOS
  (progn
    (message "Mac OS X detected")))
 ((string-equal system-type "gnu/linux")
  (progn
    (message "Linux detected"))))


;; Open ibuffer instead of buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes '(light-blue))
 '(package-selected-packages '(frame-tabs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)

(load custom-file 'noerror)
