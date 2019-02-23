(in-package :starwar)

(defun portable-pathname (pathname &optional (system 'starwar))
  "PORTABLE-PATHNAME consider two possible dirnames: local and system-wide."
  (if (probe-file pathname)
      pathname
      (asdf:system-relative-pathname system pathname)))
