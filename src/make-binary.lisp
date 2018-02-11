;; using this to make linux binary. Before that, we have to configure asdf
;; correctly, so that ASD files can be found.

(in-package :starwar)

(defun make-binary ()
  (sb-ext:save-lisp-and-die #+unix "starwar-linux"
                            #+win32 "starwar-win32.exe"
                            :toplevel #'starwar:main
                            :executable t))