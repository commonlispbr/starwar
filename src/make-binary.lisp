;; using this to make linux binary. Before that, we have to configure asdf
;; correctly, so that ASD files can be found.

(in-package :starwar)

(defparameter *compression* 9)
(defparameter *libprefix* "lib/")
(defvar *libraries* nil)
(defparameter *ld-library-path*
  (list "/lib/"
        "/usr/lib/"
        "/usr/lib/x86_64-linux-gnu/"))

(defun libpath (prefix)
  (merge-pathnames prefix (uiop/os:getcwd)))

(defun get-libraries-names (&key (loaded-only t))
  (remove-duplicates
   (mapcar #'cffi:foreign-library-pathname
           (cffi:list-foreign-libraries :loaded-only loaded-only))))

(defun get-libraries (&optional (from "/lib/"))
  (loop for l in (get-libraries-names)
        for lfrom = (merge-pathnames l from)
        for lpath = (probe-file lfrom)
        when lpath
          collect lfrom))

(defun search-libraries (&optional (paths *ld-library-path*))
  (loop for path in paths
        for libraries = (get-libraries path)
        when libraries
          return (progn
                   (format t "FOUND HOST LIBRARIES AT ~a~%" path)
                   libraries)))


(defun dump-libraries (&optional (to *libprefix*))
  (format t "~%LIBDUMP PATH: ~a~%" (libpath to))
  (ensure-directories-exist (libpath to))
  (let ((libs (search-libraries)))
    (setq *libraries* (get-libraries-names))
    (loop for lib in (get-libraries)
          do (sb-ext:run-program "/bin/cp"
                                 (list "-v"
                                       (namestring lib)
                                       (namestring (libpath to)))
                                 :output *standard-output*))))

(defun load-library (library-name)
  (cffi:load-foreign-library library-name))

(defun import-libraries (&optional (libpath *libprefix*))
  (pushnew libpath
           cffi:*foreign-library-directories*
           :test #'equal)
  (loop for l in *libraries*
        do (load-library l)))

(defun close-libraries ()
  (loop for library in (cffi:list-foreign-libraries :loaded-only t)
        do (cffi:close-foreign-library library)))

(defun main-wrapper ()
  (import-libraries)
  (starwar:main))


(defun make-binary ()
  (dump-libraries)  ;; put all libraries into /lib
  (close-libraries) ;; close currently open libraries
  (sb-ext:save-lisp-and-die #+unix "starwar-linux"
                            #+win32 "starwar-win32.exe"
                            :toplevel #'main-wrapper
                            :executable t
                            :compression *compression*))
