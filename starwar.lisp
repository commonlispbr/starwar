#!/bin/sbcl --script


;; load quicklisp setup
(let ((sbclrc "~/.sbclrc"))
  (when (probe-file sbclrc)
    (load sbclrc)))

(eval-when (:execute)
  (pushnew (truename (sb-unix:posix-getcwd/))
           ql:*local-project-directories*)
  (ql:register-local-projects)
  (ql:quickload :starwar))

(defun main ()
  (defparameter starwar:fullscreen t)
  (starwar:main))

(eval-when (:execute)
  (main))
