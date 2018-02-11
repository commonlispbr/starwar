(defpackage :starwar-lib-system
  (:use :cl :asdf))

(in-package :starwar-lib-system)

(defsystem starwar-lib
  :name "starwar-lib"
  :author "Peter Xu"
  :version "0.0.1"
  :licence "MIT"
  :description "Some basic functions related to game"
  :pathname "src/lib/"
  :depends-on (:lispbuilder-sdl)
  :components ((:file "packages")
               (:file "vector" :depends-on ("packages"))
               (:file "misc" :depends-on ("packages"
                                          "vector"))))
